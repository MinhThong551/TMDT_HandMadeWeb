<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tùy Chỉnh Sản Phẩm Handmade</title>
    <style>
        /* CSS cho toàn trang */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            line-height: 1.6;
        }

        /* Header */
        header {
            background-color: #efd0f4;
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        header nav {
            margin-top: 10px;
        }
        header nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }
        header nav a:hover {
            color: #ffd700;
        }

        /* Main content */
        .container {
            display: flex;
            width: 80%;
            max-width: 1200px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
        }
        .left-panel {
            flex: 1;
            padding: 20px;
            border-right: 1px solid #ccc;
        }
        .right-panel {
            flex: 1;
            padding: 20px;
            text-align: center;
        }
        .left-panel h2, .right-panel h3 {
            color: #333;
            margin-bottom: 15px;
        }
        .left-panel label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .left-panel select, .left-panel input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .left-panel input[type="submit"] {
            background-color: #efd0f4;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .left-panel input[type="submit"]:hover {
            background-color: #e09cf6;
        }

        /* SVG Bear */
        /* SVG Bear */
        .bear-body { fill: #F4A460; }
        .bear-head { fill: #F4A460; }
        .bear-ear { fill: #F4A460; }
        .bear-arm { fill: #F4A460; }
        .bear-leg { fill: #F4A460; }
        .bear-nose { fill: #000000; }
        .bear-eye { fill: #000000; }
        .bear-mouth { stroke: #000000; stroke-width: 2; fill: none; }
        .bear-ribbon-neck { fill: #FF69B4; display: block; }
        .bear-ribbon-ear { fill: #FF69B4; display: none; }

        /* Product lists */
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            padding: 5px 0;
            border-bottom: 1px solid #eee;
        }

        /* Footer */
        /*footer {*/
        /*    background-color: #efd0f4;*/
        /*    color: white;*/
        /*    text-align: center;*/
        /*    padding: 10px 0;*/
        /*    position: fixed;*/
        /*    width: 100%;*/
        /*    bottom: 0;*/
        /*}*/
        /*footer a {*/
        /*    color: #ffd700;*/
        /*    text-decoration: none;*/
        /*}*/
        /*footer a:hover {*/
        /*    text-decoration: underline;*/
        /*}*/

        /* Result Object */
        .json-output {
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
            max-height: 50px;
        }
    </style>
    <%
        String bearBodyColor = (String) request.getAttribute("bearBodyColor");
        if (bearBodyColor == null) bearBodyColor = "#FFDAB9"; // Mặc định pastel peach
        String bearNoseColor = (String) request.getAttribute("bearNoseColor");
        if (bearNoseColor == null) bearNoseColor = "#D3D3D3"; // Mặc định light gray
        String bearRibbonColor = (String) request.getAttribute("bearRibbonColor");
        if (bearRibbonColor == null) bearRibbonColor = "#FFB6C1"; // Mặc định pastel pink
        String ribbonPosition = (String) request.getAttribute("ribbonPosition");
        if (ribbonPosition == null) ribbonPosition = "neck";

        String contextPath = request.getContextPath();
    %>
</head>
<body>
<!-- Header -->
<header>
    <div class="logo">Handmade Shop</div>
</header>

<!-- Main Content -->
<div class="container">
    <div class="left-panel">
        <h2>Tùy Chỉnh Gấu Bông</h2>
        <form id="customForm" method="post" onsubmit="sendToAdmin(event)">
            <label for="bearBodyColor">Màu thân gấu:</label>
            <select name="bearBodyColor" id="bearBodyColor" onchange="updatePreview()">
                <option value="#FFB6C1">Pastel Pink</option>
                <option value="#ADD8E6">Baby Blue</option>
                <option value="#E6E6FA">Lavender</option>
                <option value="#C1E1C1">Mint Green</option>
                <option value="#FFDAB9">Peach</option>
            </select><br><br>

            <label for="bearNoseColor">Màu mũi:</label>
            <select name="bearNoseColor" id="bearNoseColor" onchange="updatePreview()">
                <option value="#FFB6C1">Light Pink</option>
                <option value="#D8BFD8">Light Purple</option>
                <option value="#FFFACD">Light Yellow</option>
                <option value="#90EE90">Light Green</option>
                <option value="#D3D3D3">Light Gray</option>
            </select><br><br>

            <label for="bearRibbonColor">Màu ruy băng:</label>
            <select name="bearRibbonColor" id="bearRibbonColor" onchange="updatePreview()">
                <option value="#D8BFD8">Pastel Purple</option>
                <option value="#FFB6C1">Soft Pink</option>
                <option value="#AFEEEE">Light Teal</option>
                <option value="#FFFACD">Pale Yellow</option>
                <option value="#C1E1C1">Mint</option>
            </select><br><br>

            <label for="ribbonPosition">Vị trí nơ:</label>
            <select name="ribbonPosition" id="ribbonPosition" onchange="updatePreview()">
                <option value="neck">Cổ</option>
                <option value="none">Không có</option>
            </select><br><br>

            <label for="quantity">Số lượng:</label>
            <input type="number" name="quantity" id="quantity" min="1" value="1"><br><br>

            <input type="submit" value="Thêm vào giỏ hàng">
        </form>
    </div>
    <div class="right-panel">
        <h3>Xem trước sản phẩm:</h3>
        <div id="bearPreview">
            <svg class="product-image" viewBox="0 0 150 150" xmlns="http://www.w3.org/2000/svg">
                <ellipse class="bear-head" cx="75" cy="50" rx="25" ry="30"/>
                <ellipse class="bear-ear" cx="55" cy="30" rx="12" ry="17"/>
                <ellipse class="bear-ear" cx="95" cy="30" rx="12" ry="17"/>
                <circle class="bear-eye" cx="65" cy="45" r="2.5"/>
                <circle class="bear-eye" cx="85" cy="45" r="2.5"/>
                <path class="bear-nose" d="M70 52 L75 58 L80 52 Z" stroke="#000000" stroke-width="1" fill-opacity="0.9"/>
                <path class="bear-mouth" d="M70 60 Q75 65 80 60"/>
                <ellipse class="bear-body" cx="75" cy="100" rx="35" ry="45"/>
                <rect class="bear-arm" x="35" y="70" width="15" height="40" rx="5"/>
                <rect class="bear-arm" x="100" y="70" width="15" height="40" rx="5"/>
                <rect class="bear-leg" x="50" y="125" width="20" height="25" rx="5"/>
                <rect class="bear-leg" x="80" y="125" width="20" height="25" rx="5"/>
                <path class="bear-ribbon-neck" d="M70 80 L73 72 L76 80 L79 72 L82 80 Q76 85 70 80"/>
            </svg>
        </div>
    </div>
</div>

<h3>Kết quả tùy chỉnh (Object):</h3>
<pre id="resultObject" class="json-output"></pre>

<%--<!-- Footer -->--%>
<%--<footer>--%>
<%--    <p>© 2025 Handmade Shop. All rights reserved.</p>--%>
<%--</footer>--%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var contextPath = "<%= contextPath %>";

    function updatePreview() {
        const bearBodyColor = document.getElementById('bearBodyColor').value;
        const bearNoseColor = document.getElementById('bearNoseColor').value;
        const bearRibbonColor = document.getElementById('bearRibbonColor').value;
        const ribbonPosition = document.getElementById('ribbonPosition').value;

        document.querySelector('.bear-body').style.fill = bearBodyColor;
        document.querySelector('.bear-head').style.fill = bearBodyColor;
        document.querySelectorAll('.bear-ear').forEach(ear => {
            ear.style.fill = bearBodyColor;
        });
        document.querySelectorAll('.bear-arm').forEach(arm => {
            arm.style.fill = bearBodyColor;
        });
        document.querySelectorAll('.bear-leg').forEach(leg => {
            leg.style.fill = bearBodyColor;
        });
        document.querySelector('.bear-nose').style.fill = bearNoseColor;
        document.querySelector('.bear-ribbon-neck').style.display = ribbonPosition === 'neck' ? 'block' : 'none';
        document.querySelectorAll('.bear-ribbon-ear').forEach(ribbon => {
            ribbon.style.display = ribbonPosition === 'ear' ? 'block' : 'none';
        });
        document.querySelector('.bear-ribbon-neck').style.fill = bearRibbonColor;
        document.querySelectorAll('.bear-ribbon-ear').forEach(ribbon => {
            ribbon.style.fill = bearRibbonColor;
        });

        const customData = {
            productType: 'bear',
            bearBodyColor: bearBodyColor,
            bearNoseColor: bearNoseColor,
            bearRibbonColor: bearRibbonColor,
            ribbonPosition: ribbonPosition,
            quantity: document.getElementById('quantity').value
        };
        document.getElementById('resultObject').textContent = JSON.stringify(customData, null, 2);
    }

    function sendToAdmin(event) {
        event.preventDefault();
        const customData = {
            productType: 'bear',
            quantity: document.getElementById('quantity').value,
            bearBodyColor: document.getElementById('bearBodyColor').value,
            bearNoseColor: document.getElementById('bearNoseColor').value,
            bearRibbonColor: document.getElementById('bearRibbonColor').value,
            ribbonPosition: document.getElementById('ribbonPosition').value
        };
        console.log('Dữ liệu gửi đi:', JSON.stringify(customData));

        $.ajax({
            url: contextPath + '/custom1',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(customData),
            success: function(response) {
                if (response.success) {
                    if (response.size) {
                        const cartSizeElement = document.getElementById('cartSize');
                        if (cartSizeElement) {
                            cartSizeElement.textContent = response.size;
                        }
                    }
                    alert(response.message);
                    if (response.redirect) {
                        window.location.href = contextPath + response.redirect;
                    }
                } else {
                    alert('Lỗi: ' + response.message);
                    if (response.redirect) {
                        window.location.href = contextPath + response.redirect;
                    }
                }
            },
            error: function(xhr, status, error) {
                alert('Lỗi khi gửi dữ liệu: ' + error);
                console.log('Chi tiết lỗi:', xhr.responseText);
            }
        });
    }

    window.onload = updatePreview;
</script>
</body>
</html>