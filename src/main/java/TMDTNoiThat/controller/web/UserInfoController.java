package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.cloudinary.utils.ObjectUtils;
import com.google.gson.Gson;

import TMDTNoiThat.listeners.CloudinaryContext;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.UserService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/user/info"})
@MultipartConfig
public class UserInfoController extends HttpServlet {
	private static final long serialVersionUID = -6415030000169057203L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		req.setAttribute("user", user);
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.getRequestDispatcher("/views/web/userInfo.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.getRequestDispatcher("/views/web/userInfo.jsp").forward(req, resp);
	}
	
	private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String changeType = req.getParameter("userChange");
		User user = (User)req.getSession().getAttribute("user");
		UserService usv = new UserServiceImpl();
		
		if (changeType.equals("info")) {
			String avtUrl = null;
			String username = req.getParameter("username");
			if (username.equals(user.getUsername()))
				username = null;
			
			String phone = req.getParameter("phone");
			if (phone.equals(user.getPhone()))
				phone = null;
			
			if (phone != null) {
				if (usv.checkPhoneExists(phone)) {
					req.setAttribute("msgerror", "Số điện thoại đã tồn tại");
					return;
				}
			}
			
			if (req.getPart("avatar").getSize() > 0) {
				Part avt = req.getPart("avatar");
				byte[] data = MyUtils.inputStreamToByteArray(avt.getInputStream());
				if (data != null) {
					Map response = CloudinaryContext.getCloudinaryContext().uploader().upload(data, ObjectUtils.emptyMap());
					//System.out.println(new Gson().toJson(response));
					avtUrl = response.get("secure_url").toString();
					if (avtUrl == null) {
						req.setAttribute("msgerror", "Tải ảnh lên thất bại, vui lòng thử lại (2)!");
						return;
					}
				}
				else {
					req.setAttribute("msgerror", "Tải ảnh lên thất bại, vui lòng thử lại (1)!");
					return;
				}
			}
			
			if (username != null || phone != null || avtUrl != null) {
				if (usv.updateUser(
						user.getId(),
						null,
						username, 
						null,
						phone, 
						null, 
						avtUrl,
						null)) {
					req.getSession().setAttribute("user", usv.getUser(user.getId()));
				}
				else {
					req.setAttribute("msgerror", "Cập nhật thông tin thất bại!");
					return;
				}
			}
			req.setAttribute("msg", "Thành công");
			req.getRequestDispatcher("/views/web/userInfo.jsp").forward(req, resp);
		}
		else if (changeType.equals("pwd")) {
			String oldPassword = req.getParameter("oldPassword");
			String newPassword = req.getParameter("newPassword");
			String confNewPassword = req.getParameter("confNewPassword");
			
			if (!newPassword.equals(confNewPassword)) {
				req.setAttribute("pwd_msgerror", "Xác nhận mật khẩu không đúng");
				return;
			}
			
			if (!MyUtils.hash_password_SHA256(oldPassword, user.getEmail()).equals(user.getPassword())) {
				req.setAttribute("pwd_msgerror", "Sai mật khẩu cũ");
				return;
			}

			if (!usv.updateUser(user.getId(), null, null, newPassword, null, null, null, null)) {
				req.setAttribute("pwd_msgerror", "Cập nhật mật khẩu thất bại");
				return;
			}
			
			req.getSession().setAttribute("user", usv.getUser(user.getId()));
			req.setAttribute("pwd_msg", "Thành công");
		}
	}
}
