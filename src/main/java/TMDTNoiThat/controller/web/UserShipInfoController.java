package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.ShipInfoService;
import TMDTNoiThat.services.impl.CategoryServiceImpl;
import TMDTNoiThat.services.impl.ShipInfoServiceImpl;
import TMDTNoiThat.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/user/shipinfo"})
public class UserShipInfoController extends HttpServlet{
	private static final long serialVersionUID = 7167991606872898408L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User)req.getSession().getAttribute("user");
		
		req.setAttribute("ships", new ShipInfoServiceImpl().getUserShipInfos(user.getId()));
		req.setAttribute("categories", new CategoryServiceImpl().getAllCategories());
		req.getRequestDispatcher("/views/web/userShipInfo.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String changeType = req.getParameter("userChange");
		
		ShipInfoService ssv = new ShipInfoServiceImpl();
		
		Map<String, String> d = new LinkedHashMap<String, String>();
		
		if (changeType.equals("delete")) {
			Integer idShip = Integer.parseInt(req.getParameter("idShip"));
			
			if (!ssv.deleteUserShipInfo(idShip)) {
				d.put("status", "400");
				d.put("message", "Xóa địa chỉ giao hàng thất bại");
			}
			else {
				d.put("status", "200");
			}
		}
		else if(changeType.equals("update")) {	
			Integer idShip = Integer.parseInt(req.getParameter("idShip"));
			String address = req.getParameter("address");
			
			if (address.equals(ssv.getShipInfosInfoById(idShip).getAddress())) {
				d.put("status", "200");
			}
			else {
				if (!ssv.updateUserShipInfo(idShip, address)) {
					d.put("status", "400");
					d.put("message", "Lưu địa chỉ giao hàng thất bại");
				}
				else {
					d.put("status", "200");
				}
			}
		}
		else if(changeType.equals("create")) {
			User user = (User)req.getSession().getAttribute("user");
			String address = req.getParameter("address");
			
			if (!address.equals("")) {
				if (!ssv.addUserShipInfo(user, address)) {
					d.put("status", "400");
					d.put("message", "Thêm địa chỉ giao hàng thất bại");
				}
				else {
					d.put("status", "200");
				}
			}
			else {
				d.put("status", "400");
				d.put("message", "Địa chỉ giao hàng không được trống");
			}
		}
		
		if (d.get("status") != null && d.get("status").equals("200")) { //reload user model in session
			User user = (User)req.getSession().getAttribute("user");
			req.getSession().setAttribute("user", new UserServiceImpl().getUser(user.getId()));
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		resp.getWriter().write(new Gson().toJson(d));
	}
}
