package controller.client.order;

import dao.client.OrderDAO;
import model.*;
import util.PaymentRequest;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "PaymentInsertControll", value = "/PaymentInsertControll")
public class    PaymentInsertControll extends HttpServlet {
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
                int paymentId;

                if (paymentMethodParam.equals("cod")) {
                    paymentId = 2; // Thanh toán khi nhận hàng
                } else if (paymentMethodParam.equals("qr")) {
                    paymentId = 1; // Quét mã QR
                } else if (paymentMethodParam.equals("momo")) {
                    paymentId = 4;

                    // Gán phương thức thanh toán
                    Payment payment = new Payment();
                    payment.setId(paymentId);
                    order.setPayment(payment);

                    // Lưu tạm để xử lý sau
                    session.setAttribute("momo_order", order);
                    session.setAttribute("momo_orderDetail", orderDetail);

                    // Forward đến trang hiển thị QR
                    String qrPath = "/images/momo-qr-thong.png"; // hoặc ảnh bạn muốn
                    request.setAttribute("qrUrl", qrPath);// hoặc link ảnh
                    request.getRequestDispatcher("/WEB-INF/client/momo_qr.jsp").forward(request, response);

                    return;
                } else {
                    throw new IllegalArgumentException("Phương thức thanh toán không hợp lệ");
                }

                // Xử lý COD hoặc QR nội bộ
                Payment payment = new Payment();
                payment.setId(paymentId);
                order.setPayment(payment);

                OrderDAO.insertOrder(order);
                OrderDAO.setCurrentIdBill(order);

                for (OrderDetail od : orderDetail) {
                    od.setOrder(order);
                    OrderDAO.insertOrderdetail(od);
                }

                Cart.deleteCartToCookies(request, response, account.getId());
                session.setAttribute("size", 0);

                response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý thanh toán");
            }
        } else {
            request.setAttribute("error", "Thiếu thông tin đơn hàng hoặc phương thức thanh toán");
            request.getRequestDispatcher("/WEB-INF/client/payment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
