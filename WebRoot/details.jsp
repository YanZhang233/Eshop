<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.util.*,entity.Items,entity.Comment,dao.ItemsDao,dao.CommentDao,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品详情</title>
    <link rel="stylesheet" type="text/css" href="CSS/details.css">
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
		function inc()
		{
			var num=document.getElementById("count").value;
			num++;
			document.getElementById("count").value=num;
		}
		function dec()
		{
			var num=document.getElementById("count").value;
			if(num>1)
			{
				num--;
			}	
			document.getElementById("count").value=num;
		}
		function getNum()
		{
			var num=document.getElementById("count").value;
			return num;
		}
		function comment(form)
        {
            if(form.comment.value==null||form.comment.value=="")
            {
                alert("评论内容不能为空！");
                form.comment.focus();
                return false;
            }
            else
            {
                form.submit();
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
		ItemsDao dao = new ItemsDao();
		Items item = dao.getItemsById(Integer.parseInt(request.getParameter("id")));
	    if(item!=null)
	    {
	%>
    <div class="item">
        <div class="itemImag">
            <img src="Image/items/<%=item.getPicture()%>" width="600" height="600">
        </div>
        <div class="detail">
            <div class="name"><%=item.getName()%></div>
            <div class="price">￥<%=item.getPrice()%></div>
            <div class="city">产地：&nbsp;<%=item.getCity()%></div>
            <div class="type">分类：&nbsp;<%=item.getCategory()%>&gt;<%=item.getType()%></div>
            <hr class="bound1">
            <div class="description">
                	详情：<br><br>&nbsp;&nbsp;<%=item.getDetail()%>
            </div>
            <hr class="bound1">
            <div class="number">数量：&nbsp;</div>
	        <table class="count">
	        	<tr>
	            	<td><span class="num-gray" onclick="dec()">-</span></td>
	            	<td><input id="count" class="num" type="text" value="1"></td>
	            	<td><span class="num-gray" onclick="inc()">+</span></td>
	            </tr>
	        </table>
            <div class="cart">
                <button id="addCart" class="button2 button3" onClick="location.href='CartServlet?num='+getNum()+'&itemId=<%=item.getId() %>'+'&flag=add'">加入购物车</button>
            </div>
        </div>
        <div class="comment">商品评价</div>
        <%  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			CommentDao cdao = new CommentDao();
			ArrayList<Comment> list = cdao.fianAll(item.getId());
    		if(list!=null)
    		{
    			for(Comment comment:list)
    			{  
		%>
		<table>
			<tr>
        		<div class="mes">
            		<div class="user-mes"><%=comment.getMessage() %></div>
            		<span class="user"><%=comment.getUsername() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sdf.format(comment.getDate()) %></span>
        		</div>
        	</tr>
        </table>
        <% 		}
    		}
    		%>
        <div class="message">
            <form name="Comment" action="CommentServlet?id=<%=item.getId() %>" method="post">
            <tr>
                <td><textarea class="Mes" name="comment" rows="8" cols="50"></textarea></td><br>
                <td><button class="button button1 submitMes" onClick="return comment(Comment);">发表评论</button></td>
            </tr>
            </form>
        </div>
        <%
	       }
		%>
         <hr class="bound2">
        <div class="record">浏览记录</div>
        <% 
		   String list="";
		  Cookie[] cookies= request.getCookies();
		  if(cookies!=null&&cookies.length>0){
			  for(Cookie c:cookies){
				  if(c.getName().equals("ViewName")){
					 list= c.getValue();
				  }
			  }
		  }
			  list+=request.getParameter("id")+",";
			  String []arr=list.split(",");
			  if(arr!=null&&arr.length>0){
				  if(arr.length>6)list="";
			  }
			  Cookie cookie=new Cookie("ViewName",list);
			  response.addCookie(cookie);
		  
		%>	
        <table class="record-table">
        <tr>
        <% ArrayList <Items> itemslist=dao.getViewList(list);
		 
	       if(itemslist!=null&&itemslist.size()>0){
	    	   
	    	  for(int i=0;i<itemslist.size();i++){
	    		  Items it=itemslist.get(i);
		%>
            <td>
                <div class="Record" onClick="location.href='details.jsp?id=<%=it.getId() %>'">
                    <img src="Image/items/<%=it.getPicture()%>" width="210" height="210">
                    <div class="itemdetail">
                        <div class="record-name"><%=it.getName()%></div>
                        <div class="record-price">￥<%=it.getPrice()%></div>
                    </div>
                </div>
            </td>
            <% }
			}
			%>
        </tr>
        </table>
        <div class="add"></div>
    </div>
</body>
</html>
