<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'emp-input.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$(":input[name=lastName]").change(function(){
				var lastName = $(this).val();
				var $this = $(this);
				console.log("lastName:"+lastName);
				var url = "emp-validateLastName";
				var args = {"lastName":lastName,"time":new Date()};
				$.post(url, args, function(data){
					console.log("data:"+data);
					
					$this.nextAll("font").remove();
					//数据库中无此记录1
					if(data == "1"){
						$this.after("<font color='green'>lastName可用</font>");
					}
					//数据库中有此记录0
					else if(data == "0"){
						$this.after("<font color='red'>lastName不可用</font>");
					}else{
						alert("服务器正忙...");
					}
				});
			});
		});
	</script>
	
  </head>
  
  <body>
    This is INPUT  JSP page. <br><br>
    
    <s:form method="post" action="emp-save">
    	<s:if test="id !=null">
	    	<s:textfield name="lastName" label="LastName" disabled="true"></s:textfield>
	    	<s:hidden name="id"></s:hidden>
    	</s:if>
		<s:else>
			<s:textfield name="lastName" label="LastName"></s:textfield>
		</s:else>    
    	
    	
    	<s:textfield name="email" label="Email"></s:textfield>
    	<s:textfield name="birth" label="Birth"></s:textfield>
    	<s:select list="#request.departments" 
    		listKey="id" listValue="departmentName"
    		name="department.id" label="Department">
    	</s:select>
    	<s:submit value="提交"></s:submit>
    </s:form>
    
  </body>
</html>
