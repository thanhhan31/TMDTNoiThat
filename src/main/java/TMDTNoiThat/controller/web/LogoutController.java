package TMDTNoiThat.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 8682753961725897436L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		if (user != null)
			req.getSession().invalidate();
		resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.HOME_URL);
	}
}
