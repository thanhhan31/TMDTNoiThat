package TMDTNoiThat.controller.seller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.Order;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/seller/orders"})
public class OrderMgrController extends HttpServlet {
	private static final long serialVersionUID = -4024158413748171203L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		User user = (User)req.getSession().getAttribute("user");
		OrderService osv = new OrderServiceImpl();
		
		List<Order> orders;
		int currentPage = 0;
		int orderCount = -1;
		int pagesize = 10;
		
		Integer status = null;

		if (req.getParameter("status") != null) {
			status = Integer.parseInt(req.getParameter("status"));
		}
		
		if (req.getParameter("pagesize") != null) {
			pagesize = Integer.parseInt(req.getParameter("pagesize"));
		}
		
		if (req.getParameter("page") != null) {
			currentPage = Integer.parseInt(req.getParameter("page"));
		}
		
		orderCount = osv.sellerCountOrders(user.getId(), status).intValue();
		orders = osv.sellerGetOrders(user.getId(), status, currentPage * pagesize, pagesize);
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)orderCount/pagesize), 1));
		req.setAttribute("pagesize", pagesize);
		req.setAttribute("orders", orders);
		req.setAttribute("user", user);
		req.getRequestDispatcher("/views/seller/order.jsp").forward(req, resp);
	}
}
