<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="CSS/login.css">
    <script src="CSS/jquery-1.10.2.min.js"></script> 
    <script type="text/javascript">
		function reload()
		{
			var time=new Date().getTime();
			document.getElementById("know").src="<%=request.getContextPath()%>/ImageServlet?d="+time;
		}
	</script>
</head>
<body>
    <div class="login">
        <ul>
            <li><a class="present" href="login.jsp">登录</a></li>
            <li><a class="register" href="register.jsp">注册</a></li>
        </ul>
        <div class="login-table">
            <form name="login" method="post">
                <td><span class="tinfo">用户名&nbsp;</span><input class="round" type="text" name="username">&nbsp;${errorName}${error}</td>
                <br>
                <td><span class="tinfo">密&nbsp;码&nbsp;</span><input class="round" type="password" name="password">&nbsp;${errorPassword}</td>
                <br>
                <td><span class="tinfo">验证码&nbsp;</span><input class="valround" type="text" name="image">&nbsp;<img alt="验证码" src="ImageServlet" id="know" />&nbsp;<a class="val" href="javascript:reload()">看不清楚</a>&nbsp;${errorimage }</td>
                <br>
                <td>
                    <button class="user" name="user" onClick="document.login.action='LoginServlet';document.login.submit();">用户登录</button>
                    <button class="admin" name="admin" onClick="document.login.action='AdLoginServlet';document.login.submit();">管理员登录</button>
                </td>
            </form>
        </div>
    </div>
</body>
</html>
