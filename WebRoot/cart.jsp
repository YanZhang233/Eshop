<%@ page language="java" contentType="text/html; charset=utf-8"
 import="entity.Cart,java.util.*,dao.ItemsDao,entity.Items"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <link rel="stylesheet" type="text/css" href="CSS/cart.css">
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
		function allChecked(node)
        {
            var items = document.getElementsByName("items");
            for(var x=0;x<items.length;x++)
            {
                items[x].checked = node.checked;
            }
        }
        function allUnchecked(node)
        {
            var all = document.getElementById("all");
            if(node.checked==false)
            {
                all.checked=false;
            }
        }
		function del()
		{
		  if(!confirm("确认要删除？"))
		  {
			  window.event.returnValue=false;
		  }
  		}
  		//四舍五入
  		function round(v,e)
  		{
			var t=1;
			for(;e>0;t*=10,e--);
			for(;e<0;t/=10,e++);
			return Math.round(v*t)/t;	
		}
  		function account()
        {
            var count=0;
            var total=0;
            var items = document.getElementsByName("items");
            for(var x=0;x<items.length;x++)
            {
                if(items[x].checked == true)
                {
                    var children=items[x].parentNode.parentNode.parentNode.childNodes;
                    var num=parseInt(children[5].innerHTML);
                    var price=parseFloat(children[7].childNodes[1].innerHTML);
                    /*var num=Number(children[5].innerHTML);
                    var price=Number(children[7].childNodes[1].innerHTML);*/
                    count+=num;
                    total+=price;
                }
            }
            document.getElementById("itemsNum").innerHTML=count;
            document.getElementById("itemsPrice").innerHTML=round(total,2);
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
    <div class="cart">
        <div class="title">购物车</div>
        <table class="cart-table">
            <tr class="thead">
                <th>商品信息</th>
                <th>单价（元）</th>
                <th>数量</th>
                <th>金额（元）</th>
                <th class="option">操作</th>
            </tr>
            <%  
            	ArrayList<Cart> list=(ArrayList<Cart>)session.getAttribute("cartlist");
     			ItemsDao dao=new ItemsDao();
     			double money=0.0;
     			int count=0;
      			if(list!=null&&list.size()>0)
      			{
    	  			for(Cart cart:list)
    	  			{
    		 			int id=cart.getItemsId(); 
    	    			Items item=dao.getItemsById(id);
    	     %>
            <tr class="titem">
                <td>
                    <label><input class="check" type="checkbox" name="items" onclick="allUnchecked(this);account()"/></label> 
                    <img class="itemimag" onClick="location.href='#'" src="Image/items/<%=item.getPicture()%>" width="120" height="120">
                    <span class="name"><%=item.getName() %></span>
                </td>
                <td class="price">￥<%=item.getPrice() %></span></td>
                <td><%=cart.getCount() %></td>
                <td class="price">￥<span><%=cart.getTotalPrice() %></span></td>
                <td class="option">
                    <button class="button2" onclick="del();location.href='CartServlet?UserId=<%=cart.getUserId() %>&ItemsId=<%=cart.getItemsId()%>&flag=delete'">删&nbsp;除</button>
                </td>
            </tr> 
            		<%
            			money+=cart.getTotalPrice();
            			count+=cart.getCount();
  					}
    	  		}
    	  			%>                
        </table>
        <table class="paytable">
	        <tr>
	            <td class="total">
	                 <label><input type="checkbox" id="all" onclick="allChecked(this);account()">&nbsp;全选</label> 
	            </td>
	            <td class="total tright">
	               	<span class="up">已选择&nbsp;<span class="items-num"><span id="itemsNum">0</span></span>&nbsp;件商品</span>
	            </td>
	            <td class="total tright">
	               	 合计：&nbsp;<span class="items-price">￥<span id="itemsPrice">0</span></span>
	            </td>
	            <td class="tright">
	                <button class="button3 button4 tleft" onclick="location.href='OrderServlet?price=<%=money %>&flag=add'">结算</button>
	            </td>
	        </tr>
        </table>
        <div class="add"></div>
    </div>
  </body>
</html>
