<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
	String id =  request.getParameter("id");
	String name =  request.getParameter("name");
	String description =  request.getParameter("description");
	String price =  request.getParameter("price");
	String stock =  request.getParameter("stock");
	String image_url =  request.getParameter("image_url");
	
	String URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String sql = "update products set name= '" + name+"', description= '"+description+"',price= "+price+",stock= "+stock+",image_url= '"+image_url+"' where id= "+id;
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	try(Connection conn  = DriverManager.getConnection(URL,"root","1234");
		Statement stmt = conn.createStatement();
			
			)
	{
		
		stmt.executeUpdate(sql);
	}catch(Exception e){
		e.printStackTrace();
	}	
	
	response.sendRedirect("products.jsp");
%>
