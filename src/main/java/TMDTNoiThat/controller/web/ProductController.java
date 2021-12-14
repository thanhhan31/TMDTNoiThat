package TMDTNoiThat.controller.web;

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
import TMDTNoiThat.services.CategoryService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/products"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = -4618985261949711246L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		ProductService psv = new ProductServiceImpl();
		CategoryService csv = new CategoryServiceImpl();
		
		List<Product> products;
		int currentPage = 0;
		int productCount = -1;
		int pagesize = 10;
		
		Integer idCategory = null;
		Integer sortType = null;
		String searchName = null;
		
		if (req.getParameter("category") != null) {
			idCategory = Integer.parseInt(req.getParameter("category"));
		}
		
		if (req.getParameter("searchName") != null) {
			searchName = req.getParameter("searchName");
		}
		
		if (req.getParameter("sort") != null) {
			sortType = Integer.parseInt(req.getParameter("sort"));
		}
		
		if (req.getParameter("page") != null) {
			currentPage = Integer.parseInt(req.getParameter("page"));
		}
		
		if (req.getParameter("pagesize") != null) {
			pagesize = Integer.parseInt(req.getParameter("pagesize"));
		}
		
		productCount = psv.countProducts(idCategory, searchName).intValue();
		
		if (currentPage * pagesize > productCount) {
			currentPage = currentPage - 1;
		}
		
		products = psv.getProducts(idCategory, searchName, sortType, currentPage * pagesize, pagesize);
		
		List<Category> categories = csv.getAllCategories();
		Map<Category, Long> categoriesQty = new LinkedHashMap<Category, Long>();
		for (Category c : csv.getAllCategories()) {
			categoriesQty.put(c, psv.countProducts(c.getId(), null));
		}
		
		if (idCategory != null) {
			req.setAttribute("selectedCategory", new CategoryServiceImpl().getCategoryById(idCategory).getName());
		}
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)productCount/pagesize), 1));
		req.setAttribute("products", products);
		req.setAttribute("productCount", productCount);
		req.setAttribute("lastedProducts", psv.getTopLastedProducts(3));
		req.setAttribute("categories", categories);
		req.setAttribute("categoriesQty", categoriesQty);
		
		req.getRequestDispatcher("/views/web/product.jsp").forward(req, resp);
	}
}
