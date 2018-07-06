<%@ page language="java" contentType="text/html; charset=utf-8"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>发布商品成功</title>
    <link rel="stylesheet" type="text/css" href="CSS/addSuccess.css">
    <script src="JS/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#flip").click(function(){
                $("#panel").slideToggle("50ms");
            });
        });
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
    <img class="right" src="Image/success.jpg"/>;
    <div class="add-success">✔发布商品成功！</div>
    <a class="return" href="<%=request.getContextPath() %>/addItem.jsp"><u>&lt;返回继续发布商品</u></a>
</body>
</html>
