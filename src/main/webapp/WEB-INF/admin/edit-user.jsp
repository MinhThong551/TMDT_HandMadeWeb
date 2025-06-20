
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@page isELIgnored="false" %>
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
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-title">Sửa thông tin người dùng</div>
                                    <hr>
                                    <c:url var="editP" value="EditUser"></c:url>
                                    <form action="${pageContext.request.contextPath}/${editP}"
                                          method="post">

                                        <div class="form-group">
                                            <label for="input-1">Mã người dùng</label> <input type="text"
                                                                                            class="form-control" style="background-color: black;"
                                                                                            id="input-1" readonly="readonly" placeholder="ID"
                                            value="${account.id}" name="account-id">
                                        </div>

                                        <div class="form-group">
                                            <label for="input-2">Tên người dùng</label> <input type="text"
                                                                                             class="form-control" id="input-2"
                                                                                             placeholder="Tên người dùng" name="account-name"
                                                                                             value="${account.name}">
                                        </div>

                                        <div class="form-group">
                                            <label for="input-3">Mật khẩu người dùng</label> <input type="text"
                                                                                               class="form-control" id="input-3"
                                                                                               placeholder="Mật khẩu người dùng" name="account-password"
                                                                                               value="${account.password}">
                                        </div>


                                        <div class="form-group">
                                            <label for="input-4">Email</label> <input type="text"
                                                                                    class="form-control" id="input-4" placeholder="Email"
                                                                                    name="account-email" value="${account.email}">
                                        </div>

                                        <div class="form-group">
                                            <label for="input-5">Số điện thoại</label> <input type="text"
                                                                                               class="form-control" id="input-5"
                                                                                               placeholder="Tên người dùng" name="account-phone"
                                                                                               value="${account.telephone}">
                                        </div>


                                        <div class="form-footer">
                                            <a class="btn btn-danger"
                                               href="./LoadUserPage">Hủy</a>
                                            <button type="submit" class="btn btn-success">Cập
                                                nhật</button>
                                        </div>
                                    </form>
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

</body>
</html>