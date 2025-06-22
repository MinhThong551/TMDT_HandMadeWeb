<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProductCustom" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn Hàng Tùy Chỉnh</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/css/styles.css">
</head>
<body>
<h1>Thông Tin Đơn Hàng Tùy Chỉnh</h1>
<%
    ProductCustom product = (ProductCustom) request.getAttribute("product");
    if (product != null) {
%>
<p><strong>Loại sản phẩm:</strong> <%= product.getProductType() != null ? product.getProductType() : "Chưa xác định" %></p>
<p><strong>Số lượng:</strong> <%= product.getQuantity() > 0 ? product.getQuantity() : 0 %></p>
<% if ("bag".equals(product.getProductType())) { %>
<p><strong>Màu dây túi:</strong> <%= product.getStrapColor() != null ? product.getStrapColor() : "Chưa chọn" %></p>
<p><strong>Màu thân túi:</strong> <%= product.getBodyColor() != null ? product.getBodyColor() : "Chưa chọn" %></p>
<p><strong>Màu hoa:</strong> <%= product.getFlowerColor() != null ? product.getFlowerColor() : "Chưa chọn" %></p>
<% } else if ("bear".equals(product.getProductType())) { %>
<p><strong>Màu thân gấu:</strong> <%= product.getBearBodyColor() != null ? product.getBearBodyColor() : "Chưa chọn" %></p>
<p><strong>Màu mũi:</strong> <%= product.getBearNoseColor() != null ? product.getBearNoseColor() : "Chưa chọn" %></p>
<p><strong>Màu ruy băng:</strong> <%= product.getBearRibbonColor() != null ? product.getBearRibbonColor() : "Chưa chọn" %></p>
<p><strong>Vị trí nơ:</strong> <%= product.getRibbonPosition() != null ? product.getRibbonPosition() : "Chưa chọn" %></p>
<% } %>
<% } else { %>
<p>Không có dữ liệu tùy chỉnh.</p>
<% } %>
</body>
</html>