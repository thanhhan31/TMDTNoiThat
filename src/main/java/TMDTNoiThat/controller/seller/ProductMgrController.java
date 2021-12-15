package TMDTNoiThat.controller.seller;

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

@WebServlet(urlPatterns = {"/seller/products"})
public class ProductMgrController extends HttpServlet {
	private static final long serialVersionUID = -4443247770716057825L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		ProductService psv = new ProductServiceImpl();
		CategoryService csv = new CategoryServiceImpl();
		
		List<Product> products;
		int currentPage = 0;
		int productCount = -1;
		int pagesize = 10;
		
		Boolean outOfStock = null;
		Integer idCategory = null;
		String searchName = null;
		Integer status = null;
		
		if (req.getParameter("category") != null) {
			idCategory = Integer.parseInt(req.getParameter("category"));
		}
		
		if (req.getParameter("searchName") != null) {
			searchName = req.getParameter("searchName");
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
		
		productCount = psv.sellerCountProducts(user.getId(), idCategory, searchName, status, outOfStock).intValue();
		
		while (currentPage * pagesize > productCount) {
			currentPage = currentPage - 1;
		}
		
		products = psv.sellerGetProducts(user.getId(), idCategory, searchName, status, outOfStock, currentPage * pagesize, pagesize);

		Map<Category, Long> categoriesQty = new LinkedHashMap<Category, Long>();
		for (Category c : csv.getAllCategories()) {
			categoriesQty.put(c, psv.sellerCountProducts(user.getId(), c.getId(), searchName, status, outOfStock));
		}
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)productCount/pagesize), 1));
		req.setAttribute("pagesize", pagesize);
		req.setAttribute("products", products);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("categoriesQty", categoriesQty);
		req.setAttribute("user", (User)req.getSession().getAttribute("user"));
		req.getRequestDispatcher("/views/seller/product.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("type");
		if (action.equals("create")) {
			CategoryService csv = new CategoryServiceImpl();
			req.setAttribute("categories", csv.getAllCategories());
			req.getRequestDispatcher("/views/seller/createProduct.jsp").forward(req, resp);
		}
		else if (action.equals("update")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			ProductService psv = new ProductServiceImpl();
			CategoryService csv = new CategoryServiceImpl();
			req.setAttribute("categories", csv.getAllCategories());
			req.setAttribute("product", psv.getProductById(idProduct));
			req.getRequestDispatcher("/views/seller/editProduct.jsp").forward(req, resp);
		}
	}
}
