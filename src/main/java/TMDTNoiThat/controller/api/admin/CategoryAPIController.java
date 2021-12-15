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

import TMDTNoiThat.services.CategoryService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/api/admin/category-api"})
public class CategoryAPIController extends HttpServlet {
	private static final long serialVersionUID = -7044058364307945419L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		
		if (action.equals("update")) {
			Integer idCategory = Integer.parseInt(req.getParameter("idCategory"));
			String categoryName = req.getParameter("categoryName");
			Boolean active = req.getParameter("active").equals("true");
			
			CategoryService csv = new CategoryServiceImpl();
			
			if (csv.updateCategory(idCategory, categoryName, active)){
				d.put("status", "200");
			}
			else {
				d.put("status", "400");
				d.put("message", "Cập nhật thất bại");
			}
		}
		else if (action.equals("create")) {
			String categoryName = req.getParameter("categoryName");
			CategoryService csv = new CategoryServiceImpl();
			if (!csv.addCategory(categoryName)) {
				d.put("status", "400");
				d.put("message", "Thêm loại sản phẩm thất bại (" + categoryName + ")");
			}
			else {
				d.put("status", "200");
			}
		}
		else if (action.equals("delete")) {
			Integer idCategory = Integer.parseInt(req.getParameter("idCategory"));
			
			if (new ProductServiceImpl().adminCountProducts(idCategory, null, null, false) == 0) {
				CategoryService csv = new CategoryServiceImpl();
				if (!csv.deleteCategory(idCategory)) {
					d.put("status", "400");
					d.put("message", "Cập nhật thất bại");
				}
				else {
					d.put("status", "200");
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Không thể xóa loại sản phẩm do có sản phẩm thuộc loại sản phẩm này");
			}
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
