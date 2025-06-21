<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thanh toán VNPAY</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px;
        }
        img {
            width: 300px;
            margin: 20px 0;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #e30613;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #b9040f;
        }
    </style>
</head>
<body>
<h2>Vui lòng quét mã QR VNPAY để thanh toán</h2>

<img src="https://api.qrserver.com/v1/create-qr-code/?data=&size=300x300" alt="QR VNPAY" />

<form action="<c:url value='/VnpayPaymentSuccessControll' />" method="post">
    <button type="submit">Tôi đã thanh toán</button>
</form>
</body>
</html>
