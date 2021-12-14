package TMDTNoiThat.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/error"})
public class ErrorPageController extends HttpServlet {
	private static final long serialVersionUID = 247200250910868862L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String msg = req.getParameter("msg");
		if (msg.equals("1")) {
			req.setAttribute("errorMsg", "Bạn không thể truy cập trang quản trị hệ thống vì bạn không phải là quản trị viên");
		}
		else if (msg.equals("2")) {
			req.setAttribute("errorMsg", "Bạn không thể truy cập trang quản lý bán hàng vì bạn không phải là người bán hàng");
		}
		
		req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
	}

}
