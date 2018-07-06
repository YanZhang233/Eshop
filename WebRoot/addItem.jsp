<%@ page language="java" contentType="text/html; charset=gbk"
 import="java.util.*,entity.User,dao.UserDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="gbk">
    <title>ϵͳ��Ʒ����</title>
    <link rel="stylesheet" type="text/css" href="CSS/addItem.css">
    <script src="JS/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#flip").click(function(){
                $("#panel").slideToggle("50ms");
            });
        });
        //��֤��
    	function validation()
    	{
    		var form=document.Item;
    		if(form.name.value==null||form.name.value=="")
    		{
    			alert("��Ʒ���Ʋ���Ϊ�գ�");
    			form.name.focus();
    			return false;
    		}
    		if(form.city.value==null||form.city.value=="")
    		{
    			alert("��Ʒ���ز���Ϊ�գ�");
    			form.city.focus();
    			return false;
    		}
    		if(form.price.value==null||form.price.value=="")
    		{
    			alert("��Ʒ�۸���Ϊ�գ�");
    			form.price.focus();
    			return false;
    		}
    		if(form.details.value==null||form.details.value=="")
    		{
    			alert("��Ʒ���鲻��Ϊ�գ�");
    			form.details.focus();
    			return false;
    		}
    		if(form.picture.value==null||form.picture.value=="")
    		{
    			alert("��ƷͼƬ����Ϊ�գ�");
    			form.picture.focus();
    			return false;
    		}
    		return true;
    	}
    	//Ԥ��
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
    <div class="title"><span class="title-text">ϵͳ����</span></div>
    <div class="menu">
        <ul>
            <li><a class="guide" href="adminUser.jsp">�û�����&nbsp;&nbsp;&nbsp;</a></li>
            <li><span class="guide" id="flip">��Ʒ����&nbsp;&nbsp;&nbsp;</span></li>
        </ul>
        <ul id="panel">
            <li><a class="item-guide" href="addItem.jsp">&nbsp;&nbsp;&nbsp;������Ʒ&nbsp;&gt;</a></li>
            <li><a class="item-guide" href="deleteItem.jsp">&nbsp;&nbsp;&nbsp;��Ʒ�¼�&nbsp;&gt;</a></li>
        </ul>
    </div>
    <div class="add-item">
        <div class="table-title">��Ʒ��Ϣ</div>
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
                <td><span class="tinfo">����&nbsp;&nbsp;</span><input class="size-round" type="text" name="name"></td>
                <br>
                <td><span class="tinfo">����&nbsp;&nbsp;</span><input class="size-round" type="text" name="city"></td>
                <br>
                <td><span class="tinfo">�۸�&nbsp;&nbsp;</span><input class="size-round" type="text" name="price"></td>
                <br>
                <td>
                    <span class="left tinfo">���&nbsp;&nbsp;</span>
                    <select name="type" class="left round">
                        <optgroup label="------�·�------">
                            <option value="��װ">��װ</option>
                            <option value="Ůװ">Ůװ</option>
                            <option value="ͯװ">ͯװ</option>
                        </optgroup>
                        <optgroup label="------����------">
                            <option value="�ֻ�">�ֻ�</option>
                            <option value="����">����</option>
                            <option value="ƽ��">ƽ��</option>
                        </optgroup>
                        <optgroup label="------�Ҿ�------">
                            <option value="�Ҿ�">�Ҿ�</option>
                            <option value="����">����</option>
                            <option value="ʳƷ">ʳƷ</option>
                        </optgroup>
                        <optgroup label="------�˶�------">
                            <option value="�˶�װ">�˶�װ</option>
                            <option value="��������">��������</option>
                            <option value="������Ʒ">������Ʒ</option>
                        </optgroup>
                        <optgroup label="------ͼ��------">
                            <option value="�鼮">�鼮</option>
                            <option value="����">����</option>
                            <option value="����Ʒ">����Ʒ</option>
                        </optgroup>
                    </select>
                </td>
                <br>
                <td>
                    <span class="left1 tinfo">����&nbsp;&nbsp;</span>
                    <br>
                    <textarea class="right round" name="details" rows="8" cols="34"></textarea>
                </td>
                <br>
                <td>
                    <input class="button" type="submit" value="������Ʒ">
                </td>
            </form>
        </div>
        <div class="add"></div>
    </div>
  </body>
</html>
