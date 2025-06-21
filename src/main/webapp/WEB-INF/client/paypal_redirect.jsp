<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thanh toán bằng PayPal</title>
    <script src="https://www.paypal.com/sdk/js?client-id=YOUR_CLIENT_ID&currency=USD"></script>
</head>
<body>
<h3>Vui lòng thanh toán đơn hàng bằng PayPal</h3>

<div id="paypal-button-container"></div>

<script>
    paypal.Buttons({
        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '${usdAmount}'
                    }
                }]
            });
        },
        onApprove: function(data, actions) {
            return actions.order.capture().then(function(details) {
                // Sau khi thanh toán thành công, chuyển về servlet xử lý đơn hàng
                window.location.href = '<c:url value="/PaypalPaymentSuccessControll" />';
            });
        }
    }).render('#paypal-button-container');
</script>
</body>
</html>
