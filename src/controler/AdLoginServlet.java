package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminDao;
import dao.UserDao;
import entity.Admin;
import entity.User;


@WebServlet("/AdLoginServlet")
public class AdLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AdLoginServlet() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		if (username == null || username.equals("")) {
			String errorName = "用户名不为空";
			request.getSession().setAttribute("errorName", errorName);

			response.sendRedirect(request.getContextPath()+"/login.jsp");
		} else if (password == null || password.equals("")) {
			String errorPassword = "密码不为空";
			request.getSession().setAttribute("errorPassword", errorPassword);
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		} else {
			AdminDao dao = new AdminDao();
			Admin admin= dao.findAdmin(username, password);
			if (admin == null) {
				String error = "用户名或密码错误！！";
				request.getSession().setAttribute("error", error);
				response.sendRedirect(request.getContextPath()+"/login.jsp");
			} else {
				if (acimage.equals(image)) {
					request.getSession().setAttribute("username", admin.getName());
					response.sendRedirect(request.getContextPath() + "/adminUser.jsp");
					
				} else {
					String errorimage = "验证码错误";
					request.getSession().setAttribute("errorimage", errorimage);

					response.sendRedirect(request.getContextPath() + "/login.jsp");
				}
			}
		}
	}

}
