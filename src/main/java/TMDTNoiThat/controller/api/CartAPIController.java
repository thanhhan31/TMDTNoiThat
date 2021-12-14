package TMDTNoiThat.controller.api;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.CartService;
import TMDTNoiThat.services.impl.CartServiceImpl;

@WebServlet(urlPatterns = "/api/cart-api")
public class CartAPIController extends HttpServlet {
	private static final long serialVersionUID = 2436170931238389050L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		CartService csv = new CartServiceImpl();
		Map<String, String> d = new LinkedHashMap<String, String>();
		d.put("status", "200");
		
		try {
			d.put("totalQuantity", csv.getTotalCartQuantity(user.getId()).toString());
		} catch (Exception e) {
			d.put("status", "400");
			d.put("message", e.toString());
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		CartService csv = new CartServiceImpl();
		
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		
		if (action.equals("add")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			Integer quantity = Integer.parseInt(req.getParameter("quantity"));
			if (csv.addProductCart(user.getId(), idProduct, quantity)) {
				d.put("status", "200");
			}
			else {
				d.put("status", "400");
				d.put("message", "Thêm sản phẩm vào giỏ hàng không thành công");
			}
		}
		else if (action.equals("adjust")) {
			Integer idProduct = Integer.parseInt(req.getParameter("idProduct"));
			
			if (req.getParameter("quantity") == null) {
				if (csv.removeProductCart(user.getId(), idProduct)) {
					d.put("status", "200");
				}
				else {
					d.put("status", "400");
					d.put("message", "Xóa sản phẩm khỏi giỏ hàng không thành công");
				}
			}
			else {
				if (csv.adjustProductCartQuantity(user.getId(), idProduct, Integer.parseInt(req.getParameter("quantity")))) {
					d.put("status", "200");
				}
				else {
					d.put("status", "400");
					d.put("message", "Thay đổi số lượng sản phẩm trong giỏ hàng không thành công");
				}
			}
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
