<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	
	<script type="text/javascript">
		$(function(){
			$(".delete").click(function(){
				var lastName = $(this).next(":input").val();
				var flag = confirm("确定删除_"+lastName+"_的信息？");
				if(flag){
					console.log("确定");
					//1.ajax删除数据库数据
					var url = this.href;
					var args = {"time":new Date()};
					var node = $(this).parent().parent();
					$.post(url, args, function(data){
					console.log("data:"+data);
						//2.返回对应得值 并操作也面
						//2.1返回1删除成功 删除页面信息
						if(data == "1"){
							node.remove();
						}
						//2.2返回其他值提示删除失败
						else{
							alert("删除失败");
						}
					});
					
					
					
					
					
				}
				return false;
			});
		});
	</script>
	
</head>
  <body>
    <s:if test="#request.employees == null ||#request.employees.size() == 0">
    	无任何信息
    </s:if>
    <s:else>
    	<table border="1" cellpadding="10" cellspacing="0">
    		<tr>
    			<td>ID</td>
    			<td>LastName</td>
    			<td>Email</td>
    			<td>Birth</td>
    			<td>CreateTime</td>
    			<td>DemptmentName</td>
    			
    			<td>Delete</td>
    			<td>Edit</td>
    		</tr>
    		<s:iterator value="#request.employees">
    		<tr>
    			<td>${id}</td>
    			<td>${lastName }</td>
    			<td>${email }</td>
    			<td>
    				<s:date name="birth" format="yyyy-MM-dd"/>
    			</td>
    			<td>
    				<s:date name="createTime" format="yyyy-MM-dd hh:mm:ss"/>
    			</td>
    			<td>${Department.departmentName }</td>
    			
    			<td>
    				<a href="emp-delete?id=${id}" class="delete">Delete</a>
    				<input type="hidden" value="${lastName}">
    			</td>
    			
    			<td>
    				<!-- 将该员工信息回显到emp-input.jsp -->
    				<a href="emp-input?id=${id}">Edit</a>
    			</td>
    		</tr>
    		</s:iterator>
    	</table>
    </s:else>
  </body>
 
</html>















