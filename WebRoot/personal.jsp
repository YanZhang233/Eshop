<%@ page language="java" contentType="text/html; charset=utf-8"
  import="entity.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <link rel="stylesheet" type="text/css" href="CSS/personal.css">
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
    <div class="user">
        <div class="title">个人中心</div>
        <% 
        	User user=(User)session.getAttribute("user");
		%>
        <div class="user-table">
            <form name="personalCenter" action="PersonalServlet?id=<%=user.getId() %>&flag=update" method="post">
            <tr>
                <td><span class="tinfo">用户名&nbsp;&nbsp;</span><input class="round" type="text" name="username" value="<%=user.getUsername()%>"></td>
                <br>
                <td><span class="tinfo">密&nbsp;码&nbsp;&nbsp;</span><input class="round" type="password" name="password" value="<%=user.getPassword() %>"></td>
                <br>
                <td>
                    <span class="tinfo">性&nbsp;别&nbsp;&nbsp;</span>&nbsp;
                    <%  String gender=user.getGender().trim();
  						if(gender.equals("男")){%>
                	<input class="bottom" type="radio" name="gender" value="男" checked><span class="tinfo">男</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input class="bottom" type="radio" name="gender" value="女"><span class="tinfo">女</span>
                    <% }else if(gender.equals("女")){%>
                    <input class="bottom" type="radio" name="gender" value="男"><span class="tinfo">男</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input class="bottom" type="radio" name="gender" value="女" checked><span class="tinfo">女</span>
                     <%} %>
                </td>
                <br>
                <td>
                    <span class="tinfo">邮&nbsp;箱&nbsp;&nbsp;</span><input class="round" type="email" name="email" value="<%=user.getEmail()%>">
                </td>
                <br>
                <td>
                    <span class="tinfo">收货地址&nbsp;</span><input class="round" type="text" name="address" value="<%=user.getAddress() %>">
                </td>
                <br>
                <td>
                    <span class="tinfo">联系方式&nbsp;</span><input class="round" type="text" name="cellphone" value="<%=user.getCellphone()%>">
                </td>
                <br>
                <td>
                    <input class="change" type="submit" value="确认修改">
                    <input class="reset" type="reset" value="重置">
                </td>
            </tr>
            </form>
        </div>
        <div class="add"></div>
    </div>
</body>
</html>