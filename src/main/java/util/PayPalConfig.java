package util;

import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.OAuthTokenCredential;
import com.paypal.base.rest.PayPalRESTException;

import java.util.HashMap;
import java.util.Map;

public class PayPalConfig {

    private static final String CLIENT_ID = "Abo90Wztq8vanhzw0EO5zMhum7b1O6aI_1x4BTA8v7jqNIOGdthWxF-ZZpjhtEGg6CW0VWRdgg_hjdlb";
    private static final String CLIENT_SECRET = "EEpPKUqIRD0gJPVKHVai84Yi0lauKUq3brqUN2AYkeIq1GHGbBJy_fA_q3bvj8Ha7cFZByFGKRvYyzro";
    private static final String MODE = "sandbox"; // hoặc "live"

    public static APIContext getAPIContext() throws PayPalRESTException {
        APIContext context = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return context;
    }
}
