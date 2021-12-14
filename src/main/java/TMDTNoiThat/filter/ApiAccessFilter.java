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

@WebFilter(filterName = "apiAccess", urlPatterns = {"/api/*"})
public class ApiAccessFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		HttpSession session = req.getSession();
		if (session.getAttribute("user") == null){
			resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		}
		else {
			chain.doFilter(request, response);
		}
	}
}
