<%@ page contentType="text/html" pageEncoding="GB2312" language="java"%>
<%@ page import="java.sql.*,entity.Items"%>
<html>
	<head>
		<title>hello</title>
	</head>
	<body>
	<table border="1" spacing="2">
<%!
	public static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static final String USER = "sa";
	public static final String PASS = "123123123";
	public static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=Eshop";
	public static final int PAGESIZE = 5;
	int pageCount;
	int curPage = 1;
%>
<%
	//一页放5个
	String user = null;
	String pass = null;
	try{
		Class.forName(DRIVER);
		Connection con = DriverManager.getConnection(URL,USER,PASS);
		String sql = "select *from Items;";
		PreparedStatement stat = con.prepareStatement(sql,ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
		ResultSet rs = stat.executeQuery();
		rs.last();
		int size = rs.getRow();
		pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);
		String tmp = request.getParameter("curPage");
		if(tmp==null){
			tmp="1";
		}
		curPage = Integer.parseInt(tmp);
		if(curPage>=pageCount) curPage = pageCount;
		boolean flag = rs.absolute((curPage-1)*PAGESIZE+1);
		out.println(curPage);
		int count = 0;
		
		do{
			if(count>=PAGESIZE)break;
			Items item = new Items();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				item.setCategory(rs.getString("category"));
				item.setType(rs.getString("type"));
				item.setDetail(rs.getString("detail"));
			count++;
			%>
		<tr>
			<td><%=item.getId()%></td>
			<td><%=item.getName()%></td>
			<td><%=item.getCity()%></td>
			<td><%=item.getPrice()%></td>
			<td><%=item.getPicture()%></td>
			<td><%=item.getCategory()%></td>
			<td><%=item.getType()%></td>
			<td><%=item.getDetail()%></td>
		</tr>
			<%
		}while(rs.next());
		con.close();
	}
	catch(Exception e){
		
	}
%>
</table>
<a href = "test.jsp?curPage=1" >首页</a>
<a href = "test.jsp?curPage=<%=curPage-1%>" >上一页</a>
<a href = "test.jsp?curPage=<%=curPage+1%>" >下一页</a>
<a href = "test.jsp?curPage=<%=pageCount%>" >尾页</a>
第<%=curPage%>页/共<%=pageCount%>页

</body>
</html>