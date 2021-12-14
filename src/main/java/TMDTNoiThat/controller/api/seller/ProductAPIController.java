package TMDTNoiThat.controller.api.seller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.cloudinary.utils.ObjectUtils;
import com.google.gson.Gson;

import TMDTNoiThat.listeners.CloudinaryContext;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.ProductImageService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.ProductImageServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.ConstantValue;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = "/api/seller/product-api")
@MultipartConfig
public class ProductAPIController extends HttpServlet {
	private static final long serialVersionUID = -613409704782969271L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		Integer idUser = user.getId();
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		ProductService psv = new ProductServiceImpl();
		
		if (action.equals("update")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			Integer idCategory = Integer.parseInt(req.getParameter("idCategory"));
			String name = req.getParameter("name");
			BigDecimal price = new BigDecimal(req.getParameter("price"));
			Integer availableQty = Integer.parseInt(req.getParameter("availableQty"));
			String description = req.getParameter("description");
			
			
			Product product = psv.getProductById(idProduct);

			List<Part> parts = getAvailableImage(req);
			
			List<Integer> imgDels = new ArrayList<Integer>();
			for (String c : req.getParameterValues("imgdel")){
				if (!c.equals(""))
					imgDels.add(Integer.parseInt(c));
			}
			
			int imgCountLimit = product.getProductImages().size() - imgDels.size() + parts.size();
			
			if (imgCountLimit > 0 && imgCountLimit <= 4) {
				if (imgDels.size() > 0) {
					ProductImageService pimgsv = new ProductImageServiceImpl();
					for (Integer idPImg : imgDels) {
						if (!pimgsv.deleteProductImage(idPImg)) {
							d.put("status", "400");
							d.put("message", "Xóa ảnh cũ thất bại");
							break;
						}
					}
				}
				
				if (d.get("status") == null) {
					if (parts.size() > 0) {
						List<String> imgs = new ArrayList<String>();
						
						for (Part p : parts) {
							byte[] data = MyUtils.inputStreamToByteArray(p.getInputStream());
							if (data != null) {
								Map response = CloudinaryContext.getCloudinaryContext().uploader().upload(data, ObjectUtils.emptyMap());
								System.out.println(new Gson().toJson(response));
								String avtUrl = response.get("secure_url").toString();
								if (avtUrl == null) {
									d.put("status", "400");
									d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Upload failed)!");
									break;
								}
								else {
									imgs.add(avtUrl);
								}
							}
							else {
								d.put("status", "400");
								d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Convert failed)!");
								break;
							}
						}
						
						if (d.get("status") == null) {
							ProductImageService pimgsv = new ProductImageServiceImpl();
							for (String imglink : imgs) {
								if (!pimgsv.addProductImage(idProduct, imglink)) {
									d.put("status", "400");
									d.put("message", "Cập nhật ảnh sản phẩm thất bại");
									break;
								}
							}
						}
					}
					
					if (d.get("status") == null) {
						if (!psv.updateProduct(idProduct, idCategory, name, price, description, null, null, null, availableQty)) {
							d.put("status", "400");
							d.put("message", "Cập nhật thông tin sản phẩm thất bại");
						}
						else {
							d.put("status", "200");
						}
					}
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Số lượng hình ảnh không đạt tối thiểu (1) hoặc vượt tối đa (4)");
			}		
		}
		else if (action.equals("create")) {
			Integer idCategory = Integer.parseInt(req.getParameter("idCategory"));
			String name = req.getParameter("name");
			BigDecimal price = new BigDecimal(req.getParameter("price"));
			Integer availableQty = Integer.parseInt(req.getParameter("availableQty"));
			String description = req.getParameter("description");
			
			List<Part> parts = getAvailableImage(req);
			if (parts.size() > 0) {
				List<String> imgs = new ArrayList<String>();
				
				for (Part p : parts) {
					byte[] data = MyUtils.inputStreamToByteArray(p.getInputStream());
					if (data != null) {
						Map response = CloudinaryContext.getCloudinaryContext().uploader().upload(data, ObjectUtils.emptyMap());
						String avtUrl = response.get("secure_url").toString();
						if (avtUrl == null) {
							d.put("status", "400");
							d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Upload failed)!");
							break;
						}
						else {
							imgs.add(avtUrl);
						}
					}
					else {
						d.put("status", "400");
						d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Convert failed)!");
						break;
					}
				}
				
				if (d.get("status") == null) {
					if (psv.addProduct(idCategory, name, price, description, ConstantValue.PRODUCT_ENABLED, availableQty, idUser, imgs)) {
						d.put("status", "200");
					}
					else {
						d.put("status", "400");
						d.put("message", "Thêm sản phẩm thất bại");
					}
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Cần ít nhất 1 hình ảnh cho sản phẩm");
			}
		}
		else if (action.equals("delete")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			if (psv.getProductById(idProduct).getNsold() == 0) {
				if (!psv.deleteProduct(idProduct)) {
					d.put("status", "400");
					d.put("message", "Xóa sản phẩm thất bại");
				}
				else {
					d.put("status", "200");
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Không thể xóa sản phẩm do sản phẩm đã được bán");
			}
		}
		else if (action.equals("disable")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			if (psv.setProductStatus(idProduct, ConstantValue.PRODUCT_DISABLED_SELLER)) {
				d.put("status", "200");
			}
			else {
				d.put("status", "400");
				d.put("message", "Vô hiệu hóa sản phẩm thất bại");
			}
		}
		else if (action.equals("enable")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			if (psv.setProductStatus(idProduct, ConstantValue.PRODUCT_ENABLED)) {
				d.put("status", "200");
			}
			else {
				d.put("status", "400");
				d.put("message", "Kích sản phẩm thất bại");
			}
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
	
	private List<Part> getAvailableImage(HttpServletRequest req) throws IOException, ServletException{
		List<Part> l = new ArrayList<Part>();
		for (int i = 1; i <= 4 ; i++) {
			Part p = req.getPart("pimg" + String.valueOf(i));
			if (p != null && p.getSize() > 0) {
				l.add(p);
			}
		}
		return l;
	}
}
