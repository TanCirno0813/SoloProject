<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	if(userid.equals("admin")&&password.equals("1234")){
		
		session.setAttribute("userid", userid);
		response.sendRedirect("loginsuccess.jsp");
	}else{
		response.sendRedirect("login.jsp");
	}	
%>

