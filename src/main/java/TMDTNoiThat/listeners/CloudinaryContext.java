package TMDTNoiThat.listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import TMDTNoiThat.utils.ConstantValue;

public class CloudinaryContext implements ServletContextListener {
	private static Cloudinary cloudinary;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		cloudinary = new Cloudinary(ObjectUtils.asMap(
				"cloud_name", ConstantValue.CLOUDINARY_CLOUD_NAME,
				"api_key", ConstantValue.CLOUDINARY_API_KEY,
				"api_secret", ConstantValue.CLOUDINARY_API_SECRET,
				"secure", true));
	}
	
	public static Cloudinary getCloudinaryContext() {
		return cloudinary;
	}
}
