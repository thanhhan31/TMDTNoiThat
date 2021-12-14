package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.CommentService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.CommentServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/productdetail"})
public class ProductDetailController extends HttpServlet {
	private static final long serialVersionUID = -6494363372692403994L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("id") == null || req.getParameter("id").equals("")) {
			resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.PRODUCT_URL);
			return;
		}
		
		ProductService psv = new ProductServiceImpl();
		Integer idProduct = Integer.parseInt(req.getParameter("id"));
		
		Product product = psv.getProductById(idProduct);
		psv.updateNvisit(idProduct, product.getNvisit() + 1);
		List<Comment> comments = new CommentServiceImpl().getProductComments(idProduct);
		
		req.setAttribute("randomProductsCategory", psv.getRandomProductsByCategory(product.getCategory().getId(), 4, idProduct));
		req.setAttribute("product", product);
		req.setAttribute("comments", comments);
		req.setAttribute("bestRating", getBestRating(comments));
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.getRequestDispatcher("/views/web/productDetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		User user = (User)req.getSession().getAttribute("user");
		if (user == null) {
			 resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.LOGIN_URL);
			 return;
		}
		Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
		String comment = req.getParameter("comment").trim();
		String rating = req.getParameter("rating");
		
		if (comment.equals("")) {
			req.setAttribute("errorMsg", "Bạn cần nhập bình luận");
		}
		else if (rating == null) {
			req.setAttribute("errorMsg", "Bạn cần chọn mức đồ hài lòng");
		}
		else {
			CommentService csv = new CommentServiceImpl();
			if (!csv.addProductComment(user, idProduct, comment, Integer.parseInt(rating))) {
				req.setAttribute("errorMsg", "Đăng bình luận thất bại");
			}
		}
		
		doGet(req, resp);
	}
	
	private static Integer getBestRating(List<Comment> comments) {
		Map<Integer, Integer> gr = new HashMap<Integer, Integer>();
		for (Comment c : comments) {
			Integer r = c.getRating();
			if (gr.get(r) == null) {
				gr.put(r, 1);
			}
			else {
				gr.put(r, gr.get(r) + 1);
			}
		}
		
		Integer starRating = -1;
		Integer mostRating = -1;
		
		for (Integer star : gr.keySet()) {
			if (mostRating <= gr.get(star) && starRating < star) {
				starRating = star;
				mostRating = gr.get(star);
			}
		}
		
		return starRating;
	}
}
