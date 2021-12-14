package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import TMDTNoiThat.entity.CartItem;
import TMDTNoiThat.entity.Order;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;
import TMDTNoiThat.utils.MyUtils;
import TMDTNoiThat.utils.OrdersInfo;

@WebServlet(urlPatterns = {"/api/processpayment"})
public class PaymentProcessController extends HttpServlet {
	private static final long serialVersionUID = -6063307469116287716L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		Integer idShip = Integer.parseInt(req.getParameter("idShip"));
		Integer idPaymentMethod = Integer.parseInt(req.getParameter("paymentType"));
		
		OrderService osv = new OrderServiceImpl();
		OrdersInfo orderInfo;
		
		if (req.getParameter("idOrder") != null) {
			Order order = osv.getOrderById(Integer.parseInt(req.getParameter("idOrder")));
			List<Integer> idOrders = new ArrayList<Integer>();
			idOrders.add(order.getId());

			orderInfo = new OrdersInfo();
			orderInfo.setIdOrders(idOrders);
			orderInfo.setAmount(order.getTotalPrice().setScale(0, RoundingMode.UP).toString());
		}
		else {
			List<CartItem> checkoutCarts = (List<CartItem>)req.getSession().getAttribute("checkoutCarts");
			orderInfo = osv.createOrder(user.getId(), idShip, checkoutCarts);
		}
		
		if (idPaymentMethod == 1) { //Thanh toan khi nhan hang
			boolean error = false;
			
			for (Integer idOrder : orderInfo.getIdOrders()) {
				if (!osv.paidOrder(idOrder, MyUtils.getCurrentTime(), idPaymentMethod)) {
					req.setAttribute("errorMsg", "Lỗi không thể thanh toán đơn hàng");
					req.setAttribute("success", false);
					error = true;
					break;
				}
			}
			
			if (!error) {
				req.setAttribute("totalPrice", new BigDecimal(orderInfo.getAmount()));
				req.setAttribute("success", true);
			}

			req.getRequestDispatcher("/views/web/paymentResult.jsp").forward(req, resp);
		}
		else if (idPaymentMethod == 2) {
			boolean error = false;
			while (!error) {
				Integer orderKey = 0;
				do {
					orderKey = ThreadLocalRandom.current().nextInt(10, 1000000);
				} while (osv.getOrderByKey(orderKey).size() != 0);
				
				Map<String, String> result = 
						MyUtils.generateMomoBill(orderKey.toString(), 
												orderInfo.getAmount(),
												getServerUrl(req) + req.getContextPath());
				if (result != null) {
					if (result.get("errorCode").equals("0")) {
						for (Integer idOrder : orderInfo.getIdOrders()) {
							if(!osv.setOrderKey(idOrder, orderKey)) {
								System.out.println("Khong the gan orderKey cho don hang " + idOrder.toString());
							}
						}
						
						resp.sendRedirect(result.get("payUrl"));
						//System.out.println("payUrl: " + result.get("payUrl"));
						return;
					}
					else if (result.get("errorCode").equals("6")) { //Duplicate orderKey
						continue;
					}
					else {
						req.setAttribute("success", false);
						String errorMsg = String.format(
								"Lỗi không thể tạo yêu cầu thanh toán MoMo (errorCode: '%s', message: '%s', localMessage: '%s') [%s]", 
								result.get("errorCode"),
								result.get("message"),
								result.get("localMessage"),
								new Gson().toJson(result));
						req.setAttribute("errorMsg", errorMsg);
						error = true;
					}
				}
				else {
					req.setAttribute("success", false);
					req.setAttribute("errorMsg", "Lỗi không thể tạo yêu cầu thanh toán MoMo");
					error = true;
				}
			}
			req.getRequestDispatcher("/views/web/paymentResult.jsp").forward(req, resp);
		}
	}
	
	private static String getServerUrl(HttpServletRequest req) {
		return String.format("%s://%s:%s", req.getScheme(), req.getServerName(), req.getServerPort());
	}
}
