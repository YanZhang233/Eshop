<%@ page language="java" contentType="text/html; charset=utf-8"
   import="entity.User" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>eshop</title>
    <link rel="stylesheet" type="text/css" href="CSS/index.css">
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
        <ul>
            <div class="menu">
                <li><a class="guide leftRound" href="CategoryServlet?category=衣服">衣服</a>&nbsp;</li>
                <div class="menuContent">
                    <div class="menutext">
                        <a href="ItemsServlet?category=衣服&type=女装">女装</a>
                        <a href="ItemsServlet?category=衣服&type=男装">男装</a>
                        <a href="ItemsServlet?category=衣服&type=童装">童装</a>
                    </div>
                    <div class="menuimag">
                        <img src="Image/index/clothes.jpg" width="800" height="350">
                    </div>
                </div>
            </div>
            <div class="menu">
                <li><a class="guide" href="CategoryServlet?category=数码">数码</a>&nbsp;</li>
                <div class="menuContent">
                    <div class="menutext">
                        <a href="ItemsServlet?category=数码&type=手机">手机</a>
                        <a href="ItemsServlet?category=数码&type=电脑">电脑</a>
                        <a href="ItemsServlet?category=数码&type=平板">平板</a>
                    </div>
                    <div class="menuimag">
                        <img src="Image/index/electrics.jpg" width="800" height="350">
                    </div>
                </div>
            </div>
            <div class="menu">
                <li><a class="guide" href="CategoryServlet?category=家居">家居</a>&nbsp;</li>
                <div class="menuContent">
                    <div class="menutext">
                        <a href="ItemsServlet?category=家居&type=家具">家具</a>
                        <a href="ItemsServlet?category=家居&type=电器">电器</a>
                        <a href="ItemsServlet?category=家居&type=食品">食品</a>
                    </div>
                    <div class="menuimag">
                        <img src="Image/index/home.jpg" width="800" height="350">
                    </div>
                </div>
            </div>
            <div class="menu">
                <li><a class="guide" href="CategoryServlet?category=运动">运动</a>&nbsp;</li>
                <div class="menuContent">
                    <div class="menutext">
                        <a href="ItemsServlet?category=运动&type=运动装">运动装</a>
                        <a href="ItemsServlet?category=运动&type=健身器材">健身器材</a>
                        <a href="ItemsServlet?category=运动&type=体育用品">体育用品</a>
                    </div>
                    <div class="menuimag">
                        <img src="Image/index/sport.jpg" width="800" height="350">
                    </div>
                </div>
            </div>
            <div class="menu">
                <li><a class="guide rightRound" href="CategoryServlet?category=图书">图书</a>&nbsp;</li>
                <div class="menuContent">
                    <div class="menutext">
                        <a href="ItemsServlet?category=图书&type=书籍">书籍</a>
                        <a href="ItemsServlet?category=图书&type=书籍">音像</a>
                        <a href="ItemsServlet?category=图书&type=艺术品">艺术品</a>
                    </div>
                    <div class="menuimag">
                        <img src="Image/index/book.jpg" width="800" height="350">
                    </div>
                </div>
            </div>
        </ul>
    </div>
    <a href="#"><img class="mainimag" src="Image/index/main1.jpg"></a>
    <button class="button2" style="vertical-align:middle" onClick="location.href='CategoryServlet?category=家居'"><span>今日推荐</span></button>
    <div class="recimag">
        <div class="imag" onClick="location.href='details.jsp?id=46'">
            <img src="Image/index/pop1.jpg" width="200" height="150">
            <div class="container">
                <p>花瓶</p>
            </div>
        </div>
        <div class="imag" onClick="location.href='details.jsp?id=47'">
            <img src="Image/index/pop2.jpg" width="200" height="150">
            <div class="container">
                <p>笔记本</p>
            </div>
        </div>
        <div class="imag" onClick="location.href='details.jsp?id=48'">
            <img src="Image/index/pop3.jpg" width="200" height="150">
            <div class="container">
                <p>玻璃杯</p>
            </div>
        </div>
        <div class="imag" onClick="location.href='details.jsp?id=49'">
            <img src="Image/index/pop4.jpg" width="200" height="150">
            <div class="container">
                <p>猫</p>
            </div>
        </div>
    </div>
    <div class="about">
        <img class="scan" src="Image/index/scan.png" alt="eshop" width="160" height="160">&nbsp;
        <div class="contact">
            <p>热线：4000-800-111</p>
            <p>邮箱：Eshop@gmail.com</p>
            <p>周一至周日：09:00-22:00</p>
        </div>
    </div>
</body>
</html>