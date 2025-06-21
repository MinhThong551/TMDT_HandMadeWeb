package controller.client.order;

import model.Order;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet("/paypal-payment")
public class PaypalPaymentServlet extends HttpServlet {
    private static final String CLIENT_ID = "Abo90Wztq8vanhzw0EO5zMhum7b1O6aI_1x4BTA8v7jqNIOGdthWxF-ZZpjhtEGg6CW0VWRdgg_hjdlb"; // 👉 Replace with real ID
    private static final String CLIENT_SECRET = "EEpPKUqIRD0gJPVKHVai84Yi0lauKUq3brqUN2AYkeIq1GHGbBJy_fA_q3bvj8Ha7cFZByFGKRvYyzro"; // 👉 Replace with real secret
    private static final String PAYPAL_API_BASE = "https://api-m.sandbox.paypal.com";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("paypal_order");

        if (order == null) {
            response.getWriter().println("Không tìm thấy đơn hàng PayPal trong session.");
            return;
        }

        // Get PayPal Access Token
        String auth = Base64.getEncoder().encodeToString((CLIENT_ID + ":" + CLIENT_SECRET).getBytes());
        HttpURLConnection tokenConn = (HttpURLConnection) new URL(PAYPAL_API_BASE + "/v1/oauth2/token").openConnection();
        tokenConn.setRequestMethod("POST");
        tokenConn.setRequestProperty("Authorization", "Basic " + auth);
        tokenConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        tokenConn.setDoOutput(true);
        try (OutputStream os = tokenConn.getOutputStream()) {
            os.write("grant_type=client_credentials".getBytes());
        }

        StringBuilder tokenResp = new StringBuilder();
        try (Scanner scanner = new Scanner(tokenConn.getInputStream())) {
            while (scanner.hasNext()) tokenResp.append(scanner.nextLine());
        }

        String accessToken = new JSONObject(tokenResp.toString()).getString("access_token");

        // Tính tổng đơn hàng USD (giả định tỉ giá 1 USD = 24.000 VND)
        BigDecimal totalUsd = BigDecimal.valueOf(order.getTotalMoney() + order.getShip())
                .divide(BigDecimal.valueOf(24000), 2, RoundingMode.HALF_UP);

        // URLs
        String returnUrl = request.getRequestURL().toString().replace("paypal-payment", "PaypalPaymentSuccessControll");
        String cancelUrl = request.getRequestURL().toString().replace("paypal-payment", "paypal-cancel");

        // Create PayPal Order
        HttpURLConnection orderConn = (HttpURLConnection) new URL(PAYPAL_API_BASE + "/v2/checkout/orders").openConnection();
        orderConn.setRequestMethod("POST");
        orderConn.setRequestProperty("Authorization", "Bearer " + accessToken);
        orderConn.setRequestProperty("Content-Type", "application/json");
        orderConn.setDoOutput(true);

        String jsonBody = String.format("""
                {
                  "intent": "CAPTURE",
                  "purchase_units": [{
                    "amount": {
                      "currency_code": "USD",
                      "value": "%s"
                    }
                  }],
                  "application_context": {
                    "return_url": "%s",
                    "cancel_url": "%s"
                  }
                }
                """, totalUsd.toPlainString(), returnUrl, cancelUrl);

        try (OutputStream os = orderConn.getOutputStream()) {
            os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
        }

        StringBuilder orderResp = new StringBuilder();
        try (Scanner scanner = new Scanner(orderConn.getInputStream())) {
            while (scanner.hasNext()) orderResp.append(scanner.nextLine());
        }

        JSONObject json = new JSONObject(orderResp.toString());
        String approvalLink = json.getJSONArray("links").toList().stream()
                .map(o -> new JSONObject((Map<?, ?>) o))
                .filter(link -> link.getString("rel").equals("approve"))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Không tìm thấy approval URL"))
                .getString("href");

        response.sendRedirect(approvalLink);
    }
}
