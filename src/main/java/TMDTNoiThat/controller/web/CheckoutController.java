package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.PaymentMethodServiceImpl;
import TMDTNoiThat.services.impl.ShipInfoServiceImpl;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
	private static final long serialVersionUID = -8764895899642470330L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		List<User> sellers = new ArrayList<User>();
		List<CartItem> checkoutCarts = (List<CartItem>)req.getSession().getAttribute("checkoutCarts");

		Map<Integer, BigDecimal> subTotalPrices = new HashMap<Integer, BigDecimal>();

		for (CartItem c : checkoutCarts) {
			if (!sellers.contains(c.getProduct().getUser())) {
				User seller = c.getProduct().getUser();
				sellers.add(seller);
				
				BigDecimal itemPrice = BigDecimal.ZERO;
				BigDecimal subTotalPrice = BigDecimal.ZERO;
				for (CartItem i : checkoutCarts) {
					if (i.getProduct().getUser().getId() == seller.getId()) {
						itemPrice = i.getProduct().getUnitPrice().multiply(BigDecimal.valueOf(i.getQuantity()));
						subTotalPrice = subTotalPrice.add(itemPrice);
					}
				}
				subTotalPrices.put(seller.getId(), subTotalPrice);
			}
		}
		
		BigDecimal totalPrice = BigDecimal.ZERO;
		for (BigDecimal p : subTotalPrices.values()) {
			totalPrice = totalPrice.add(p);
		}

		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.setAttribute("sellers", sellers);
		req.setAttribute("checkoutCarts", checkoutCarts);
		req.setAttribute("ships", new ShipInfoServiceImpl().getUserShipInfos(user.getId()));
		req.setAttribute("paymentmethods", new PaymentMethodServiceImpl().getAllPaymentMethod());
		req.setAttribute("totalPrice", totalPrice);
		req.setAttribute("subTotalPrices", subTotalPrices);
		req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
	}
}
