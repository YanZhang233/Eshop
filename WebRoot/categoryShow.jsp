<%@ page language="java" contentType="text/html; charset=utf-8"
  import="java.util.*,entity.Items,dao.ItemsDao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品浏览</title>
    <link rel="stylesheet" type="text/css" href="CSS/itemShow.css">
    <script language="javascript">
        function validation(form)
        {
            if(form.search.value==null||form.search.value=="")
            {
                alert("搜索内容不能为空！");
                form.search.focus();
                return false;
            }
            else
            {
                form.submit();
            }
        }
        //判断用户是否登录  
        function getCookie(cname)
		{
			var name = cname + "=";
			var ca = document.cookie.split(';');
			for(var i=0; i<ca.length; i++) 
			{
			  	var c = ca[i].trim();
			  	if (c.indexOf(name)==0) return decodeURIComponent(c.substring(name.length,c.length));
			}
			return "";
		}
        function checkCookie()
		{
			var username=getCookie("user");
			if (username!=""&&username!=null)
  			{
  				document.getElementById("login").innerHTML=username;
  				document.getElementById("login").href="personal.jsp";
  				document.getElementById("register").innerHTML="退出";
  				document.getElementById("register").href="CancelServlet";
  				document.getElementById("cart").href="CartServlet?flag=show";
  				document.getElementById("order").href="OrderServlet?flag=show";
  			}
		}
    </script>
</head>
<body onload="checkCookie()">
    <div class="right">
        <a id="login" class="gray" href="login.jsp">登录</a>&nbsp;
        <a id="register" class="gray" href="register.jsp">注册</a>&nbsp;
        <a id="cart" class="gray" href="login.jsp">购物车</a>&nbsp;
        <a id="order" class="gray" href="login.jsp">订单</a>&nbsp;
        <a class="gray" href="readme.txt">帮助</a>&nbsp;
    </div>
    <hr class="shadow">
    <div class="center">
        <img src="Image/eshop(title).png" alt="eshop" align="left" width="170" height="100">&nbsp;
        <div class="search">
            <form name="Search" action="SearchServlet" method="post">
                <td><input class="round" type="text" name="search" value="搜索相关商品..."></td>
                <td><button class="button button1" onClick="return validation(Search);">搜索</button></td>
            </form>
        </div>
    </div>
    <%
    	String category=(String)request.getAttribute("category");
     %>
    <div class="items">
        <div class="path">
            <p class="pathtext">
                <a class="patha" href="index.jsp">首页&gt;</a>
                <a class="patha" href="CategoryServlet?category=<%=category %>"><%=category %></a>
            </p>
        </div>
        <div class="left">
            <ul>
                <li><a class="guide" href="CategoryServlet?category=<%=category %>"><%=category %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
                <%
                	if(category.equals("衣服"))
                	{
                 %>
                		<li><a class="guide" href="ItemsServlet?category=衣服&type=女装">女装&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=衣服&type=男装">男装&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=衣服&type=童装">童装&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                <%
                	}
                	else if(category.equals("数码"))
                	{
                 %>
                 		<li><a class="guide" href="ItemsServlet?category=数码&type=手机">手机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=数码&type=电脑">电脑&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=数码&type=平板">平板&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                <%
                	}
                	else if(category.equals("家居"))
                	{
                 %>
                 		<li><a class="guide" href="ItemsServlet?category=家居&type=家具">家具&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=家居&type=电器">电器&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=家居&type=食品">食品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                <%
                	}
                	else if(category.equals("运动"))
                	{
                 %>
                 		<li><a class="guide" href="ItemsServlet?category=运动&type=运动装">运动装&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=运动&type=健身器材">健身器材&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=运动&type=体育用品">体育用品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                <%
                	}
                	else
                	{
                 %>
                 		<li><a class="guide" href="ItemsServlet?category=图书&type=书籍">书籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=图书&type=音像">音像&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                		<li><a class="guide" href="ItemsServlet?category=图书&type=艺术品">艺术品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</a></li>
                <%
                	}
                 %>
            </ul>
        </div>
        <div class="show">
        	<%   
        		ArrayList<Items> list=(ArrayList <Items>)session.getAttribute("list");
			  	if(list!=null&&list.size()>0)
			  	{
			    	for(int i=0;i<list.size();i++)
			    	{
			      		Items item=list.get(i);
			    		if(i%3==0)
			    		{
			%>
            <table>
                <tr>
                	 <% }%>
                    <td>
                        <div class="item" onClick="location.href='details.jsp?id=<%=item.getId() %>'">
                            <img src="Image/items/<%=item.getPicture()%>" width="280" height="280">
                            <div class="itemdetail">
                                <div class="name"><%=item.getName() %></div>
                                <div class="price">￥<%=item.getPrice() %></div>
                            </div>
                        </div>
                    </td>
                  <%  if(i%3==2||i==list.size())
                  {%>
                </tr>
                    <% }
           		   }
                }
               %>
            </table>
        </div>
        
        <%
			Integer pageC=(Integer)request.getAttribute("pageCount");
			int pageCount=pageC.intValue();
			//int pageCount=request.getAttribute("pageCount");
			int pageNow=1;
        	String s_pageNow = request.getParameter("pageNow");
    		if(s_pageNow==null)
    		{
    			pageNow = 1;
    		}
    		else
    		{
    			pageNow = Integer.parseInt(s_pageNow);
    		}
    	%>
         
         <div class="page">
         	<ul class="pagination">
        
				<% 
         			if(pageNow!=1&&pageNow!=pageCount)
         			{ 
				%>
		    			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow-1%>">«</a></li>
				<%
		    			for(int i=1;i<=pageCount;i++)
		    			{
				 %>
		    	 			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
		    	 	<% 	}%>

		    	   			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow+1%>">»</a></li>
		    	 <% 
		    	   	}		
		    		else if(pageNow==1)
		    		{
		    	%>
		    			<li><a href="CategoryServlet?category=<%=category %>&pageNow=1">«</a></li>
				<% 
		    			for(int i=1;i<=pageCount;i++)
		    			{
		    	%>

		    	 			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
		    	 	<% 	}%>

		    	   			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow+1%>">»</a></li>
		    	<% 
		    		}
		    		else if(pageNow==pageCount)
		    		{
		    	%>
		    			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow-1%>">«</a></li>
				<% 
		    			for(int i=1;i<=pageCount;i++)
		    			{
		    	%>
		    	 			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
		    	 	<% 	}%>
		    	   			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageCount%>">»</a></li>
		    	<% 	}%>   	   	    	   	 
     	</ul>
     	</div>
    </div>
</body>
</html>