package TMDTNoiThat.controller.api.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import TMDTNoiThat.services.OrderService;
import TMDTNoiThat.services.impl.OrderServiceImpl;

@WebServlet(urlPatterns = "/api/admin/report-api")
public class ReportAPIController extends HttpServlet {
	private static final long serialVersionUID = -8560235987787788826L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer year = Integer.parseInt(req.getParameter("year"));
		Integer month = Integer.parseInt(req.getParameter("month"));
		
		OrderService osv = new OrderServiceImpl();
		
		if (month == -1) {
			Map<Integer, BigDecimal> m = osv.adminReportIncomeByYear(year);
			
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(new Gson().toJson(m));
		}
		else {
			Map<Integer, BigDecimal> m = osv.adminReportIncomeByMonth(year, month);
			
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(new Gson().toJson(m));
		}
	}

}
