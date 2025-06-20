package controller.client.order;

import dao.client.OrderDAO;
import model.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MomoReturnController", value = "/momo_return")
public class MomoReturnController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        Order order = (Order) session.getAttribute("momo_order");
        List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("momo_orderDetail");

        if (order != null && orderDetail != null && account != null) {
            try {
                // Ghi đơn hàng vào database
                OrderDAO.insertOrder(order);
                OrderDAO.setCurrentIdBill(order);

                for (OrderDetail od : orderDetail) {
                    od.setOrder(order);
                    OrderDAO.insertOrderdetail(od);
                }

                // Xóa giỏ hàng cookie
                Cart.deleteCartToCookies(request, response, account.getId());
                session.setAttribute("size", 0);

                // Xóa dữ liệu tạm
                session.removeAttribute("momo_order");
                session.removeAttribute("momo_orderDetail");

                // Redirect tới trang thông báo thành công
                response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý sau khi thanh toán MoMo");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/payment.jsp?error=Thông+tin+thiếu+vui+lòng+thanh+toán+lại");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
