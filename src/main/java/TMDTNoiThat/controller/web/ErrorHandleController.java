package TMDTNoiThat.controller.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/generalerror"})
public class ErrorHandleController extends HttpServlet {
	private static final long serialVersionUID = -3345252731809253120L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter printWriter = resp.getWriter();
		String body="<h3>Xảy ra lỗi, trang không tồn tại</h3>"
				+ "<a href='" + req.getContextPath() + "'>Quay về trang chủ</a>";
		printWriter.println(body);
	}

}
