package controler;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import entity.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();

	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String acimage = request.getParameter("image").toUpperCase();
		String image = (String) request.getSession().getAttribute("image");
		request.getSession().removeAttribute("errorimage");
		request.getSession().removeAttribute("image");
		request.getSession().removeAttribute("errorName");
		request.getSession().removeAttribute("errorPassword");
		request.getSession().removeAttribute("error");
		
		Cookie cookie = new Cookie("user",URLEncoder.encode(username, "UTF-8"));
		cookie.setMaxAge(3600);
		  
		response.addCookie(cookie);
		
		
		if (username == null || username.equals("")) {
			String errorName = "�û�����Ϊ��";
			request.getSession().setAttribute("errorName", errorName);

			response.sendRedirect(request.getContextPath()+"/login.jsp");
		} else if (password == null || password.equals("")) {
			String errorPassword = "���벻Ϊ��";
			request.getSession().setAttribute("errorPassword", errorPassword);
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		} else {
			UserDao dao = new UserDao();
			User u = dao.findUser(username, password);
			if (u == null) {
				String error = "�û������������";
				request.getSession().setAttribute("error", error);
				response.sendRedirect(request.getContextPath()+"/login.jsp");
			} else {
				if (acimage.equals(image)) {
					
					request.getSession().setAttribute("user", u);
					request.getSession().setAttribute("userId", u.getId());
					request.getSession().setAttribute("username", u.getUsername());
					response.sendRedirect(request.getContextPath() + "/index.jsp");
					
				} else {
					String errorimage = "��֤�����";
					request.getSession().setAttribute("errorimage", errorimage);

					response.sendRedirect(request.getContextPath() + "/login.jsp");
				}
			}
		}
	}

}
