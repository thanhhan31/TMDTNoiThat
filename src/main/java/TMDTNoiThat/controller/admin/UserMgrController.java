package TMDTNoiThat.controller.admin;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.entity.UserRole;
import TMDTNoiThat.services.UserRoleService;
import TMDTNoiThat.services.UserService;
import TMDTNoiThat.services.impl.UserRoleServiceImpl;
import TMDTNoiThat.services.impl.UserServiceImpl;
import TMDTNoiThat.utils.MyUtils;

@WebServlet(urlPatterns = {"/admin/users"})
public class UserMgrController extends HttpServlet {
	private static final long serialVersionUID = 4279406682178538457L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserService usv = new UserServiceImpl();
		UserRoleService ursv = new UserRoleServiceImpl();
		List<UserRole> userRoles = ursv.getAllUserRoles();
		
		List<User> users;
		int currentPage = 0;
		int userCount = -1;
		int pagesize = 10;
		Integer idRole = null;
		Boolean status = null;
		
		if (req.getParameter("idRole") != null) {
			idRole = Integer.parseInt(req.getParameter("idRole"));
		}
		
		if (req.getParameter("page") != null) {
			currentPage = Integer.parseInt(req.getParameter("page"));
		}
		
		if (req.getParameter("pagesize") != null) {
			pagesize = Integer.parseInt(req.getParameter("pagesize"));
		}
		
		if (req.getParameter("status") != null) {
			Integer tmp = Integer.parseInt(req.getParameter("status"));
			status = tmp.intValue() == 1;
		}
		
		userCount = usv.countUsers(idRole, status).intValue();
		users = usv.getUsers(idRole, status, currentPage * pagesize, pagesize);
		
		Map<UserRole, Long> userRoleQty = new LinkedHashMap<UserRole, Long>();
		for (UserRole c : userRoles) {
			userRoleQty.put(c, usv.countUsers(c.getId(), status));
		}
		
		req.setAttribute("pages",
				MyUtils.paginate(currentPage, (int)Math.ceil((double)userCount/pagesize), 1));
		req.setAttribute("user", (User)req.getSession().getAttribute("user"));
		req.setAttribute("users", users);
		req.setAttribute("userRoles", userRoles);
		req.setAttribute("userRoleQty", userRoleQty);
		req.getRequestDispatcher("/views/admin/user.jsp").forward(req, resp);
	}
}
