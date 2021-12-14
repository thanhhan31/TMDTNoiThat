package TMDTNoiThat.controller.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.Category;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.CategoryService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/admin/categories"})
public class CategoryMgrController extends HttpServlet {
	private static final long serialVersionUID = -9208346472484493120L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		CategoryService csv = new CategoryServiceImpl();
		ProductService psv = new ProductServiceImpl();
		
		Map<Category, Long> categories = new LinkedHashMap<Category, Long>();
		for (Category c : csv.adminGetAllCategories()) {
			categories.put(c, psv.adminCountProducts(c.getId(), null, false));
		}
		
		req.setAttribute("user", user);
		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/views/admin/category.jsp").forward(req, resp);
	}
}
