package TMDTNoiThat.controller.api.seller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;

@WebServlet(urlPatterns = "/api/seller/order-api")
public class OrderAPIController extends HttpServlet {
	private static final long serialVersionUID = -3469333901751408167L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		
		if (action.equals("deliveredOrder")) {
			Integer idOrder = Integer.parseInt(req.getParameter("idOrder"));
			
			OrderService osv = new OrderServiceImpl();
			if (osv.deliveredOrder(idOrder)) {
				d.put("status", "200");
			}
			else {
				d.put("status", "400");
				d.put("message", "Cập nhật trạng thái đơn hàng thất bại");
			}
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
