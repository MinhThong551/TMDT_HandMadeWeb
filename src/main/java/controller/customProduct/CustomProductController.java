package controller.customProduct;


import com.google.gson.Gson;
import dao.client.ProductDAO;
import dao.customProduct.CustomProductDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

//@WebServlet("/custom1")
public class CustomProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomProductDAO customProductDAO = new CustomProductDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/client/customProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đặt kiểu nội dung phản hồi
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            // Lấy dữ liệu JSON từ request
            String jsonData = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
            Gson gson = new Gson();
            ProductCustom productCustom = gson.fromJson(jsonData, ProductCustom.class);

            // Kiểm tra dữ liệu hợp lệ
            if (productCustom == null) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Dữ liệu không hợp lệ\"}");
                return;
            }

            // Kiểm tra đăng nhập
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\", \"redirect\": \"/login.jsp\"}");
                return;
            }

            // Tạo mô tả sản phẩm từ ProductCustom
            String description = String.format(
                    "Sản phẩm tùy chỉnh: Loại=%s, Số lượng=%d, Màu thân gấu=%s, Màu mũi gấu=%s, Màu ruy băng gấu=%s, Vị trí ruy băng=%s",
                    productCustom.getProductType(),
                    productCustom.getQuantity(),
                    productCustom.getBearBodyColor(),
                    productCustom.getBearNoseColor(),
                    productCustom.getBearRibbonColor(),
                    productCustom.getRibbonPosition()
            );

            // Tạo đối tượng Product mới
            Product product = new Product();

            // THAY ĐỔI: Không đặt ID sản phẩm, để cơ sở dữ liệu tự tạo
            // product.setId(productId); - Bỏ dòng này

            product.setName("Gấu Bông Tùy Chỉnh - " + productCustom.getProductType());
            product.setPrice(calculatePrice(productCustom));
            product.setImage("/images/gaubong.jpg");
            product.setDescription(description);
            product.setCategory(new Category(4)); // Giả sử category 1 là cho sản phẩm tùy chỉnh

            // THAY ĐỔI: Lưu sản phẩm và lấy ID được tạo
            int productId = ProductDAO.insertProduct(product); // Sửa lại phương thức để trả về ID mới

            // Lấy sản phẩm đã lưu từ cơ sở dữ liệu để có thông tin đầy đủ
            Product savedProduct = ProductDAO.getProductById(productId);

            if (savedProduct == null) {
                throw new SQLException("Không thể lưu hoặc truy xuất sản phẩm.");
            }

            // Đọc giỏ hàng từ cookie
            Map<Integer, OrderDetail> cart = Cart.readCartFromCookies(request, account.getId());

            // Tạo OrderDetail mới
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProduct(savedProduct);
            orderDetail.setProductPrice(savedProduct.getPrice());
            orderDetail.setQuantity(productCustom.getQuantity());
            orderDetail.setPrice(savedProduct.getPrice() * productCustom.getQuantity());

            // Thêm vào giỏ hàng
            cart.put(productId, orderDetail);

            // Lưu giỏ hàng vào cookie
            Cart.writeCartToCookies(request, response, cart, account.getId());

            // Lưu ProductCustom vào session (nếu cần)
            customProductDAO.saveProduct(request, productCustom);

            // Trả về JSON thành công và chuyển hướng đến CartControll
            int sizeCart = cart.size();
            session.setAttribute("size", sizeCart);
            response.getWriter().write("{\"success\": true, \"message\": \"Đã thêm sản phẩm vào giỏ hàng\", \"redirect\": \"/CartControll\", \"size\": " + sizeCart + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xử lý sản phẩm: " + e.getMessage() + "\"}");
        }
    }


    private double calculatePrice(ProductCustom productCustom) {
        double basePrice = 100000; // Giá cơ bản (VND)
        if ("cao cấp".equalsIgnoreCase(productCustom.getProductType())) {
            basePrice += 50000;
        }
        basePrice += productCustom.getQuantity() * 10000;
        return basePrice;
    }
}
