package controller.client.order;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.client.OrderDAO;
import model.*;

@WebServlet(name = "OrderControll", value = "/OrderControll")
public class OrderControll extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String cityName = request.getParameter("cityName");
        String districtName = request.getParameter("districtName");
        String wardName = request.getParameter("wardName");

        double weight = Double.parseDouble(request.getParameter("total-weight"));
        String address = request.getParameter("address");
        String note = request.getParameter("notes");
        String status = "Đơn hàng đang chờ xác nhận";
        HttpSession session = request.getSession();

        // Lấy giá trị giảm giá từ session và chuyển đổi thành BigDecimal
        String discountValueStr = (String) session.getAttribute("discount");

        Account account = (Account) session.getAttribute("account");
        Map<Integer, OrderDetail> cart = Cart.readCartFromCookies(request, account.getId());

        if (cart != null) {
            Order order = new Order();
            String date = LocalDateTime.now().toString();
            order.setBookingDate(date);
            order.setAccount(account);
            order.setConsigneeName(name);
            order.setConsigneePhone(phone);
            // Chuyển đổi BigDecimal thành double
            if(discountValueStr!=null) {
                BigDecimal discountValue = new BigDecimal(discountValueStr);
                order.setDiscountValue(discountValue.doubleValue());
            }
            order.setOrderStatus(status);
            order.setAddress(address + ", " + wardName + ", " + districtName + ", " + cityName);
            order.setOrderNotes(note);
            Payment p = new Payment();
            p.setId(3);
            order.setPayment(p);
            double total = 0;
            List<OrderDetail> detailList = new ArrayList<>();
            for (Entry<Integer, OrderDetail> entry : cart.entrySet()) {
                OrderDetail orderDetail = entry.getValue();
                orderDetail.setOrder(order);
                detailList.add(orderDetail);
                total += orderDetail.getPrice();
            }
            order.setTotalMoney(total);
            try {
                double ship = APIGetShippingFee.calculateShippingFee(cityName, districtName, wardName, address, weight, order.getTotalMoney());
                order.setShip(ship);
                System.out.println("Ship Money: " + ship);
            } catch (Exception e) {
                e.printStackTrace();
            }

            session.setAttribute("bill", order);
            session.setAttribute("billDetail", detailList);

            request.getRequestDispatcher("/WEB-INF/client/payment.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("/WEB-INF/client/cart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
