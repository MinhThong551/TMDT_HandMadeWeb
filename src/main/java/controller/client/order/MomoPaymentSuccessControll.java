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

@WebServlet(name = "MomoPaymentSuccessControll", value = "/MomoPaymentSuccessControll")
public class MomoPaymentSuccessControll extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account account = (Account) session.getAttribute("account");
        Order order = (Order) session.getAttribute("momo_order");
        List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("momo_orderDetail");

        if (order != null && orderDetail != null) {
            try {
                OrderDAO.insertOrder(order);
                OrderDAO.setCurrentIdBill(order);

                for (OrderDetail od : orderDetail) {
                    od.setOrder(order);
                    OrderDAO.insertOrderdetail(od);
                }

                Cart.deleteCartToCookies(request, response, account.getId());
                session.setAttribute("size", 0);

                // Xóa session tạm
                session.removeAttribute("momo_order");
                session.removeAttribute("momo_orderDetail");

                response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý đơn hàng MoMo");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
