<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.sql.*" %>
 <%
 	String id = request.getParameter("id");
 	String URL = "jdbc:mysql://localhost:3306/shoppingmall";
 	String sql = "delete from questions where id="+id;
	Class.forName("com.mysql.cj.jdbc.Driver");
	try(Connection conn  = DriverManager.getConnection(URL,"root","1234");
			Statement stmt = conn.createStatement();
				
				)
		{
			
			stmt.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	response.sendRedirect("qa.jsp");
%>
 