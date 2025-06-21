<%--suppress ALL --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page isELIgnored="false" %>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Product</title>
    <!-- plugins:css -->
    <jsp:include page="./link/link.jsp"></jsp:include>
    <style>
        body,
        .container-scroller,
        .content-wrapper,
        .main-panel,
        .card,
        .card-title,
        .navbar,
        .sidebar,
        .table,
        .footer {
            background-color: #ffffff !important;
            color: #000000 !important;
        }

        .bg-gray-dark {
            background-color: #f0f0f0 !important;
            color: #000000 !important;
        }

        .text-muted {
            color: #666666 !important;
        }

        .btn,
        .btn-success,
        .btn-danger,
        .btn-warning {
            color: white !important;
        }

        .sidebar,
        .navbar {
            background-color: #eaeaea !important;
        }

        .modal-contents {
            background-color: #ffffff !important;
            color: #000000 !important;
        }

        input,
        select,
        textarea {
            background-color: #ffffff !important;
            color: #000000 !important;
            border: 1px solid #ccc;
        }

        a {
            color: #007bff !important;
        }

        a:hover {
            color: #0056b3 !important;
        }

        .icon-box-success {
            background-color: #d4edda !important;
            color: #155724 !important;
        }

        .icon-box-danger {
            background-color: #f8d7da !important;
            color: #721c24 !important;
        }

        .icon-item {
            color: #000 !important;
        }

        .form-group img,
        .form-group ul,
        .form-group li {
            line-height: 1.7;
        }

        .form-group img {
            border-radius: 8px;
            margin: 5px 10px 10px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-group p {
            line-height: 1.7;
            font-size: 17px;
        }

        .form-group label {
            font-size: 18px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .form-footer {
            margin-top: 20px;
        }

        #exitButton {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s ease;
        }

        #exitButton:hover {
            background-color: #c82333 !important;
            color: white !important;
        }

        .form-columns {
            display: flex;
            gap: 40px;
        }

        .form-left, .form-right {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="container-scroller">
    <jsp:include page="./header/sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="./header/navbar.jsp"></jsp:include>
        <div class="main-panel">

            <div class="content-wrapper">
                <div class="container-fluid">

                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <div class="card" style="background-color: white">
                                <div class="card-body">
                                    <div class="card-title" style="color:#000;">Thông tin sản phẩm</div>
                                    <hr>
                                    <div class="form-columns">
                                        <div class="form-left">
                                            <div class="form-group">
                                                <label>1. Mã sản phẩm: </label>
                                                <p>${product.id}</p>
                                            </div>
                                            <div class="form-group">
                                                <label>2. Tên sản phẩm: </label>
                                                <p>${product.name}</p>
                                            </div>
                                            <div class="form-group">
                                                <label>3. Giá: </label>
                                                <p>${product.price}</p>
                                            </div>
                                            <div class="form-group">
                                                <label>4. Cân nặng: </label>
                                                <p>${product.weight}</p>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-form-label">5.Mô tả</label>
                                                <p>${product.description}</p>
                                            </div>
                                            <div class="form-group">
                                                <label>6.Hình chính</label>
                                                <p><img src="${product.image}" alt="${product.name}"
                                                        style="width: 130px;height: 130px"></p>
                                            </div>
                                            <div class="form-group">
                                                <label>7.Danh sách hình phụ</label><br>
                                                <c:forEach var="image" items="${listImage}">
                                                    <img src="${image.url}" style="width: 130px;height: 130px">
                                                </c:forEach>
                                            </div>

                                            <div class="form-group">
                                                <label>8.Phân loại</label>
                                                <p> Mã loại sản phẩm:${category.id}</p>
                                                <p> Tên loại sản phẩm: ${category.name}</p>
                                            </div>
                                        </div>
                                        <div class="form-right">
                                            <div class="form-group">
                                                <label>9.Thông tin các lô hàng</label>
                                                <ul>
                                                    <c:forEach var="o" items="${listBatch}" varStatus="loop">
                                                        <li><b>Lô hàng ${loop.index + 1}</b>
                                                            <ul>
                                                                <li>Mã lô: ${o.id}</li>
                                                                <li>Tên lô: ${o.name}${loop.index + 1}</li>
                                                                <li>Ngày sản xuất: ${o.manufacturingDate}</li>
                                                                <li>Hạn sử dụng: ${o.expiryDate}</li>
                                                                <li>Ngày nhập hàng: ${o.dateOfImporting}</li>
                                                                <li>Số lượng: ${o.quantity}</li>
                                                                <li>Nhà cung cấp:
                                                                    <ul>
                                                                        <li>Mã nhà cung cấp: ${o.provider.id}</li>
                                                                        <li>Tên nhà cung cấp: ${o.provider.name}</li>
                                                                        <li>Địa chỉ nhà cung
                                                                            cấp: ${o.provider.address}</li>
                                                                    </ul>
                                                                </li>
                                                                <li>Giá nhập: ${o.priceImport}</li>
                                                            </ul>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-footer">
                                        <a class="btn btn-danger" id="exitButton">Thoát</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="overlay toggle-menu"></div>
            </div>
        </div>
    </div>
    <!-- main-panel ends -->
</div>
<!-- page-body-wrapper ends -->
</div>
<jsp:include page="./footer/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Thêm liên kết tới DataTables JS (nếu cần) -->
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>

<script>
    $(document).ready(function () {
        // Lấy URL của trang trước đó
        var previousUrl = document.referrer;

        // Kiểm tra nếu có URL của trang trước đó
        if (previousUrl) {
            $('#exitButton').attr('href', previousUrl);
        } else {
            // Nếu không có trang trước đó, điều hướng đến một trang mặc định
            $('#exitButton').attr('href', './LoadProductsPage');
        }
    });
</script>
</body>
</html>