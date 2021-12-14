package TMDTNoiThat.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import TMDTNoiThat.entity.User;
import TMDTNoiThat.utils.ConstantValue;

@WebFilter(filterName = "sellerAccess", urlPatterns = {"/seller/*"})
public class SellerAccessFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("user");
		if (user == null){
			resp.sendRedirect(request.getServletContext().getContextPath() + ConstantValue.LOGIN_URL + "?returnUrl="  + req.getRequestURL().toString());
		}
		else {
			if (user.getUserRole().getId() != ConstantValue.SELLER_ROLE) {
				resp.sendRedirect(req.getServletContext().getContextPath() + ConstantValue.ERROR_URL + "?msg=2");
			}
			else {
				chain.doFilter(request, response);
			}
		}
	}
}
