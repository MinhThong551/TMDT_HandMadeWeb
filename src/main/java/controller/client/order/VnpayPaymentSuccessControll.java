package controller.client.order;

import dao.client.OrderDAO;
import model.Account;
import model.Cart;
import model.Order;
import model.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;


@WebServlet("/VnpayPaymentSuccessControll")
public class VnpayPaymentSuccessControll extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        Order order = (Order) session.getAttribute("vnpay_order");
        List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("vnpay_orderDetail");
        Account account = (Account) session.getAttribute("account");

        if (order != null && orderDetail != null && account != null) {
            try {
                // Lưu đơn hàng
                OrderDAO.insertOrder(order);
                OrderDAO.setCurrentIdBill(order);

                for (OrderDetail od : orderDetail) {
                    od.setOrder(order);
                    OrderDAO.insertOrderdetail(od);
                }

                Cart.deleteCartToCookies(request, response, account.getId());
                session.setAttribute("size", 0);

                session.removeAttribute("vnpay_order");
                session.removeAttribute("vnpay_orderDetail");

                response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xác nhận thanh toán VNPAY");
            }
        } else {
            request.setAttribute("error", "Không tìm thấy thông tin đơn hàng để xử lý VNPAY");
            request.getRequestDispatcher("/WEB-INF/client/payment.jsp").forward(request, response);
        }
    }
}
