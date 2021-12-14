package TMDTNoiThat.controller.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.Category;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.CategoryService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/admin/products"})
public class ProductMgrController extends HttpServlet {
	private static final long serialVersionUID = 4546896461387366473L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ProductService psv = new ProductServiceImpl();
		CategoryService csv = new CategoryServiceImpl();
		
		List<Product> products;
		int currentPage = 0;
		int productCount = -1;
		int pagesize = 10;
		
		Boolean outOfStock = null;
		Integer idCategory = null;
		Integer status = null;
		
		if (req.getParameter("category") != null) {
			idCategory = Integer.parseInt(req.getParameter("category"));
		}
		
		if (req.getParameter("status") != null) {
			status = Integer.parseInt(req.getParameter("status"));
		}
		
		if (req.getParameter("pagesize") != null) {
			pagesize = Integer.parseInt(req.getParameter("pagesize"));
		}
		
		if (req.getParameter("page") != null) {
			currentPage = Integer.parseInt(req.getParameter("page"));
		}
		
		if (req.getParameter("outOfStock") != null) {
			outOfStock = Integer.parseInt(req.getParameter("outOfStock")) == 1;
		}
		
		productCount = psv.adminCountProducts(idCategory, status, outOfStock).intValue();
		
		if (currentPage * pagesize > productCount) {
			currentPage = currentPage - 1;
		}
		
		products = psv.adminGetProducts(idCategory, status, outOfStock, currentPage * pagesize, pagesize);

		Map<Category, Long> categoriesQty = new LinkedHashMap<Category, Long>();
		for (Category c : csv.getAllCategories()) {
			categoriesQty.put(c, psv.adminCountProducts(c.getId(), status, false));
		}
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)productCount/pagesize), 1));
		req.setAttribute("pagesize", pagesize);
		req.setAttribute("products", products);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("categoriesQty", categoriesQty);
		req.setAttribute("user", (User)req.getSession().getAttribute("user"));
		req.getRequestDispatcher("/views/admin/product.jsp").forward(req, resp);
	}
}
