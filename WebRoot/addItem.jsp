<%@ page language="java" contentType="text/html; charset=gbk"
 import="java.util.*,entity.User,dao.UserDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="gbk">
    <title>系统商品管理</title>
    <link rel="stylesheet" type="text/css" href="CSS/addItem.css">
    <script src="JS/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#flip").click(function(){
                $("#panel").slideToggle("50ms");
            });
        });
        //验证表单
    	function validation()
    	{
    		var form=document.Item;
    		if(form.name.value==null||form.name.value=="")
    		{
    			alert("商品名称不能为空！");
    			form.name.focus();
    			return false;
    		}
    		if(form.city.value==null||form.city.value=="")
    		{
    			alert("商品产地不能为空！");
    			form.city.focus();
    			return false;
    		}
    		if(form.price.value==null||form.price.value=="")
    		{
    			alert("商品价格不能为空！");
    			form.price.focus();
    			return false;
    		}
    		if(form.details.value==null||form.details.value=="")
    		{
    			alert("商品详情不能为空！");
    			form.details.focus();
    			return false;
    		}
    		if(form.picture.value==null||form.picture.value=="")
    		{
    			alert("商品图片不能为空！");
    			form.picture.focus();
    			return false;
    		}
    		return true;
    	}
    	//预览
    	function previewImage(file)
    	{   		
    		var MAXWIDTH  = 600; 
          	var MAXHEIGHT = 600;
          	var div = document.getElementById('preview');
          	div.innerHTML ='<img id=imghead>';
            var img = document.getElementById('imghead');
            img.onload = function()
            {            	
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.naturalWidth, img.naturalHeight);
                img.width  =  rect.width;
                img.height =  rect.height;
            }
            var reader = new FileReader();
            reader.onload = function(evt){img.src = evt.target.result;}
            reader.readAsDataURL(file.files[0]);
    	}
    	function clacImgZoomParam( maxWidth, maxHeight, width, height )
    	{
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight )
            {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;
                 
                if( rateWidth > rateHeight )
                {
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else
                {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
             
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
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
    <div class="add-item">
        <div class="table-title">商品信息</div>
        <div class="information-table">
            <form name="Item" action="SmartServlet" onsubmit="return validation();" method="post" enctype="multipart/form-data">
                <td>
                    <div id="preview">
                        <img id="imghead" width=600 height=600 border=0 src="<%=request.getContextPath()%>/images/defaul.jpg">
                    </div>
                </td>
                <br>
                <td><input class="file" type="file" name="picture" onchange="previewImage(this)" /></td>
                <br>
                <td><span class="tinfo">名称&nbsp;&nbsp;</span><input class="size-round" type="text" name="name"></td>
                <br>
                <td><span class="tinfo">产地&nbsp;&nbsp;</span><input class="size-round" type="text" name="city"></td>
                <br>
                <td><span class="tinfo">价格&nbsp;&nbsp;</span><input class="size-round" type="text" name="price"></td>
                <br>
                <td>
                    <span class="left tinfo">类别&nbsp;&nbsp;</span>
                    <select name="type" class="left round">
                        <optgroup label="------衣服------">
                            <option value="男装">男装</option>
                            <option value="女装">女装</option>
                            <option value="童装">童装</option>
                        </optgroup>
                        <optgroup label="------数码------">
                            <option value="手机">手机</option>
                            <option value="电脑">电脑</option>
                            <option value="平板">平板</option>
                        </optgroup>
                        <optgroup label="------家居------">
                            <option value="家具">家具</option>
                            <option value="电器">电器</option>
                            <option value="食品">食品</option>
                        </optgroup>
                        <optgroup label="------运动------">
                            <option value="运动装">运动装</option>
                            <option value="健身器材">健身器材</option>
                            <option value="体育用品">体育用品</option>
                        </optgroup>
                        <optgroup label="------图书------">
                            <option value="书籍">书籍</option>
                            <option value="音像">音像</option>
                            <option value="艺术品">艺术品</option>
                        </optgroup>
                    </select>
                </td>
                <br>
                <td>
                    <span class="left1 tinfo">详情&nbsp;&nbsp;</span>
                    <br>
                    <textarea class="right round" name="details" rows="8" cols="34"></textarea>
                </td>
                <br>
                <td>
                    <input class="button" type="submit" value="发布商品">
                </td>
            </form>
        </div>
        <div class="add"></div>
    </div>
  </body>
</html>
