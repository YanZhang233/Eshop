<%@ page language="java" contentType="text/html; charset=utf-8"
 import="java.util.*,entity.Items,dao.ItemsDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>系统商品管理</title>
    <link rel="stylesheet" type="text/css" href="CSS/deleteItem.css">
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
    <div class="delete-item">
        <div class="table-title">商品信息</div>
        <table class="item-table">
            <tr class="thead">
                <th>商品</th>
                <th>单价</th>
                <th>产地</th>
                <th>目录</th>
                <th>类型</th>
                <th class="option">操作</th>
            </tr>
             <%  
             	ItemsDao idao = new ItemsDao();
             	ArrayList<Items> list=idao.getAllItems();
      			if(list!=null&&list.size()>0)
      			{
    	  			for(Items item:list)
    	  			{ 
	 		%>
            <tr class="titem">
                <td class="info-left">
                    <img class="itemimag" src="Image/items/<%=item.getPicture()%>" alt="<%=item.getName() %>" width="120" height="120">
                    <span class="name"><%=item.getName() %></span>
                </td>
                <td class="price">￥<%=item.getPrice() %></td>
                <td><%=item.getCity() %></td>
                <td><%=item.getCategory() %></td>
                <td><%=item.getType() %></td>
                <td class="option">
                    <button class="button" onclick="del();location.href='DeItemsServlet?id=<%=item.getId() %>&flag=delete'">删&nbsp;除</button>
                </td>
            </tr>
            		<%}
    	  		}%>
        </table>
        <div class="add"></div>
    </div>
    <div id="myModal" class="modal">
        <span class="close">✗</span>
        <img class="modal-content" id="img01">
        <div id="caption"></div>
    </div>
    <script>
        // 获取模态窗口
        var modal = document.getElementById('myModal');

        // 获取图片模态框，alt 属性作为图片弹出中文本描述
        var imgs = document.getElementsByClassName('itemimag');
        var modalImg = document.getElementById("img01");
        var captionText = document.getElementById("caption");
        for(var x=0;x<imgs.length;x++)
        {
            imgs[x].onclick = function()
            {
                modal.style.display = "block";
                modalImg.src = this.src;
                modalImg.alt = this.alt;
                captionText.innerHTML = this.alt;
            }
        }
        // 获取 <span> 元素，设置关闭模态框按钮
        var span = document.getElementsByClassName("close")[0];

        // 点击 <span> 元素上的 (x), 关闭模态框
        span.onclick = function() {
            modal.style.display = "none";
        }
    </script>
</body>
</html>

