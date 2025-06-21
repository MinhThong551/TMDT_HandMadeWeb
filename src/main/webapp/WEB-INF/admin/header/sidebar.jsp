<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<html>
<style>
    .sidebar-offcanvas {
        color: #ffffff; !important;
    }
    .sidebar .sidebar-brand-wrapper {
        background: #FFFFFF; !important;
    }
    .sidebar .nav .nav-item.active > .nav-link
    {
        background: #343a40;
    }

    .sidebar .sidebar-brand-wrapper .sidebar-brand img {
        max-width: 100%;
        margin: auto;
        vertical-align: middle;
        padding: 0;
        height: max-content;
    }
</style>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
        <a class="sidebar-brand" href="IndexAdminControll">
            <img src="assetsAD/img/auth/logo.png" alt="logo"/>
        </a>
    </div>
    <c:set scope="session" var="acc" value="${sessionScope.account}"></c:set>
    <ul class="nav">
        <li class="nav-item nav-category">
            <span class="nav-link">MENU ADMIN</span>
        </li>
        <c:if test="${acc.role.id==1}">
            <li class="nav-item menu-items">
                <a class="nav-link" href="IndexAdminControll">
              <span class="menu-icon">
                <i class="mdi mdi-speedometer"></i>
              </span>
                    <span class="menu-title">Dashboard</span>
                </a>
            </li>
        </c:if>
        <c:if test="${acc.role.id == 2 or acc.role.id == 1}">
            <li class="nav-item menu-items">
                <a class="nav-link" href="./LoadUserPage">
              <span class="menu-icon">
                <i class="mdi mdi-account"></i>
              </span>
                    <span class="menu-title">Quản lý người dùng</span>
                </a>
            </li>
        </c:if>
        <c:set var="page" value="${param.page}"/>
        <c:if test="${acc.role.id == 4 or acc.role.id == 1}">
            <li class="nav-item menu-items">
                <a class="nav-link" data-toggle="collapse" href="#ui-basic"
                   aria-expanded="${page == 'products' || page == 'inventory' || page == 'expired'}"
                   aria-controls="ui-basic">
                    <span class="menu-icon">
                        <i class="mdi mdi-laptop"></i>
                    </span>
                    <span class="menu-title">Kho</span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse ${page == 'products' || page == 'inventory' || page == 'expired' ? 'show' : ''}"
                     id="ui-basic">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item">
                            <a class="nav-link ${page == 'products' ? 'active' : ''}" href="./LoadProductsPage">Danh
                                sách sản phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${page == 'inventory' ? 'active' : ''}"
                               href="./LoadInventoryProductPage">Tồn kho</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${page == 'expired' ? 'active' : ''}" href="./LoadExpiredProductPage">Sản
                                phẩm hết hạn</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="nav-item menu-items">
                <a class="nav-link" data-toggle="collapse" href="#ui-basic-2"
                   aria-expanded="${page == 'addNew' || page == 'addBatch' || page == 'statBatch'}"
                   aria-controls="ui-basic-2">
                    <span class="menu-icon">
                        <i class="mdi mdi-folder"></i>
                    </span>
                    <span class="menu-title">Nhập kho</span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse ${page == 'addNew' || page == 'addBatch' || page == 'statBatch' ? 'show' : ''}"
                     id="ui-basic-2">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item">
                            <a class="nav-link ${page == 'addNew' ? 'active' : ''}" href="./AddProductControll">Sản phẩm
                                mới</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${page == 'addBatch' ? 'active' : ''}" href="./AddBatchControll">Đã có
                                trong kho</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${page == 'statBatch' ? 'active' : ''}" href="./LoadBatch">Thống kê nhập
                                kho</a>
                        </li>
                    </ul>
                </div>
            </li>
        </c:if>

        <c:if test="${acc.role.id == 3 or acc.role.id == 1}">
            <li class="nav-item menu-items">
                <a class="nav-link" href="./LoadBillControll">
              <span class="menu-icon">
                <i class="mdi mdi-book"></i>
              </span>
                    <span class="menu-title">Quản lý đơn hàng</span>
                </a>
            </li>
        </c:if>

        <c:if test="${acc.role.id == 1}">
            <li class="nav-item menu-items">
                <a class="nav-link" href="./LoadLogPageControll">
              <span class="menu-icon">
                <i class="mdi mdi-security"></i>
              </span>
                    <span class="menu-title">Quản lý log</span>
                </a>
            </li>


            <li class="nav-item menu-items">
                <a class="nav-link" href="./LoadMangeVoucherControll">
              <span class="menu-icon">
                <i class="mdi mdi-sale"></i>
              </span>
                    <span class="menu-title">Quản lý voucher</span>
                </a>
            </li>
            <li class="nav-item menu-items">
                <a class="nav-link" href="./LoadManageReviewControll">
              <span class="menu-icon">
                <i class="mdi mdi-comment"></i>
              </span>
                    <span class="menu-title">Quản lý review</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>
</html>