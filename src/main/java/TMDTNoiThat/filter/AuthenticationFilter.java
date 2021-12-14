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

import TMDTNoiThat.utils.ConstantValue;

@WebFilter(filterName = "needAuthenticate", urlPatterns = {"/cart", "/user/*"})
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		HttpSession session = req.getSession();
		if (session.getAttribute("user") == null){
			System.out.println(request.getServletContext().getContextPath());
			resp.sendRedirect(request.getServletContext().getContextPath() + ConstantValue.LOGIN_URL + "?returnUrl="  + req.getRequestURL().toString());
		}
		else {
			chain.doFilter(request, response);
		}
	}
}
