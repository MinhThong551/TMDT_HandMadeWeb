package controller.client.order;

import dao.client.OrderDAO;
import model.*;
import util.VnpayConfig;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet("/vnpay-return")
public class VnpayReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = fields.remove("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");

        // Build hash
        String hashData = buildHashData(fields);
        String calculatedHash = hmacSHA512(VnpayConfig.VNP_HASH_SECRET, hashData);

        // === LOG DEBUG CHI TIẾT ===
        System.out.println("=== VNPAY - VnpayReturnServlet ===");
        System.out.println("Raw VNPAY Return Params:");
        fields.forEach((k, v) -> System.out.println(k + " = " + v));
        System.out.println("HashData to check: " + hashData);
        System.out.println("Client SecureHash: " + vnp_SecureHash);
        System.out.println("Calculated SecureHash: " + calculatedHash);
        System.out.println("Response Code: " + request.getParameter("vnp_ResponseCode"));

        if (vnp_SecureHash != null && vnp_SecureHash.equals(calculatedHash)) {
            String responseCode = request.getParameter("vnp_ResponseCode");

            if ("00".equals(responseCode)) {
                HttpSession session = request.getSession();
                Account account = (Account) session.getAttribute("account");
                Order order = (Order) session.getAttribute("bill");
                List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("billDetail");

                System.out.println("Session Bill: " + order);
                System.out.println("Session BillDetail size: " + (orderDetail != null ? orderDetail.size() : "null"));
                System.out.println("Account: " + account);

                if (order != null && orderDetail != null && account != null) {
                    Payment payment = new Payment();
                    payment.setId(5); // VNPAY
                    order.setPayment(payment);

                    try {
                        OrderDAO.insertOrder(order);
                        OrderDAO.setCurrentIdBill(order);

                        for (OrderDetail od : orderDetail) {
                            od.setOrder(order);
                            OrderDAO.insertOrderdetail(od);
                        }

                        Cart.deleteCartToCookies(request, response, account.getId());
                        session.setAttribute("size", 0);

                        response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
                        return;
                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("message", "Thanh toán thành công nhưng lỗi khi lưu đơn hàng.");
                    }
                } else {
                    request.setAttribute("message", "Thiếu thông tin đơn hàng hoặc người dùng.");
                }
            } else {
                request.setAttribute("message", "Thanh toán thất bại. Mã lỗi: " + responseCode);
            }
        } else {
            request.setAttribute("message", "❌ Xác thực chữ ký VNPAY không hợp lệ.");
        }

        request.getRequestDispatcher("/WEB-INF/client/checkout.jsp").forward(request, response);
    }

    private String buildHashData(Map<String, String> fields) {
        List<String> sortedKeys = new ArrayList<>(fields.keySet());
        Collections.sort(sortedKeys);
        StringBuilder sb = new StringBuilder();
        for (String key : sortedKeys) {
            sb.append(key).append('=').append(fields.get(key)).append('&');
        }
        sb.setLength(sb.length() - 1); // Xoá dấu & cuối
        return sb.toString();
    }

    private String hmacSHA512(String key, String data) {
        try {
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKey);
            byte[] bytes = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            return DatatypeConverter.printHexBinary(bytes).toLowerCase();
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
