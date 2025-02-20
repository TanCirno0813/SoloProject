<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String title =  request.getParameter("title");
	String content =  request.getParameter("content");
	String writer = request.getParameter("writer");
	
	String URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String sql = "insert into notices (title, content, writer) values(?,?,?)";
	Class.forName("com.mysql.cj.jdbc.Driver");
	try(Connection conn  = DriverManager.getConnection(URL,"root","1234");
			 PreparedStatement pstmt = conn.prepareStatement(sql))
		{
			 pstmt.setString(1, title);
	        pstmt.setString(2, content);
	        pstmt.setString(3, writer);
	        pstmt.executeUpdate();
%>	
	     <script>
            alert("공지사항이 등록되었습니다.");
            window.location.href = "notice.jsp";
        </script>
	   <% 	
		}catch (Exception e) {
	        e.printStackTrace();
	        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
	    }
	
%>