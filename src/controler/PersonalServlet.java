package controler;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import entity.User;

@WebServlet("/PersonalServlet")
public class PersonalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private String flag=null;

    public PersonalServlet() {
        super();
    }
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		request.setCharacterEncoding("utf-8");
   		response.setContentType("text/html; charset=utf-8");
   		flag=request.getParameter("flag");
   		if(flag.equals("update"))
   		{
	   		request.getSession().removeAttribute("user");
	        String id=request.getParameter("id");
	   		String username = request.getParameter("username");
	   		String password = request.getParameter("password");
	   		String gender = request.getParameter("gender");
	   		String email = request.getParameter("email");
	   		String address = request.getParameter("address");
	   		String cellphone = request.getParameter("cellphone");
	   		UserDao dao=new UserDao();
	   		dao.updateInformation(username, password, gender, email, address, cellphone,Integer.parseInt(id));
	   		User u = dao.findUser(username, password);
	   		request.getSession().setAttribute("user", u);
	   		response.sendRedirect(request.getContextPath()+"/updateSuccess.jsp");
   		}
   		else if(flag.equals("delete"))
   		{
   			String id=request.getParameter("id");
   			UserDao dao=new UserDao();
   			dao.delete(Integer.parseInt(id));
   	   		response.sendRedirect(request.getContextPath()+"/adminUser.jsp");
   		}
   		//flag.equals("show")
   		else
   		{
   			/*UserDao dao=new UserDao();
   			ArrayList<User>list=dao.getAllUser();
   			request.getSession().setAttribute("list",list);*/
   			response.sendRedirect(request.getContextPath()+"/adminUser.jsp");
   		}
	}
}
