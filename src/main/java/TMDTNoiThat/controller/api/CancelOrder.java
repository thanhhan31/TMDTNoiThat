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

import TMDTNoiThat.entity.Order;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/api/order/cancelorder"})
public class CancelOrder extends HttpServlet {
	private static final long serialVersionUID = -3770099629706605744L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, String> d = new LinkedHashMap<>();
		
		if (req.getParameter("idOrder") != null)
		{
			Integer idOrder = Integer.parseInt(req.getParameter("idOrder"));
			OrderService osv = new OrderServiceImpl();
			Order o = osv.getOrderById(idOrder);
			
			if (o.getStatus() == ConstantValue.PENDING_ORDER) {
				if (osv.cancelOrder(idOrder)) {
					d.put("status", "200");
				}
				else {
					d.put("status", "400");
					d.put("message", "Lỗi hủy đơn hàng thất bại (Mã đơn hàng: " + idOrder + ")");
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Lỗi không thể hủy đơn hàng");
			}
		}
		else {
			d.put("status", "400");
			d.put("message", "Tham số không hợp lệ");
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
