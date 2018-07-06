<%@ page language="java" contentType="text/html; charset=utf-8"
 import="java.util.*,entity.Items"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>搜索结果</title>
    <link rel="stylesheet" type="text/css" href="CSS/searchShow.css">
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
        <a class="gray" href="help.txt">帮助</a>&nbsp;
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
    	String search=(String)request.getAttribute("search");
     %>
    <div class="items">
        <div class="search-title">
            	关于“<%=search %>”的搜索结果
        </div>
        <div class="show">
            <table>
            	<%   
				    ArrayList<Items> list=(ArrayList <Items>)session.getAttribute("list");
				  	if(list!=null&&list.size()>0)
				  	{
					    for(int i=0;i<list.size();i++)
					    {
					      	Items item=list.get(i);
					    	if(i%4==0)
					    	{
  				%>
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
                    <%  if(i%4==3||i==list.size()){%>
                </tr>
                    <% }
           		   }
                }
               %>
            </table>
        </div>
        <div class="add"></div>
    </div>
</body>
</html>

