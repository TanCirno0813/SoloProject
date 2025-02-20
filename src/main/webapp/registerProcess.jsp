<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");

	  Connection conn = null;
	  PreparedStatement pstmt = null;
	  try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

	        String sql = "INSERT INTO users (username, password, email, name, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, username);
	        pstmt.setString(2, password);
	        pstmt.setString(3, email);
	        pstmt.setString(4, name);
	        pstmt.setString(5, phone);
	        pstmt.setString(6, address);

	        int rows = pstmt.executeUpdate();
	        if (rows > 0) {
	%>
	            <script>
	                alert("회원가입이 완료되었습니다.");
	                window.location.href = "login.jsp"; // 로그인 페이지로 이동
	            </script>
	<%
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
	    } finally {
	        if (pstmt != null) pstmt.close();
	        if (conn != null) conn.close();
	    }

%>