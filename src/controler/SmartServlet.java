package controler;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import dao.ItemsDao;





@WebServlet("/SmartServlet")
public class SmartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public SmartServlet() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  request.setCharacterEncoding("gbk");
		  response.setCharacterEncoding("text/html;chartset=gbk");
		  String path="E:/Myeclipse/Eshop/WebRoot/Image/items";
		  String path2=request.getServletContext().getRealPath("/")+"Image/items";
		  SmartUpload su = new SmartUpload();
		   su.initialize(getServletConfig(),request,response);
		   su.setAllowedFilesList("jpg,gif,png");
		   try {
			su.upload();
			 su.save(path);
			 su.save(path2);
			com.jspsmart.upload.File f1 = su.getFiles().getFile(0);
			String picturename =new String( f1.getFileName());
		     System.out.println(picturename);
		     System.out.println(path);
		     String name=new String(su.getRequest().getParameter("name"));
		     String city=new String(su.getRequest().getParameter("city"));
		     String price=su.getRequest().getParameter("price");
		     String type=new String(su.getRequest().getParameter("type"));
		     String details=new String(su.getRequest().getParameter("details"));
		     
		     String category="";
		     if(type.equals("��װ")||type.equals("Ůװ")||type.equals("ͯװ"))
		     {
		    	 category="�·�";
		     }
		     else if(type.equals("�ֻ�")||type.equals("����")||type.equals("ƽ��"))
		     {
		    	 category="����";
		     }
		     else if(type.equals("�Ҿ�")||type.equals("����")||type.equals("ʳƷ"))
		     {
		    	 category="�Ҿ�";
		     }
		     else if(type.equals("�˶�װ")||type.equals("��������")||type.equals("������Ʒ"))
		     {
		    	 category="�˶�";
		     }
		     //type.equals("�鼮")||type.equals("����")||type.equals("����Ʒ")
		     else
		     {
		    	 category="ͼ��";
		     }
		     
		     ItemsDao dao=new ItemsDao();
		     dao.addItems(name, city, Float.parseFloat(price), picturename, category,type,details);
		     response.sendRedirect(request.getContextPath()+"/addSuccess.jsp");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		   	
	}
	
}



