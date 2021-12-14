package TMDTNoiThat.utils;

public final class ConstantValue {
	public static final int CANCELED_ORDER = -1;
	public static final int PENDING_ORDER = 0;
	public static final int PAID_ORDER = 1;
	public static final int DELIVERED_ORDER = 2;
	
	public static final int PRODUCT_DISABLED_ADMIN = -1;
	public static final int PRODUCT_DISABLED_SELLER = 0;
	public static final int PRODUCT_ENABLED = 1;
	
	public static final int SORT_PRODUCT_PRICE_DESC = 1;
	public static final int SORT_PRODUCT_PRICE_ASC = 2;
	public static final int SORT_PRODUCT_MOST_SOLD = 3;
	
	public static final int USER_ROLE = 2;
	public static final int SELLER_ROLE = 3;
	public static final int ADMIN_ROLE = 1;
	
	public static final int TOP_PRODUCTS_PER_PAGE = 4; //home
	public static final int NUM_TOP_PRODUCTS = 2; //home
	
	public static final String HOME_URL = "/home";
	public static final String ADMIN_HOME_URL = "/admin";
	public static final String LOGIN_URL = "/login";
	public static final String PRODUCT_URL = "/product";
	public static final String MOMO_NOTIFY_URL = "/momo/notify";
	public static final String MOMO_RETURN_URL = "/momo/return";
	public static final String ERROR_URL = "/error";
	
	public static final String MOMO_PARTNER_CODE = "MOMOSA3T20211011";
	public static final String MOMO_ACCESS_KEY = "gxiD5mL48opmzgN7";
	public static final String MOMO_SECRET_KEY = "kZ4JW2AUswJl7NK21YTt4J3W7SmQ3bFJ";
	public static final String MOMO_ORDER_INFO = "THƯƠNG MẠI ĐIỆN TỬ NỘI THẤT THANH TOÁN TRỰC TUYẾN";
	
	public static final String CLOUDINARY_CLOUD_NAME = "dviyn9zyq";
	public static final String CLOUDINARY_API_KEY = "271469785165875";
	public static final String CLOUDINARY_API_SECRET = "GBkeb8UrS64QBlWpSBinwE2GbE4";
}
