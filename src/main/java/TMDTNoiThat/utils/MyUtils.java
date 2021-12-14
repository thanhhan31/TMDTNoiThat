package TMDTNoiThat.utils;

import java.io.InputStream;
import java.lang.reflect.Type;
import java.math.BigInteger;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class MyUtils {
	private static final char[] HEX_ARRAY = "0123456789abcdef".toCharArray();
	
	public static String hash_password_SHA256(String password, String salt) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update((password + salt).getBytes(StandardCharsets.UTF_8));
			return String.format("%064x", new BigInteger(1, md.digest()));
		} catch (Exception e) {
			return null;
		}
	}
	
	public static Timestamp getCurrentTime() {
		return Timestamp.from(Instant.now());
	}
	
	public static byte[] inputStreamToByteArray(InputStream istream) {
		try {
			byte[] targetArray = new byte[istream.available()];
			istream.read(targetArray);
			return targetArray;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}
	
 	public static List<Integer> paginate(int currentPage, int totalPage, int spreadSize) {
		List<Integer> page = new ArrayList<Integer>();
		if (currentPage != 0) {
			page.add(0);
		}
		
		int add_forward = 0;
		int sub_backward = 0;
		
		if (currentPage - spreadSize <= 0) {
			add_forward = Math.abs(currentPage - spreadSize) + 1;
		}
	        
	    if (currentPage + spreadSize >= totalPage - 1) {
	    	sub_backward = -((currentPage + spreadSize - (totalPage - 1)) + 1);
	    }
	    
	    int i = currentPage - spreadSize + sub_backward;
	    if (i <= 0) {
	    	i = 1;
	    }
	    
	    for (; i < currentPage; i++) {
	    	page.add(i);
	    }
	    
	    i = currentPage;
	    
	    for (; i < currentPage + spreadSize + add_forward + 1; i++) {
	    	if (i >= totalPage) {
	    		break;
	    	}
	    	page.add(i);
	    }
	    
	    if (page.size() > 1) {
	    	if (page.get(page.size() - 1) != totalPage - 1) {
		    	page.add(totalPage - 1);
		    }
	    	
	    	if (page.get(1) - page.get(0) > 1) {
		    	page.add(1, -1);
		    }
		    
		    if (page.get(page.size() - 1) - page.get(page.size() - 2) > 1) {
		    	page.add(page.size() - 1, -1);
		    }
	    }

		return page;
	}
 	
 	public static Map<String, String> generateMomoBill(String idOrder, String amount, String urlContext) {
 		String postData = generateMomoPaymentData(idOrder, amount, urlContext);
 		//System.out.println(postData);
		try {
			HttpClient httpClient = HttpClientBuilder.create().build();
	        HttpPost post = new HttpPost("https://test-payment.momo.vn/gw_payment/transactionProcessor");
	        
	        StringEntity strentity = new StringEntity(postData, Charset.forName("UTF-8"));
	        
	        post.setHeader("Content-type", "application/json; charset=UTF-8");
	        post.setEntity(strentity);
	        
	        HttpResponse response = httpClient.execute(post);
	        
	        String resp = EntityUtils.toString(response.getEntity(), "UTF-8");
	        
	        //System.out.println(resp);
	        
	        Type type = new TypeToken<Map<String, String>>(){}.getType();
	        Map<String, String> myMap = new Gson().fromJson(resp, type);
	        
	        return myMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
 	
 	private static String generateMomoPaymentData(String idOrder, String amount, String urlContext) {
		Map<String, String> d = new LinkedHashMap<>();
		d.put("partnerCode", ConstantValue.MOMO_PARTNER_CODE);
		d.put("accessKey", ConstantValue.MOMO_ACCESS_KEY);
		d.put("requestId", getRandomString());
		d.put("amount", amount);
		d.put("orderId", idOrder);
		d.put("orderInfo", ConstantValue.MOMO_ORDER_INFO);
		d.put("returnUrl", urlContext + ConstantValue.MOMO_RETURN_URL);
		d.put("notifyUrl", urlContext + ConstantValue.MOMO_NOTIFY_URL);
		d.put("extraData", "");	
		
		String j = "";
		for (Map.Entry<String, String> entry : d.entrySet()) {
			j += "&" + entry.getKey() + "=" + entry.getValue();
		}
		
		j = j.substring(1);
		d.put("requestType", "captureMoMoWallet");
		
		try {
			d.put("signature", encode(ConstantValue.MOMO_SECRET_KEY, j));
		} catch (Exception e) { }

		return new Gson().toJson(d);
	}
	
	private static String encode(String key, String data) throws Exception {
		Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
		SecretKeySpec secret_key = new SecretKeySpec(key.getBytes("UTF-8"), "HmacSHA256");
		sha256_HMAC.init(secret_key);

		return bytesToHex(sha256_HMAC.doFinal(data.getBytes("UTF-8")));
	}
	
	private static String bytesToHex(byte[] bytes) {
	    char[] hexChars = new char[bytes.length * 2];
	    for (int j = 0; j < bytes.length; j++) {
	        int v = bytes[j] & 0xFF;
	        hexChars[j * 2] = HEX_ARRAY[v >>> 4];
	        hexChars[j * 2 + 1] = HEX_ARRAY[v & 0x0F];
	    }
	    return new String(hexChars);
	}
	
	private static String getRandomString() {
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 18) {
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;

    }
}
