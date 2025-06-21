package controller.client.order;

import dao.client.OrderDAO;
import model.Account;
import model.Cart;
import model.Order;
import model.OrderDetail;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PaypalPaymentSuccessControll")
public class PaypalPaymentSuccessControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Order order = (Order) session.getAttribute("paypal_order");
        List<OrderDetail> orderDetails = (List<OrderDetail>) session.getAttribute("paypal_orderDetail");

        try {
            OrderDAO.insertOrder(order);
            OrderDAO.setCurrentIdBill(order);

            for (OrderDetail od : orderDetails) {
                od.setOrder(order);
                OrderDAO.insertOrderdetail(od);
            }

            Cart.deleteCartToCookies(request, response, account.getId());
            session.setAttribute("size", 0);

            response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}
