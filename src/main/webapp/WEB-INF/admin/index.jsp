<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <%@ page isELIgnored="false" %>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Admin-Dashboard</title>
    <!-- plugins:css -->
    <jsp:include page="link/link.jsp"></jsp:include>
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
        .table th,
        .table td,
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
            border-radius: 50% !important;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .icon-box-danger {
            background-color: #f8d7da !important;
            color: #721c24 !important;
            border-radius: 50% !important;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .icon-item {
            color: #000 !important;
            font-size: 18px;
        }

        .card {
            border-radius: 1rem !important;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1 !important;
            cursor: pointer;
        }
    </style>


</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_sidebar.html -->
    <jsp:include page="header/sidebar.jsp"></jsp:include>

    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="header/navbar.jsp"></jsp:include>

        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper bg-white">

                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Biểu đồ thống kê tổng quan</h4>
                                <canvas id="overviewChart" style="height: 190px; width: 100%;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Chart Section -->
                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <canvas id="transaction-history" class="transaction-chart"></canvas>
                                <h4 class="card-title">Danh mục bán chạy</h4>
                                <div class="bg-gray-dark d-flex d-md-block d-xl-flex flex-row py-3 px-4 px-md-3 px-xl-4 rounded mt-3">
                                    <div class="text-md-center text-xl-left">
                                        <h6 class="mb-1">Phụ kiện</h6>
                                        <p class="text-muted mb-0">${map.get("ratio1")}%</p>
                                    </div>
                                    <div class="align-self-center flex-grow text-right text-md-center text-xl-right py-md-2 py-xl-0">
                                        <h6 class="font-weight-bold mb-0">${map.get("sumPriceType1")} VND</h6>
                                    </div>
                                </div>
                                <div class="bg-gray-dark d-flex d-md-block d-xl-flex flex-row py-3 px-4 px-md-3 px-xl-4 rounded mt-3">
                                    <div class="text-md-center text-xl-left">
                                        <h6 class="mb-1">Móc khoá</h6>
                                        <p class="text-muted mb-0">${map.get("ratio2")}%</p>
                                    </div>
                                    <div class="align-self-center flex-grow text-right text-md-center text-xl-right py-md-2 py-xl-0">
                                        <h6 class="font-weight-bold mb-0">${map.get("sumPriceType2")} VND</h6>
                                    </div>
                                </div>
                                <div class="bg-gray-dark d-flex d-md-block d-xl-flex flex-row py-3 px-4 px-md-3 px-xl-4 rounded mt-3">
                                    <div class="text-md-center text-xl-left">
                                        <h6 class="mb-1">Ốp lưng</h6>
                                        <p class="text-muted mb-0">${map.get("ratio3")}%</p>
                                    </div>
                                    <div class="align-self-center flex-grow text-right text-md-center text-xl-right py-md-2 py-xl-0">
                                        <h6 class="font-weight-bold mb-0">${map.get("sumPriceType3")} VND</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Table Section -->
                    <div class="col-md-8 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Top 10 danh mục bán chạy</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-responsive-sm text-center" id="example">
                                        <thead>
                                        <tr>
                                            <th>Mã</th>
                                            <th>Tên</th>
                                            <th>Hình ảnh</th>
                                            <th>Số lượng bán</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="p" items="${list}">
                                            <tr>
                                                <td>${p.id}</td>
                                                <td>${p.name}</td>
                                                <td><img src="${p.image}" style="width: 30px;height: 30px"></td>
                                                <td>${conlai[p.id]}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <jsp:include page="footer/footer.jsp"></jsp:include>

            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // === PIE CHART: transaction-history ===
        const pieCanvas = document.getElementById('transaction-history');
        if (pieCanvas) {
            const ctxPie = pieCanvas.getContext('2d');

            const centerX = pieCanvas.width / 2;
            const centerY = pieCanvas.height / 2;
            const radius = 80;
            const percentages = [10, 40, 50];
            const colors = ['#ff6384', '#36a2eb', '#ffce56'];
            let startAngle = -0.5 * Math.PI;

            percentages.forEach((percent, index) => {
                const endAngle = startAngle + 2 * Math.PI * (percent / 100);
                ctxPie.beginPath();
                ctxPie.moveTo(centerX, centerY);
                ctxPie.arc(centerX, centerY, radius, startAngle, endAngle);
                ctxPie.closePath();
                ctxPie.fillStyle = colors[index];
                ctxPie.fill();

                const angle = startAngle + (endAngle - startAngle) / 2;
                const x = centerX + Math.cos(angle) * radius * 0.7;
                const y = centerY + Math.sin(angle) * radius * 0.7;
                ctxPie.font = 'bold 12px Arial';
                ctxPie.fillStyle = 'black';
                ctxPie.textBaseline = 'middle';
                ctxPie.textAlign = 'center';
                ctxPie.fillText(percent + '%', x, y);

                startAngle = endAngle;
            });
        }

        // === LINE CHART: overviewChart ===
        const lineCanvas = document.getElementById('overviewChart');
        if (lineCanvas) {
            const ctxLine = lineCanvas.getContext('2d');

            new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                    datasets: [
                        {
                            label: 'Số đơn hàng',
                            data: [65, 70, 75, 73, 66, 55],
                            borderColor: '#36a2eb',
                            backgroundColor: 'rgba(54,162,235,0.1)',
                            tension: 0.4
                        },
                        {
                            label: 'Doanh thu',
                            data: [70, 75, 80, 85, 90, 95],
                            borderColor: '#4bc0c0',
                            backgroundColor: 'rgba(75,192,192,0.1)',
                            tension: 0.4
                        },
                        {
                            label: 'Daily Income',
                            data: [60, 62, 61, 55, 66, 50],
                            borderColor: '#ff6384',
                            backgroundColor: 'rgba(255,99,132,0.1)',
                            tension: 0.4
                        },
                        {
                            label: 'Chi phí hiện tại',
                            data: [65, 64, 66, 70, 83, 98],
                            borderColor: '#9966ff',
                            backgroundColor: 'rgba(153,102,255,0.1)',
                            tension: 0.4
                        }

                    ]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                        },
                        title: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: false
                        }
                    }
                }
            });
        }
    });
</script>

<script src="assetsAdmin/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="assetsAdmin/vendors/chart.js/Chart.min.js"></script>
<script src="assetsAdmin/vendors/progressbar.js/progressbar.min.js"></script>
<script src="assetsAdmin/vendors/jvectormap/jquery-jvectormap.min.js"></script>
<script src="assetsAdmin/vendors/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="assetsAdmin/vendors/owl-carousel-2/owl.carousel.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="assetsAdmin/js/off-canvas.js"></script>
<script src="assetsAdmin/js/hoverable-collapse.js"></script>
<script src="assetsAdmin/js/misc.js"></script>
<script src="assetsAdmin/js/settings.js"></script>
<script src="assetsAdmin/js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="assetsAdmin/js/dashboard.js"></script>
</html>