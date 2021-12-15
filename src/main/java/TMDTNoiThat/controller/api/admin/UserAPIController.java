package TMDTNoiThat.controller.api.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
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
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/api/admin/user-api"})
@MultipartConfig
public class UserAPIController extends HttpServlet {
	private static final long serialVersionUID = -2497588066693599799L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("type");
		Map<String, String> d = new LinkedHashMap<>();
		
		if (action.equals("update")) {
			Integer idUser = Integer.parseInt(req.getParameter("idUser"));
			Integer idRole = Integer.parseInt(req.getParameter("idRole"));
			String username = req.getParameter("username");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			Boolean active = req.getParameter("active").equals("true");
			String avtUrl = null;
			
			UserService usv = new UserServiceImpl();
			User u = usv.getUser(idUser);
			
			if (usv.checkEmailExists(email) && !u.getEmail().equals(email)) {
				d.put("status", "400");
				d.put("message", "Địa chỉ email đã tồn tại!");
			}
			else if (usv.checkPhoneExists(phone) && !u.getPhone().equals(phone)) {
				d.put("status", "400");
				d.put("message", "Số điện thoại đã tồn tại!");
			}
			else {
				if (u.getUserRole().getId() == idRole) 
					idRole = null;
				if (u.getUsername().equals(username))
					email = null;
				if (u.getEmail().equals(email))
					email = null;
				if (u.getPhone().equals(phone))
					phone = null;
				if (u.getActive() == active)
					active = null;
				
				if (req.getPart("avatar").getSize() > 0) {
					Part avt = req.getPart("avatar");
					byte[] data = MyUtils.inputStreamToByteArray(avt.getInputStream());
					if (data != null) {
						Map response = CloudinaryContext.getCloudinaryContext().uploader().upload(data, ObjectUtils.emptyMap());
						avtUrl = response.get("secure_url").toString();
						if (avtUrl == null) {
							d.put("status", "400");
							d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Upload failed)!");
						}
					}
					else {
						d.put("status", "400");
						d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Convert failed)!");
					}
				}
				
				if (d.get("status") == null) {
					if (usv.updateUser(idUser, idRole, username, null, phone, email, avtUrl, active)){
						d.put("status", "200");
						if (avtUrl != null)
							d.put("newAvatarLink", avtUrl);
					}
					else {
						d.put("status", "400");
						d.put("message", "Cập nhật thất bại");
					}
				}
			}
		}
		else if (action.equals("create")) {
			Integer idRole = Integer.parseInt(req.getParameter("idRole"));
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			Boolean active = req.getParameter("active").equals("true");
			String avtUrl = null;
			
			UserService usv = new UserServiceImpl();
			
			if (req.getPart("avatar").getSize() > 0) {
				Part avt = req.getPart("avatar");
				byte[] data = MyUtils.inputStreamToByteArray(avt.getInputStream());
				if (data != null) {
					Map response = CloudinaryContext.getCloudinaryContext().uploader().upload(data, ObjectUtils.emptyMap());
					avtUrl = response.get("secure_url").toString();
					if (avtUrl == null) {
						d.put("status", "400");
						d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Upload failed)!");
					}
				}
				else {
					d.put("status", "400");
					d.put("message", "Tải ảnh lên thất bại, vui lòng thử lại (Convert failed)!");
				}
			}
			
			if (d.get("status") == null) {
				int ret = usv.createUser(idRole, username, password, phone, email, avtUrl, active);
				if (ret != 0) {
					d.put("status", "400");
					switch (ret) {
					case 1:
						d.put("message", "Email đã tồn tại");
						break;
					case 2:
						d.put("message", "Số điện thoại đã tồn tại");
						break;
					case -1:
						d.put("message", "Tạo tài khoản thất bại");
						break;
					}
					
					req.getRequestDispatcher("/views/signup.jsp").forward(req, resp);
				}
				else {
					d.put("status", "200");
				}
			}
		}
		else if (action.equals("resetpw")) {
			Integer idUser = Integer.parseInt(req.getParameter("idUser"));
			String password = req.getParameter("password");
			String repassword = req.getParameter("repassword");
			
			if (password.equals(repassword)) {
				UserService usv = new UserServiceImpl();
				if (usv.updateUser(idUser, null, null, password, null, null, null, null)) {
					d.put("status", "200");
				}
				else {
					d.put("status", "400");
					d.put("message", "Đặt lại mật khẩu thất bại");
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Nhập lại mật khẩu sai");
			}
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
