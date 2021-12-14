package TMDTNoiThat.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.ProductService;
import TMDTNoiThat.services.UserService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.services.impl.ProductServiceImpl;
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/admin"})
public class AdminHomeController extends HttpServlet {
	private static final long serialVersionUID = -2258529058042048701L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		UserService usv = new UserServiceImpl();
		ProductService psv = new ProductServiceImpl();
		OrderService osv = new OrderServiceImpl();
		
		req.setAttribute("nAdminUsers", usv.countUsers(ConstantValue.ADMIN_ROLE, null));
		req.setAttribute("nSellerUsers", usv.countUsers(ConstantValue.SELLER_ROLE, null));
		req.setAttribute("nNormalUsers", usv.countUsers(ConstantValue.USER_ROLE, null));
		req.setAttribute("nBannedUsers", usv.countUsers(null, false));
		
		req.setAttribute("nProducts", psv.adminCountProducts(null, null, false));
		req.setAttribute("nBannedProducts", psv.adminCountProducts(null, ConstantValue.PRODUCT_DISABLED_ADMIN, false));
		req.setAttribute("nOrders", osv.adminCountOrders(null));
		req.setAttribute("nDeliveriedOrders", osv.adminCountOrders(ConstantValue.DELIVERED_ORDER));
		
		req.setAttribute("user", user);
		req.setAttribute("orderTimes", osv.adminGetYearsOrders());
		req.getRequestDispatcher("/views/admin/report.jsp").forward(req, resp);
	}
}
