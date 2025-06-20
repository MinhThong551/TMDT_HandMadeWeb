<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thanh toán MoMo</title>
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
            background-color: #8b28db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #6e1bb8;
        }
    </style>
</head>
<body>
<h2>Vui lòng quét mã QR MoMo để thanh toán</h2>
<img src="/images/momo-qr-thong.png?v=123" alt="QR MoMo" />



<form action="<c:url value='/MomoPaymentSuccessControll' />" method="post">

    <button type="submit">Tôi đã thanh toán</button>
</form>
</body>
</html>
