package TMDTNoiThat.controller.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.services.UserService;
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.ConstantValue;

@WebServlet(urlPatterns = {"/signup"})
public class SignupController extends HttpServlet{
	private static final long serialVersionUID = -1469123468912785710L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/signup.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		UserService usv = new UserServiceImpl();
		
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String retypepassword = req.getParameter("retypepassword");
		String phone = req.getParameter("phone");
		String isSeller = req.getParameter("isSeller");
		
		if (!password.equals(retypepassword)) {
			req.setAttribute("errorMsg", "Nhập lại mật khẩu sai");
			req.getRequestDispatcher("/views/signup.jsp").forward(req, resp);
		}
		
		int ret = usv.createUser(
					(isSeller == null || !isSeller.equals("on")) ? ConstantValue.USER_ROLE : ConstantValue.SELLER_ROLE, 
					username, 
					password, 
					phone, 
					email, 
					null, 
					null);
		
		if (ret != 0) {
			switch (ret) {
			case 1:
				req.setAttribute("errorMsg", "Email đã tồn tại");
				break;
			case 2:
				req.setAttribute("errorMsg", "Số điện thoại đã tồn tại");
				break;
			case -1:
				req.setAttribute("errorMsg", "Tạo tài khoản thất bại");
				break;
			}
			req.getRequestDispatcher("/views/signup.jsp").forward(req, resp);
		}
		else {
			resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.LOGIN_URL + "?msg=1");
		}
	}
}
