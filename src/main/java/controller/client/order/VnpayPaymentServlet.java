package controller.client.order;

import util.VnpayConfig;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/vnpay-payment")
public class VnpayPaymentServlet extends HttpServlet {

    private static final String vnp_TmnCode = VnpayConfig.VNP_TMNCODE;
    private static final String vnp_HashSecret = VnpayConfig.VNP_HASH_SECRET;
    private static final String vnp_PayUrl = VnpayConfig.VNP_PAY_URL;
    private static final String vnp_ReturnUrl = VnpayConfig.VNP_RETURN_URL;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String rawAmount = request.getParameter("amount");
        String qrOnly = request.getParameter("qrOnly");

        // Xử lý số tiền với độ chính xác cao
        BigDecimal amount = new BigDecimal(rawAmount)
                .multiply(BigDecimal.valueOf(100))
                .setScale(0, RoundingMode.HALF_UP);

        String orderInfo = "Thanh toan don hang handmade";
        String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
        String vnp_IpAddr = request.getRemoteAddr();

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", amount.toPlainString());
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", orderInfo);
        vnp_Params.put("vnp_OrderType", "other");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

        // DEBUG thông tin trước khi hash
        System.out.println("=== VNPAY PARAMS BEFORE HASH ===");
        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // Build hashData và query
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
            String value = vnp_Params.get(fieldName);
            hashData.append(fieldName).append('=').append(value).append('&');
            query.append(fieldName).append('=').append(encodeURIComponent(value)).append('&');
        }

        hashData.setLength(hashData.length() - 1);
        query.setLength(query.length() - 1);

        String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        String paymentUrl = vnp_PayUrl + "?" + query;

        // Log cuối cùng
        System.out.println("=== VNPAY - VnpayPaymentServlet ===");
        System.out.println("Raw Amount Param: " + rawAmount);
        System.out.println("Amount x100: " + amount);
        System.out.println("HashData: " + hashData);
        System.out.println("SecureHash: " + secureHash);
        System.out.println("Redirect URL: " + paymentUrl);

        // Nếu là chế độ hiển thị QR
        if ("true".equals(qrOnly)) {
            request.setAttribute("qrUrl", paymentUrl);
            try {
                request.getRequestDispatcher("/WEB-INF/client/vnpay_qr.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi forward đến trang QR");
            }
        } else {
            response.sendRedirect(paymentUrl);
        }
    }

    private String encodeURIComponent(String s) {
        return URLEncoder.encode(s, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
    }

    private String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return DatatypeConverter.printHexBinary(bytes).toLowerCase();
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
