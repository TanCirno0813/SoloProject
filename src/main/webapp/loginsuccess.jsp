<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	//세션 체크
	String userid = (String) session.getAttribute("userid");
	if(userid == null){
		response.sendRedirect("loginSuccess.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공 확인 창</title>
</head>
<body>
<div>
		<div >	
			<h2>유저 명:<%=userid %></h2>
			
		</div>	
		<div>
			<p>로그인 성공</p>
			<a href = "index.jsp">메인으로</a>
		</div>
	</div>
</body>
</html>