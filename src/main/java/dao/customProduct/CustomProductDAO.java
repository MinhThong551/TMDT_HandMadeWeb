package dao.customProduct;

import model.ProductCustom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CustomProductDAO {
    public void saveProduct(HttpServletRequest request, ProductCustom product) {
        HttpSession session = request.getSession();
        if (session != null && product != null) {
            session.setAttribute("product", product);
        }
    }
}
