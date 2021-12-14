package TMDTNoiThat.controller.seller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/seller"})
public class SellerHomeController extends HttpServlet {
	private static final long serialVersionUID = -1121925200123819541L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		ProductService psv = new ProductServiceImpl();
		OrderService osv = new OrderServiceImpl();
		Map<Integer, List<Integer>> orderTimes = osv.sellerGetYearsOrders(user.getId());
		
		
		
		req.setAttribute("nAllProducts", psv.sellerCountProducts(user.getId(), null, null, false));
		req.setAttribute("nUnavailableProducts", psv.sellerCountProducts(user.getId(), null, null, true));
		req.setAttribute("nDisabledProducts", psv.sellerCountProducts(user.getId(), null, ConstantValue.PRODUCT_DISABLED_SELLER, false));
		req.setAttribute("nBannedProducts", psv.sellerCountProducts(user.getId(), null, ConstantValue.PRODUCT_DISABLED_ADMIN, false));
		
		req.setAttribute("nAllOrders", osv.sellerCountOrders(user.getId(), null));
		req.setAttribute("nPaidOrders", osv.sellerCountOrders(user.getId(), ConstantValue.PAID_ORDER));
		req.setAttribute("nUnpaidOrders", osv.sellerCountOrders(user.getId(), ConstantValue.PENDING_ORDER));
		req.setAttribute("nCanceledOrders", osv.sellerCountOrders(user.getId(), ConstantValue.CANCELED_ORDER));
		
		req.setAttribute("user", user);
		req.setAttribute("orderTimes", orderTimes);
		req.getRequestDispatcher("/views/seller/report.jsp").forward(req, resp);
	}
	
}
