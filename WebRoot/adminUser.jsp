<%@ page language="java" contentType="text/html; charset=utf-8"
 import="java.util.*,entity.User,dao.UserDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>系统用户管理</title>
    <link rel="stylesheet" type="text/css" href="CSS/adminUser.css">
    <script src="JS/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#flip").click(function(){
                $("#panel").slideToggle("50ms");
            });
        });
        function del()
		{
		  if(!confirm("确认要删除？"))
		  {
			  window.event.returnValue=false;
		  }
  		}
    </script>
</head>
<body>
    <div class="red"></div>
    <div class="title"><span class="title-text">系统管理</span></div>
    <div class="menu">
        <ul>
            <li><a class="guide" href="adminUser.jsp">用户管理&nbsp;&nbsp;&nbsp;</a></li>
            <li><span class="guide" id="flip">商品管理&nbsp;&nbsp;&nbsp;</span></li>
        </ul>
        <ul id="panel">
            <li><a class="item-guide" href="addItem.jsp">&nbsp;&nbsp;&nbsp;发布商品&nbsp;&gt;</a></li>
            <li><a class="item-guide" href="deleteItem.jsp">&nbsp;&nbsp;&nbsp;商品下架&nbsp;&gt;</a></li>
        </ul>
    </div>
    <div class="admin-users">
        <div class="table-title">用户信息</div>
        <table class="user-table">
            <tr class="thead">
                <th>ID</th>
                <th>用户名</th>
                <th>密码</th>
                <th>性别</th>
                <th>邮箱</th>
                <th>地址</th>
                <th>联系方式</th>
                <th class="option">操作</th>
            </tr>
            <%  
            	UserDao dao=new UserDao();
            	ArrayList<User>list=dao.getAllUser();
			      if(list!=null&&list.size()>0)
			      {
			    	  for(User user:list)
			    	  {     
			 %>
            <tr class="tuser">
                <td><%=user.getId() %></td>
				<td><%=user.getUsername() %></td>
				<td><%=user.getPassword() %></td>
				<td><%=user.getGender() %></td>
				<td><%=user.getEmail() %></td>
				<td><%=user.getAddress() %></td>
				<td><%=user.getCellphone() %></td>
                <td class="option">
                    <button class="button" onclick="del();location.href='PersonalServlet?id=<%=user.getId() %>&flag=delete'">删&nbsp;除</button>
                </td>
            </tr>
            		<%}
    	 	 	 }%>           
        </table>
        <div class="add"></div>
    </div>
</body>
</html>