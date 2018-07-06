package controler;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/CancelServlet")
public class CancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CancelServlet() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getSession().removeAttribute("user");
            request.getSession().removeAttribute("userId");
            request.getSession().removeAttribute("username");
            
            Cookie cookie = new Cookie("user",null);
    		cookie.setMaxAge(0);
    		  
    		response.addCookie(cookie);
                  
            response.sendRedirect(request.getContextPath()+"/index.jsp");
	}

}
