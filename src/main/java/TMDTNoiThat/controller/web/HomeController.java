package TMDTNoiThat.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.services.CategoryService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 432748062925416991L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CategoryService csv = new CategoryServiceImpl();
		ProductService psv = new ProductServiceImpl();
		
		req.setAttribute("nProductPerTopPage", ConstantValue.TOP_PRODUCTS_PER_PAGE);
		req.setAttribute("nTopPage", ConstantValue.NUM_TOP_PRODUCTS);
		Integer numTopProduct = ConstantValue.TOP_PRODUCTS_PER_PAGE * ConstantValue.NUM_TOP_PRODUCTS;
		
		req.setAttribute("topSoldProducts", psv.getTopNsoldProducts(numTopProduct));
		req.setAttribute("topViewProducts", psv.getTopNvisitProducts(numTopProduct));
		req.setAttribute("topCommentProducts", psv.getTopNcommentProducts(numTopProduct));
		req.setAttribute("categories", csv.getAllCategories());
		req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
	}

}
