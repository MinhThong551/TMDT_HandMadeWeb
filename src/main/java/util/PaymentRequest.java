package util;

import org.json.JSONObject;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.Normalizer;
import java.util.Base64;
import java.io.*;

public class PaymentRequest {

    public static String removeVietnameseAccents(String str) {
        str = Normalizer.normalize(str, Normalizer.Form.NFD);
        return str.replaceAll("\\p{InCombiningDiacriticalMarks}+", "")
                .replace("đ", "d")
                .replace("Đ", "D");
    }

    public static String send(String orderId, int amount) throws Exception {
        String requestId = orderId;
        String orderInfoRaw = "Thanh toán đơn hàng " + orderId;
        String orderInfo = removeVietnameseAccents(orderInfoRaw);  // remove dấu
        String requestType = "captureWallet";

        // MoMo thông số cấu hình
        String accessKey = MomoConfig.ACCESS_KEY;
        String secretKey = MomoConfig.SECRET_KEY;
        String partnerCode = MomoConfig.PARTNER_CODE;
        String redirectUrl = MomoConfig.REDIRECT_URL;
        String ipnUrl = MomoConfig.IPN_URL;

        // ✅ Step 1 - Raw Signature theo đúng thứ tự quy định của MoMo
        String rawSignature = "accessKey=" + accessKey +
                "&amount=" + amount +
                "&extraData=" +
                "&ipnUrl=" + ipnUrl +
                "&orderId=" + orderId +
                "&orderInfo=" + orderInfo +
                "&partnerCode=" + partnerCode +
                "&redirectUrl=" + redirectUrl +
                "&requestId=" + requestId +
                "&requestType=" + requestType;

        System.out.println("🔐 Step 1 - Raw Signature:\n" + rawSignature);

        // ✅ Step 2 - Tạo Signature HMAC SHA256
        SecretKeySpec keySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(keySpec);
        byte[] hmacBytes = mac.doFinal(rawSignature.getBytes(StandardCharsets.UTF_8));
        String signature = Base64.getEncoder().encodeToString(hmacBytes);

        System.out.println("🔏 Step 2 - Signature:\n" + signature);

        // ✅ Step 3 - Tạo JSON body gửi đi
        JSONObject json = new JSONObject();
        json.put("partnerCode", partnerCode);
        json.put("accessKey", accessKey);
        json.put("requestId", requestId);
        json.put("amount", amount);  // là số, không phải chuỗi
        json.put("orderId", orderId);
        json.put("orderInfo", orderInfo);
        json.put("redirectUrl", redirectUrl);
        json.put("ipnUrl", ipnUrl);
        json.put("extraData", "");
        json.put("requestType", requestType);
        json.put("signature", signature);
        json.put("lang", "vi");

        System.out.println("📦 Step 3 - JSON gửi tới MoMo:\n" + json.toString(2));

        // ✅ Step 4 - Gửi request POST
        URL url = new URL(MomoConfig.ENDPOINT);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        OutputStream os = conn.getOutputStream();
        os.write(json.toString().getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        // ✅ Step 5 - Nhận response
        InputStream is;
        if (conn.getResponseCode() >= 400) {
            System.out.println("❌ Step 4 - HTTP lỗi " + conn.getResponseCode());
            is = conn.getErrorStream();
        } else {
            is = conn.getInputStream();
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
        StringBuilder responseStr = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            responseStr.append(line);
        }
        reader.close();
        conn.disconnect();

        System.out.println("📥 Step 5 - Phản hồi từ MoMo:\n" + responseStr);

        // ✅ Step 6 - Parse JSON trả về
        JSONObject res = new JSONObject(responseStr.toString());
        if (res.has("payUrl")) {
            return res.getString("payUrl");
        } else {
            throw new RuntimeException("❌ Step 6 - Lỗi từ MoMo: " + res.toString());
        }
    }
}
