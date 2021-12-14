package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/momo/return"})
public class MomoReturnController extends HttpServlet {
	private static final long serialVersionUID = 694778902988496681L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("return payment GET");
		Enumeration<String> att  = req.getParameterNames();
		while (att.hasMoreElements()) {
			String k = att.nextElement();
			String v = req.getParameter(k);
			System.out.println(k + ":" + v);
		}
		
		System.out.println("end return payment GET");
		
		req.setCharacterEncoding("UTF-8");
		
		if (req.getParameter("errorCode").equals("0")) {
			req.setAttribute("idOrder", req.getParameter("orderId"));
			req.setAttribute("totalPrice", new BigDecimal(req.getParameter("amount")));
			req.setAttribute("success", true);
		}
		else {
			req.setAttribute("success", false);
			String errorMsg = String.format(
					"Thanh toán trực tuyến MoMo thất bại (orderId: '%s', amount: '%s', errorCode: '%s', message: '%s', localMessage: '%s')", 
					req.getParameter("orderId"),
					req.getParameter("amount"),
					req.getParameter("errorCode"),
					req.getParameter("message"),
					req.getParameter("localMessage"));
			req.setAttribute("errorMsg", errorMsg);
		}
		req.getRequestDispatcher("/views/web/paymentResult.jsp").forward(req, resp);
	}
}
