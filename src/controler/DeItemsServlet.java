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


@WebServlet("/DeItemsServlet")
public class DeItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private String flag=null;

    public DeItemsServlet() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		flag=request.getParameter("flag");
		ItemsDao idao = new ItemsDao();
        if(flag.equals("delete"))
        {
        	String id=request.getParameter("id");
        	idao.delItems(Integer.parseInt(id));
   			response.sendRedirect(request.getContextPath()+"/deleteItem.jsp");
        }
        //flag.equals("show")
        else
        {
    		response.sendRedirect(request.getContextPath()+"/deleteItem.jsp");
        }
   
	}

	}


