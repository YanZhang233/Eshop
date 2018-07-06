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

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CategoryServlet() {
		super();

	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("charset=utf-8");
		request.setCharacterEncoding("utf-8");
		request.getSession().removeAttribute("list");
		
		String category=(String) request.getParameter("category");
		String page=request.getParameter("pageNow");
		
		int pageNow;
		
		if(page==null)
		{
			pageNow=1;	
		}
		else
		{
			pageNow=Integer.parseInt(page);
		}
		
		ItemsDao idao = new ItemsDao();
		ArrayList<Items> allList = idao.getCategoryItems(category);
		
		ArrayList<Items> list=idao.getCategoryPageItems(pageNow,9,category);
		
		request.getSession().setAttribute("list", list);
		
		int pageCount=0;
		if(allList.size()%9 == 0)
		{
			pageCount = allList.size()/9;
		}
		else
		{
			pageCount = (allList.size()/9)+1;
		}
		
		request.setAttribute("category",category);
		request.setAttribute("pageCount",pageCount);
		
		request.getRequestDispatcher("/categoryShow.jsp").forward(request, response);
	}

}
