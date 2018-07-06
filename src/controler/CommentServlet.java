package controler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDao;
import entity.Comment;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String flag = null;

	public CommentServlet() {
		super();

	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("text/html;chartset=utf-8");
		
		//≈–∂œcookie «∑Ò¥Ê‘⁄
		int f=0;
		Cookie cookies[] = request.getCookies();
		for(int i=0;i<cookies.length;i++)
		{
			if(cookies[i].getName().equals("user"))
			{
				f=1;
				break;
			}
		}
		
		if(f==0)
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
		else
		{
			
				String username = (String) request.getSession().getAttribute("username");
				String comment = request.getParameter("comment");
				int itemId = Integer.parseInt(request.getParameter("id"));
				Date date = new Date();
				CommentDao dao = new CommentDao();
				dao.addComment(username, itemId, comment, date);
				request.getRequestDispatcher("/details.jsp").forward(request, response);
		} 

	}

}
