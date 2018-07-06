package controler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import entity.User;

@WebServlet(name = "register", urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		request.getSession().removeAttribute("error");
		request.getSession().removeAttribute("haveRegister");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String cellphone = request.getParameter("cellphone");
		if (username == "" || username == null || password == "" || password == null || email == "" || email == null
				|| address == "" || address == null || cellphone == "" || cellphone == null) {
			String error = "�������ݾ���Ϊ��";
			request.getSession().setAttribute("error", error);
			response.sendRedirect(request.getContextPath() + "/register.jsp");
		}

		else {
			UserDao dao = new UserDao();
			if (dao.findName(username) == true) {
				String haveRegister = "���û�����ע�ᣡ";
				request.getSession().setAttribute("haveRegister", haveRegister);
				response.sendRedirect(request.getContextPath() + "/register.jsp");
			} else {
				User user = new User();
				user.setUsername(username);
				user.setPassword(password);
				user.setGender(gender);
				user.setEmail(email);
				user.setAddress(address);
				user.setCellphone(cellphone);
				boolean flag = dao.add(user);
				if (flag == true) {
					request.getRequestDispatcher("/registerSuccess.jsp").forward(request, response);
				} else
					request.getRequestDispatcher("/registerFailure.jsp").forward(request, response);

			}

		}
	}
}