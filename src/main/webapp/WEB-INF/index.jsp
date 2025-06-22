<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html lang="zxx">

<head>
    <%@ page isELIgnored="false" %>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Golden Fields</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Css Styles -->
    <jsp:include page="client/link/link.jsp"></jsp:include>
    <style>
        .container .row .col-lg-6 ul li {
            margin-right: 30px;
        }

        button {
            background: #17c6c6;
        }

        .site-btn {
            background: #17c6c6;
        }
    </style>
</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>

<span class="header__fixed">
	<jsp:include page="client/header/header.jsp"></jsp:include>

</span>


<div class="container">
    <div class="hero__item set-bg" data-setbg="assets/img/banner.png">
        <div class="hero__text">
            <span>ĐỒ HANDMADE TINH TẾ</span>
            <h2>Móc khoá & Quà tặng<br/>100% Thủ công</h2>
            <p>Nhận đặt hàng và giao tận nơi miễn phí</p>
            <a href="./ShowProductControl" class="primary-btn">MUA HÀNG</a>
        </div>
    </div>
    <br><br><br>
</div>
<section class="categories">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <c:forEach var="p" items="${listTop}">
                    <div class="col-lg-3">
                        <div class="categories__item set-bg">
                            <a href="${detail}?pid=${p.id}"><img src="${p.image}"></a>
                            <h5><a href="${detail}?pid=${p.id}">${p.name}</a></h5>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- Categories Section End -->

<!-- Featured Section Begin -->
<section class="featured spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>Sản phẩm nổi bật</h2>
                </div>
            </div>
        </div>
        <div class="row featured__filter" id="content">
            <c:forEach items="${list4Rand}" var="o">
                <div class="product col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat" style="height: 400px">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg">
                            <a href="${detail}?pid=${o.id}">
                                <img src="${o.image}" alt="${o.name}">
                            </a>
                        </div>
                        <div class="featured__item__text">
                            <a class="product-name" href="${detail}?pid=${o.id}" style="color: black">
                                    ${o.name}</a>
                            <h5>${o.price}</h5>
                        </div>
                        <div class="text-center">
                            <c:url var="addToCart" value="/AddToCartControl"></c:url>
                            <form action="${addToCart}?pid=${o.id}" method="post" enctype="multipart/form-data">
                                <button
                                        style="padding: 10px 23px; border-radius: 30px; border: none; background-color: #17c6c6; font-weight: 700"
                                        type="submit">
                                    <a href="${detail}?pid=${o.id}" style="color:#ffffff">
                                        MUA NGAY</a>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div style="padding-left: 500px;">
            <button onclick="loadMore()" class="btn-btn-primary"
                    style="padding: 10px
                    23px; border-radius: 5px; border: none; background-color: #ff6615; font-weight: 700;
        color:white">Xem thêm
            </button>
        </div>
        <div class="row featured__filter">
            <c:forEach items="${listOutstandingProduct}" var="o">
                <div class="product col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                    <div class="featured__item">
                        <div class="featured__item__pic set-bg">
                            <a href="${detail}?pid=${o.id}">
                                <img src="${o.image}" alt="${o.name}">
                            </a>
                        </div>
                        <div class="featured__item__text">
                            <a class="product-name" href="${detail}?pid=${o.id}" style="color: black">
                                    ${o.name}</a>
                            <h5>${o.price}</h5>
                        </div>
                        <div class="text-center">

                            <c:url var="addToCart" value="/AddToCartControl"></c:url>
                            <form action="${addToCart}?pid=${o.id}" method="post" enctype="multipart/form-data">
                                <button
                                        style="padding: 10px 23px; border-radius: 5px; border: none; background-color: #7fad39; font-weight: 700"
                                        type="submit">
                                    <a href="${detail}?pid=${o.id}" style="color:#ffffff">
                                        MUA NGAY</a>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
    </div>
</section>
<!-- Featured Section End -->

<!-- Banner Begin -->
<div class="banner">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img src="assets/img/banner/banner-4.jpg" alt="">
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img src="assets/img/banner/banner-3.jpg" alt="">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Banner End -->

<!-- Blog Section Begin -->
<section class="from-blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title from-blog__title">
                    <h2>From The Blog</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-7.png" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 4,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Mẹo chọn đồ handmade chất lượng</a></h5>
                        <p>Chọn sản phẩm có đường may chắc chắn, màu sắc đều và không có lỗi nhỏ như vết keo thừa hoặc
                            chỉ thừa. Ưu tiên sản phẩm có thiết kế độc đáo và tinh tế.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-8.png" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 4,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Bảo quản đồ handmade như thế nào?</a></h5>
                        <p>Đối với sản phẩm làm từ len hoặc vải, nên bảo quản nơi khô ráo, tránh ẩm mốc. Tránh ánh nắng
                            trực tiếp để sản phẩm không bị bạc màu hay biến dạng.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="blog__item">
                    <div class="blog__item__pic">
                        <img src="assets/img/blog/blog-7.png" alt="">
                    </div>
                    <div class="blog__item__text">
                        <ul>
                            <li><i class="fa fa-calendar-o"></i> Tháng 8,2019</li>
                            <li><i class="fa fa-comment-o"></i> 5</li>
                        </ul>
                        <h5><a href="#">Lý do bạn nên chọn quà tặng handmade</a></h5>
                        <p>Đồ handmade mang ý nghĩa cá nhân hóa và thể hiện sự chăm chút trong từng chi tiết. Đây là lựa
                            chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc lễ Tết.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="./client/footer/footer.jsp"></jsp:include>

<script src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/jquery-ui.min.js"></script>
<script src="assets/js/jquery.slicknav.js"></script>
<script src="assets/js/mixitup.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function loadMore() {
        var amount = document.getElementsByClassName("product").length;
        $.ajax({
            url: "/LoadMoreControl",
            type: "get",
            data: {
                exits: amount
            },
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML += data;
            },
            error: function (xhr) {
            }
        });
    }
</script>

</body>

</html>