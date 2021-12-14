package TMDTNoiThat.controller.web;

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
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.services.impl.PaymentMethodServiceImpl;
import TMDTNoiThat.services.impl.ShipInfoServiceImpl;
import TMDTNoiThat.utils.ConstantValue;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/user/orders"})
public class UserOrdersController extends HttpServlet{
	private static final long serialVersionUID = 8355444898379272262L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*User user = (User)req.getSession().getAttribute("user");
		
		OrderService osv = new OrderServiceImpl();

		List<Order> orders;
		int currentPage = 0;
		int status = -2;
		int orderCount = -1;
		
		if (req.getParameter("page") != null) {
			currentPage = Integer.parseInt(req.getParameter("page"));
		}

		if (req.getParameter("status") != null) {
			status = Integer.parseInt(req.getParameter("status"));
		}
		
		if (status == -1) {
			orderCount = osv.userCountCanceledOrders(user.getId()).intValue();
			int start = currentPage * ConstantValue.ORDERS_PER_PAGE;
		    int end = start + ConstantValue.ORDERS_PER_PAGE;
		    if (end > orderCount) {
		    	end = orderCount;
		    }
		    orders = osv.userGetCanceledOrders(user.getId(), start, ConstantValue.ORDERS_PER_PAGE);
		}
		else if (status == 0) {
			orderCount = osv.userCountUnpaidOrders(user.getId()).intValue();
			int start = currentPage * ConstantValue.ORDERS_PER_PAGE;
		    int end = start + ConstantValue.ORDERS_PER_PAGE;
		    if (end > orderCount) {
		    	end = orderCount;
		    }
		    orders = osv.userGetUnpaidOrders(user.getId(), start, ConstantValue.ORDERS_PER_PAGE);
		}
		else if (status == 1) {
			orderCount = osv.userCountPaidOrders(user.getId()).intValue();
			int start = currentPage * ConstantValue.ORDERS_PER_PAGE;
		    int end = start + ConstantValue.ORDERS_PER_PAGE;
		    if (end > orderCount) {
		    	end = orderCount;
		    }
		    orders = osv.userGetPaidOrders(user.getId(), start, ConstantValue.ORDERS_PER_PAGE);
		}
		else if (status == 2) {
			orderCount = osv.userCountDeliveredOrders(user.getId()).intValue();
			int start = currentPage * ConstantValue.ORDERS_PER_PAGE;
		    int end = start + ConstantValue.ORDERS_PER_PAGE;
		    if (end > orderCount) {
		    	end = orderCount;
		    }
		    orders = osv.userGetDeliveredOrders(user.getId(), start, ConstantValue.ORDERS_PER_PAGE);
		}
		else { //status == -2
			orderCount = osv.userCountAllOrders(user.getId()).intValue();
			int start = currentPage * ConstantValue.ORDERS_PER_PAGE;
		    int end = start + ConstantValue.ORDERS_PER_PAGE;
		    if (end > orderCount) {
		    	end = orderCount;
		    }
		    orders = osv.userGetAllOrders(user.getId(), start, ConstantValue.ORDERS_PER_PAGE);
		}
		
	    req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)orderCount/ConstantValue.ORDERS_PER_PAGE), 1));
		req.setAttribute("orders", orders);
		req.setAttribute("user", user);
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.setAttribute("ships", new ShipInfoServiceImpl().getUserShipInfos(user));
		req.setAttribute("paymentmethods", new PaymentMethodServiceImpl().getAllPaymentMethod());
		req.getRequestDispatcher("/views/web/userOrders.jsp").forward(req, resp);*/
		
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
		
		orderCount = osv.userCountOrders(user.getId(), status).intValue();
		orders = osv.userGetOrders(user.getId(), status, currentPage * pagesize, pagesize);
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)orderCount/pagesize), 1));
		req.setAttribute("pagesize", pagesize);
		req.setAttribute("orders", orders);
		req.setAttribute("user", user);
		
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.setAttribute("ships", new ShipInfoServiceImpl().getUserShipInfos(user.getId()));
		req.setAttribute("paymentmethods", new PaymentMethodServiceImpl().getAllPaymentMethod());
		
		req.getRequestDispatcher("/views/web/userOrders.jsp").forward(req, resp);
	}
}
