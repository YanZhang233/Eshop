package controler;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemsDao;
import entity.Items;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SearchServlet() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("charset=utf-8");
		request.setCharacterEncoding("utf-8");
		//request.getSession().removeAttribute("list");
		String search=request.getParameter("search");
		/*if(search.equals("")){
			ItemsDao idao = new ItemsDao();
			 ArrayList<Items> list=idao.getAllItems();
			 request.getSession().setAttribute("list", list);
			 response.sendRedirect(request.getContextPath()+"/searchShow.jsp");
		}*/
		//else{
			ItemsDao idao = new ItemsDao();
			 ArrayList<Items> list=idao.search(search);
			 request.getSession().setAttribute("list", list);
			 request.setAttribute("search",search);
			 request.getRequestDispatcher("/searchShow.jsp").forward(request, response);
		//}
	}

}
