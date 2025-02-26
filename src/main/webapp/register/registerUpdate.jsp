<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String address = request.getParameter("address");

    String URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String sql = "UPDATE users SET username = ?, password = ?, email = ?, name = ?, address = ? WHERE id = ?";

    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection conn = DriverManager.getConnection(URL, "root", "1234");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, email);
        pstmt.setString(4, name);
        pstmt.setString(5, address);
     
        pstmt.setInt(6, Integer.parseInt(id));
        
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }    
%>


<script>
    alert("회원 정보 수정이 완료되었습니다.");
    window.location.href = "../index.jsp";
</script>