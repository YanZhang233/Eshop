<%@ page language="java" contentType="text/html; charset=utf-8"
   import="java.util.*,entity.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单信息</title>
    <link rel="stylesheet" type="text/css" href="CSS/order.css">
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
		function del()
		{
		  if(!confirm("确认要删除？"))
		  {
			  window.event.returnValue=false;
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
    <div class="order">
        <div class="title">订单信息</div>
        <table class="ordertable">
            <tr class="thead">
                <th>订单号</th>
                <th>用户名</th>
                <th>创建日期</th>
                <th>收货地址</th>
                <th>联系方式</th>
                <th>商品总价</th>
  				<th>状态</th>
  				<th>操作</th>
            </tr>
            <%  
            	ArrayList<Order>list=(ArrayList<Order>)session.getAttribute("orderlist");
            	double money=0.0;
     			int count=0;
				if(list!=null&&list.size()>0)
				{
				   for(Order order:list)
				   {
			%> 
				 		<tr class="titem">
                			<td><%=order.getId() %></td>
                			<td><%=order.getUsername() %></td>
                			<td><%=order.getDate() %></td>
                			<td><%=order.getAddress() %></td>
                			<td><%=order.getCellphone() %></td>
							<td class="price">￥<%=order.getPrice() %></td>
							<td><%=order.getStatus() %></td>
							<td>
								<button class="button2" onclick="del();location.href='OrderServlet?orderid=<%=order.getId() %>&flag=delete'">删&nbsp;除</button>
							</td>
            			</tr>
			 <%
			           	money+=order.getPrice();
            			count++;
			         } 
			    }
			 %>            
        </table>
        <div class="pay">
            <a class="return" href="index.jsp">&lt;返回首页</a>
            <div class="total">共计<%=count %>件商品，付款总额：￥<%=money %></div>
        </div>
        <div class="add"></div>
    </div>
  </body>
</html>
