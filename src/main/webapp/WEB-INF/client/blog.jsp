<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="zxx">

<head>
    <%@page isELIgnored="false" %>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Blog</title>
    <jsp:include page="link/link.jsp"></jsp:include>
    <style>

    </style>
</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>

<span class="header__fixed">
	<jsp:include page="header/header.jsp"></jsp:include>

</span>

<section class="breadcrumb-section set-bg" data-setbg="assets/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Blog</h2>
                    <div class="breadcrumb__option">
                        <a href="./IndexControll">Trang chủ</a>
                        <span>Giới thiệu</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Blog Section Begin -->
<section class="blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-5">
                <div class="blog__sidebar">
                    <div class="blog__sidebar__search">
                        <form action="#">
                            <input type="text" placeholder="Search...">
                            <button type="submit"><span class="icon_search"></span></button>
                        </form>
                    </div>
                    <div class="blog__sidebar__item">
                        <h4>Categories</h4>
                        <ul>
                            <li class=""><a href="./ShowProductControl?cid=0">Tất cả</a></li>
                            <li class=""><a href="./ShowProductControl?cid=1">Hoa</a></li>
                            <li class=""><a href="./ShowProductControl?cid=2">Kẹp tóc</a></li>
                            <li class=""><a href="./ShowProductControl?cid=3">Ốp lưng</a></li>
                            <li class=""><a href="./ShowProductControl?cid=4">Gấu bông</a></li>
                            <li class=""><a href="./ShowProductControl?cid=4">Chậu hoa</a></li>
                        </ul>
                    </div>
                    <div class="blog__sidebar__item">
                        <h4>Recent News</h4>
                        <div class="blog__sidebar__recent">
                            <a href="#" class="blog__sidebar__recent__item">
                                <div class="blog__sidebar__recent__item__pic">
                                    <img src="images/product14.jpg" alt="" style="height: 100px; width: 100px">
                                </div>
                                <div class="blog__sidebar__recent__item__text">
                                    <h6>09 Mẫu Móc Khoá Len<br/> Được Yêu Thích Nhất</h6>
                                    <span>JUN 20, 2024</span>
                                </div>
                            </a>
                            <a href="#" class="blog__sidebar__recent__item">
                                <div class="blog__sidebar__recent__item__pic">
                                    <img src="images/product15.jpg" alt="" style="height: 100px; width: 100px">
                                </div>
                                <div class="blog__sidebar__recent__item__text">
                                    <h6>Tips Giúp Bảo Quản<br/> Đồ Handmade Lâu Bền</h6>
                                    <span>JUN 15, 2024</span>
                                </div>
                            </a>
                            <a href="#" class="blog__sidebar__recent__item">
                                <div class="blog__sidebar__recent__item__pic">
                                    <img src="images/product16.jpg" alt="" style="height: 100px; width: 100px">
                                </div>
                                <div class="blog__sidebar__recent__item__text">
                                    <h6>4 Gợi Ý Tự Làm Quà Tặng<br/> Handmade Ý Nghĩa</h6>
                                    <span>JUN 10, 2024</span>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="blog__sidebar__item">
                        <h4>Search By</h4>
                        <div class="blog__sidebar__item__tags">
                            <a href="#">Hoa</a>
                            <a href="#">Kẹp tóc</a>
                            <a href="#">Ốp lưng</a>
                            <a href="#">Gấu bông</a>
                            <a href="#">Chậu hoa</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 col-md-7">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product14.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> Jun 1, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 8</li>
                                </ul>
                                <h5><a href="#">6 cách gói quà handmade độc đáo</a></h5>
                                <p>Khám phá những cách gói quà thủ công sáng tạo giúp món quà trở nên tinh tế và ấn tượng hơn.</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product13.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 28, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 12</li>
                                </ul>
                                <h5><a href="#">Thăm xưởng làm đồ handmade tại TP.HCM</a></h5>
                                <p>Cùng tham quan một xưởng thủ công nhỏ và tìm hiểu quá trình tạo ra sản phẩm bằng tay đầy tâm huyết.</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product6.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 20, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 7</li>
                                </ul>
                                <h5><a href="#">Mẹo làm thiệp chúc mừng bằng tay đơn giản</a></h5>
                                <p>Tự tay làm những tấm thiệp chúc mừng đẹp mắt chỉ với giấy màu, kéo và một chút sáng tạo.</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product5.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 14, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 6</li>
                                </ul>
                                <h5><a href="#">Tự làm móc khoá len cực dễ thương</a></h5>
                                <p>Hướng dẫn chi tiết cách móc một chiếc móc khoá len mini, dễ làm và thích hợp làm quà tặng.</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product3.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 5, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 9</li>
                                </ul>
                                <h5><a href="#">Thời điểm thích hợp để thay đổi mẫu handmade</a></h5>
                                <p>Làm mới bộ sưu tập handmade theo mùa và xu hướng – bạn đã thử chưa?</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="images/product2.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> Apr 28, 2024</li>
                                    <li><i class="fa fa-comment-o"></i> 4</li>
                                </ul>
                                <h5><a href="#">Hướng dẫn chăm sóc đồ handmade đúng cách</a></h5>
                                <p>Lưu giữ đồ handmade lâu dài và luôn như mới nhờ những bí quyết đơn giản này.</p>
                                <a href="#" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="product__pagination blog__pagination">
                            <a href="#">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Blog Section End -->


<!-- Js Plugins -->
<jsp:include page="footer/footer.jsp"></jsp:include>
<script src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/jquery-ui.min.js"></script>
<script src="assets/js/jquery.slicknav.js"></script>
<script src="assets/js/mixitup.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>


</body>

</html>