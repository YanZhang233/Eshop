package controler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDao;
import dao.ItemsDao;
import entity.Cart;
import entity.Items;
import entity.User;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String flag = null;

	public CartServlet() {
		super();

	}

	public void init(ServletConfig config) throws ServletException {

		super.init(config);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;chartset=utf-8");
		
		/*String user=null;
		Cookie cookies[]=request.getCookies();
		for(int i=0;i<cookies.length;i++)
		{
			if(cookies[i].getName().equals("user"))
			{
				user=cookies[i].getValue();
				break;
			}
		}*/
		
		User user = (User) request.getSession().getAttribute("user");
		if(user==null)
		{
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
		else
		{
			flag = request.getParameter("flag");
			if (flag.equals("add")) 
			{
				String num = request.getParameter("num");
				int userId = user.getId();
				String itemId = request.getParameter("itemId");
				ItemsDao idao = new ItemsDao();
				Items item = idao.getItemsById(Integer.parseInt(itemId));
				CartDao dao = new CartDao();
				dao.addGoods(item, Integer.parseInt(num), userId);
				ArrayList<Cart> list = dao.getAllCart(userId);
				request.getSession().setAttribute("cartlist", list);
				response.sendRedirect(request.getContextPath() + "/cart.jsp");
			} 
			else if(flag.equals("delete"))
			{
				String id = request.getParameter("UserId");
				String Iid = request.getParameter("ItemsId");
				int userId = user.getId();
				CartDao dao = new CartDao();
				dao.deleteGoods(Integer.parseInt(id), Integer.parseInt(Iid)); 
				ArrayList<Cart> list = dao.getAllCart(userId);
				request.getSession().setAttribute("cartlist", list);
				request.getRequestDispatcher("/cart.jsp").forward(request, response);
			}
			//flag.equals("show")
			else
			{
				CartDao dao = new CartDao();
				int userId = user.getId();
				ArrayList<Cart> list = dao.getAllCart(userId);
				request.getSession().setAttribute("cartlist", list);
				response.sendRedirect(request.getContextPath() + "/cart.jsp");
			} 
		}
	}

}
