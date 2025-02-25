<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.sql.*" %>
 <%
 String role = (String) session.getAttribute("role");

 if (role == null || !"ADMIN".equals(role)) {
     out.println("<script>alert('관리자만 접근 가능합니다.'); history.back();</script>");
     return;
 }
 	String id = request.getParameter("id");
 	String URL = "jdbc:mysql://localhost:3306/shoppingmall";
 	String sql = "delete from notices where id="+id;
	Class.forName("com.mysql.cj.jdbc.Driver");
	try(Connection conn  = DriverManager.getConnection(URL,"root","1234");
			Statement stmt = conn.createStatement();
				
				)
		{
			
			stmt.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	response.sendRedirect("notice.jsp");
%>
 