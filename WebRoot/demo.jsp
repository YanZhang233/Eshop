<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dividePage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <h1>分页显示</h1>
    <%
    	//定义四个分页会用到的变量
    	int pageSize = 4;
    	int pageNow = 1;
    	int rowCount = 0;
    	int pageCount = 0;
    	
    	//接收用户希望显示的页数（pageNow）
    	String s_pageNow = request.getParameter("pageNow");
    	if(s_pageNow!=null){
    		pageNow = Integer.parseInt(s_pageNow);
    	}
    	
    	//查询得到rowCount
    	
    	//连接数据库
    	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;databaseName=Eshop";
		String user = "sa";
		String password = "123123123";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,user,password);
				
		Statement sta = conn.createStatement();
		ResultSet rs = sta.executeQuery("select * from Items");
		//PreparedStatement ps = null;
		//PreparedStatement ps2 = null;
		//String sql1 = "select * from Items";
		//ps = conn.prepareStatement(sql1);
		//ResultSet rs = ps.executeQuery();
		
		if(rs.next()){
			rowCount = rs.getInt(1);
		}
		//计算pageCount
		if(rowCount%pageSize == 0){
			pageCount = rowCount/pageSize;
		}else{
			pageCount = rowCount/pageSize+1;
		}
    	//查询出需要显示的记录

    	rs = sta.executeQuery("SELECT top 4 * FROM Items where id not in (select top 4 id from Items order by id) order by id");
    	//pageSize*(pageNow-1)+","+pageSize
    	
    	
    	
    	/*String sql2 = "SELECT top 4 * FROM Items where id not in (select top ? id from Items order by id) order by id";
    	ps2 = conn.prepareStatement(sql2);
			ps2.setInt(1, pageSize*(pageNow-1));
		rs = ps2.executeQuery();*/
    //显示
    %>
    
    <table border="1" style="border-collapse:collapse;">
    	<tr>
    		<td>id</td><td>name</td><td>city</td><td>price</td>
    		<td>picture</td><td>category</td><td>type</td><td>detail</td>
    	</tr>
    
    <%	
    	while(rs.next()){
    %>
    	<tr>
    	<td><%= rs.getInt(1) %></td><td><%= rs.getString(2) %></td><td><%= rs.getString(3) %></td><td><%= rs.getFloat(4) %></td>
    	<td><%= rs.getString(5) %></td><td><%= rs.getString(6) %></td><td><%= rs.getString(7) %></td><td><%= rs.getString(8) %></td>
    	</tr>
   
    <% 
    	}
     %>
     </table>
     <%
     	//上一页
     	if(pageNow!=1){
     		out.println("<a href=dividePage.jsp?pageNow="+(pageNow-1)+">上一页</a>");
     	}
     	for(int i=1;i<=pageCount;i++){
     		out.println("<a href=dividePage.jsp?pageNow="+i+">["+i+"]</a>");
		}
		//下一页
     	if(pageNow!=pageCount){
     		out.println("<a href=dividePage.jsp?pageNow="+(pageNow+1)+">下一页</a>");
     	}
     	
      %>
  </body>
</html>


<div class="page">
         	<ul class="pagination">
         <%
	     	//上一页
	     	if(pageNow!=1)
	     	{
	     %>
	     		<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow-1%>">«</a></li>
	     <%	}
	     	for(int i=1;i<=pageCount;i++)
	     	{ 
	      		if(i==pageNow)
	      		{
	      %>
	      			<li><a class="active" href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
	      <% 
	      		}
	      		else
	      		{
	      %>
	      			<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
	     <% 
	     		}
			}
			//下一页
	     	if(pageNow!=pageCount)
	     	{
	     %>
	     		<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=pageNow+1%>">»</a></li>
	     <% 
	     	}
	     	}
     	 %>
         	</ul>
         </div>  


 <%
     	//上一页
     	if(pageNow!=1){
     		out.println("<a href=CategoryServlet?category=category&pageNow="+(pageNow-1)+">上一页</a>");
     	}
     	for(int i=1;i<=pageCount;i++){
     		out.println("<a href=CategoryServlet?category=category&pageNow="+i+">["+i+"]</a>");
		}
		//下一页
     	if(pageNow!=pageCount){
     		out.println("<a href=CategoryServlet?category=category&pageNow="+(pageNow+1)+">下一页</a>");
     	}
     	
      %>

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






                            if(i==pageNow)
				 			{
				 %>
		    	 				<li><a class="active" href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>
		    	<% 
		    	 			}
		    	 			else
		    	 			{
		    	%>
		    	 				<li><a href="CategoryServlet?category=<%=category %>&pageNow=<%=i%>"><%=i%></a></li>