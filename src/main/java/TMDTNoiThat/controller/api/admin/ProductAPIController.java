package TMDTNoiThat.controller.api.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = "/api/admin/product-api")
public class ProductAPIController extends HttpServlet {
	private static final long serialVersionUID = 1836975399267279194L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		ProductService psv = new ProductServiceImpl();
		
		if (action.equals("disable")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			if (psv.setProductStatus(idProduct, ConstantValue.PRODUCT_DISABLED_ADMIN)) {
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
}
