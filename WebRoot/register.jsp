<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="CSS/register.css">
</head>
<body>
    <div class="register">
        <ul>
            <li><a class="login" href="login.jsp">登录</a></li>
            <li><a class="present" href="register.jsp">注册</a></li>
        </ul>
        <div class="register-table">
            <form name="register" action="RegisterServlet" method="post">
                <td><span class="tinfo">用户名&nbsp;&nbsp;</span><input class="round" type="text" name="username">&nbsp;${haveRegister }</td>
                <br>
                <td><span class="tinfo">密&nbsp;码&nbsp;&nbsp;</span><input class="round" type="password" name="password"></td>
                <br>
                <td>
                    <span class="tinfo">性&nbsp;别&nbsp;&nbsp;</span>
                    <input class="bottom" type="radio" name="gender" value="男"><span class="tinfo">男</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input class="bottom" type="radio" name="gender" value="女"><span class="tinfo">女</span>
                </td>
                <br>
                <td>
                    <span class="tinfo">邮&nbsp;箱&nbsp;&nbsp;</span><input class="round" type="email" name="email">
                </td>
                <br>
                <td>
                    <span class="tinfo">收货地址&nbsp;</span><input class="round" type="text" name="address">
                </td>
                <br>
                <td>
                    <span class="tinfo">联系方式&nbsp;</span><input class="round" type="text" name="cellphone">
                </td>
                <br>
                <td>
                    <input class="button" type="submit" value="注册">
                    <input class="button left" type="reset" value="重置">&nbsp;${error}
                </td>
            </form>
        </div>
    </div>
</body>
</html>