package TMDTNoiThat.controller.api;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.Order;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/momo/notify"})
public class MomoPaymentNotify extends HttpServlet{
	private static final long serialVersionUID = 4028966697279043642L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("errorCode").equals("0")) {
			Integer orderKey = Integer.parseInt(req.getParameter("orderId"));
			OrderService osv = new OrderServiceImpl();
			
			List<Order> orders = osv.getOrderByKey(orderKey);
			if (orders.size() != 0) {
				for (Order o : orders) {
					osv.paidOrder(o.getId(), MyUtils.getCurrentTime(), 2); //idPaymentMethod ~ Momo
				}
			}
			else {
				System.out.println("Momo IPN - Invalid orderKey");
			}
		}
		resp.setStatus(204);
	}
}
