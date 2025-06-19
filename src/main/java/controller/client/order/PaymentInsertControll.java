package controller.client.order;

import dao.client.OrderDAO;
import model.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PaymentInsertControll", value = "/PaymentInsertControll")
public class PaymentInsertControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập mã hóa
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        // Lấy dữ liệu từ session
        Account account = (Account) session.getAttribute("account");
        Order order = (Order) session.getAttribute("bill");
        List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("billDetail");

        // Lấy phương thức thanh toán từ form
        String paymentMethodParam = request.getParameter("paymentMethod");

        if (order != null && orderDetail != null && paymentMethodParam != null) {
            try {
                // Gán payment_id vào Order
                int paymentId;
                if (paymentMethodParam.equals("cod")) {
                    paymentId = 1; // Thanh toán khi nhận hàng
                } else if (paymentMethodParam.equals("qr")) {
                    paymentId = 2; // Quét mã QR
                } else {
                    throw new IllegalArgumentException("Phương thức thanh toán không hợp lệ");
                }

                Payment payment = new Payment();
                payment.setId(paymentId);
                order.setPayment(payment);

                // Insert đơn hàng vào DB
                OrderDAO.insertOrder(order);
                OrderDAO.setCurrentIdBill(order); // Gán id cho order

                // Insert chi tiết đơn hàng
                for (OrderDetail od : orderDetail) {
                    od.setOrder(order); // Gán lại order có id
                    OrderDAO.insertOrderdetail(od);
                }

                // Xóa giỏ hàng cookie
                Cart.deleteCartToCookies(request, response, account.getId());

                // Reset size giỏ hàng
                session.setAttribute("size", 0);

                // Điều hướng đến trang thông báo thành công
                response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý thanh toán");
            }
        } else {
            // Nếu thiếu thông tin thì quay lại trang thanh toán
            request.setAttribute("error", "Thiếu thông tin đơn hàng hoặc phương thức thanh toán");
            request.getRequestDispatcher("/WEB-INF/client/payment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Cho phép xử lý cả bằng POST nếu cần
    }
}
