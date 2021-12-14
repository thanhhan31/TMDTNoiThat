package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.ShipInfoService;
import TMDTNoiThat.services.impl.CartServiceImpl;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ShipInfoServiceImpl;

@WebServlet(urlPatterns = "/cart")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 8719471046987468111L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		List<CartItem> unavailableProductCarts = new ArrayList<CartItem>();
		List<CartItem> usercarts = new CartServiceImpl().getUserCart(user.getId());
		for (CartItem c : usercarts) {
			if (c.getProduct().getAvailableQuantity() < c.getQuantity() || c.getProduct().getActive() != 1 || !c.getProduct().getCategory().getActive()) {
				unavailableProductCarts.add(c);
			}
		}
		
		for (CartItem c : unavailableProductCarts) {
			usercarts.remove(c);
		}
		
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.setAttribute("usercarts", usercarts);
		req.setAttribute("unavailableProductCarts", unavailableProductCarts);
		req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		ShipInfoService ssv = new ShipInfoServiceImpl();
		if (ssv.countUserShipInfos(user.getId()) == 0) {
			req.setAttribute("errorMsg", "Vui lòng tạo ít nhất một địa chỉ giao hàng trước khi tiến hành đặt hàng");
			doGet(req, resp);
			return;
		}

		List<CartItem> checkoutCarts = new ArrayList<CartItem>();
		List<CartItem> productCarts = new CartServiceImpl().getUserCart(user.getId());

		String[] arr = req.getParameterValues("idProduct");
		if (arr != null) {
			for (String x : arr) {
				for (CartItem c : productCarts) {
					if (c.getProduct().getId() == Integer.parseInt(x)) {
						checkoutCarts.add(c);
						break;
					}
				}
			}
		}
		else {
			req.setAttribute("errorMsg", "Vui lòng chọn ít nhất một sản phẩm để tiến hành đặt hàng");
			doGet(req, resp);
			return;
		}
		
		req.getSession().setAttribute("checkoutCarts", checkoutCarts);
		resp.sendRedirect(req.getServletContext().getContextPath() +  "/checkout");
	}
}
