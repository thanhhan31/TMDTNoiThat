package TMDTNoiThat.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.UserService;
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = -2060040973662802834L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		
		if (user != null) {
			String role = user.getUserRole().getName();
			if (role.equals("Admin")) {
				resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.ADMIN_HOME_URL);
			}
			else {
				resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.HOME_URL);
			}
		}
		else {
			String returnUrl = req.getParameter("returnUrl");
			if (returnUrl != null) {
				req.setAttribute("returnUrl", returnUrl);
			}
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		String returnUrl = req.getParameter("returnUrl");
		String rememberMe = req.getParameter("rememberMe");
		
		if (user == null) {
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			UserService u = new UserServiceImpl();
			user = u.getUser(email, password);
			if (user != null) {
				if (user.getActive()) {
					session = req.getSession();
					
					if (rememberMe != null && rememberMe.equals("on")) {
						session.setMaxInactiveInterval(24 * 60 * 60);
					}
					else {
						session.setMaxInactiveInterval(5 * 60);
					}
					
					session.setAttribute("user", user);
					if (returnUrl != null) {
						resp.sendRedirect(returnUrl);
					}
					else {
						String role = user.getUserRole().getName();
						if (role.equals("Admin")) {
							resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.ADMIN_HOME_URL);
						}
						else {
							resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.HOME_URL);
						}
					}
				}
				else {
					req.setAttribute("errorMsg", "Tài khoản đã bị vô hiệu hóa");
					if (returnUrl != null)
						req.setAttribute("returnUrl", returnUrl);
					req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
				}
			}
			else {
				req.setAttribute("errorMsg", "Sai địa chỉ email hoặc mật khẩu");
				if (returnUrl != null)
					req.setAttribute("returnUrl", returnUrl);
				req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			}
		}
		else {
			String role = user.getUserRole().getName();
			if (role.equals("Admin")) {
				resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.ADMIN_HOME_URL);
			}
			else {
				resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.HOME_URL);
			}
		}
	}
}
