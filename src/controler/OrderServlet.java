package controler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDao;
import dao.OrderDao;
import entity.Order;
import entity.User;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String flag=null;
	public OrderServlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("utf=8");
		flag=request.getParameter("flag");
		OrderDao dao=new OrderDao();
		User u=(User) request.getSession().getAttribute("user");
		if(u==null)
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
		else
		{
			String username=u.getUsername();
			if(flag.equals("add"))
			{
				String address=u.getAddress();
				String cellphone=u.getCellphone();
				int userid=u.getId();
				Date date=new Date();
				String status="≈…ÀÕ÷–";
				String price=request.getParameter("price");

				dao.addOrder(username, date, address, cellphone, status,Float.parseFloat(price));
				
				ArrayList<Order>list =dao.findAll(username);
				request.getSession().setAttribute("orderlist",list);
				CartDao cdao=new CartDao();
				cdao.deleteGoodsByUserId(userid);
				response.sendRedirect(request.getContextPath()+"/order.jsp");
			
			}
			else if(flag.equals("delete"))
			{
				String orderid=request.getParameter("orderid");
				dao.deleteOrder(Integer.parseInt(orderid));	
				ArrayList<Order>list =dao.findAll(username);
				request.getSession().setAttribute("orderlist",list);
				request.getRequestDispatcher("/order.jsp").forward(request, response);	
			}
			//flag.equals("show")
			else
			{
				ArrayList<Order>list =dao.findAll(username);
				request.getSession().setAttribute("orderlist",list);
				response.sendRedirect(request.getContextPath()+"/order.jsp");
			}
		}
	}
	

}
