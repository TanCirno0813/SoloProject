<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	//세션 체크
	String username = (String) session.getAttribute("username");
	if(username == null){
		response.sendRedirect("loginSuccess.jsp");
	}
	String password = (String) session.getAttribute("password");
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
			<h2>유저 명:<%=username %></h2>
			
		</div>
		<div >	
			<h2>비밀번호:<%=password %></h2>
			
		</div>		
		<div>
			<p>로그인 성공</p>
			<a href = "../index.jsp">메인으로</a>
		</div>
	</div>
</body>
</html>