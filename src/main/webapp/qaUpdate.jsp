<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    String URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String sql = "UPDATE questions SET title = ?, content = ? WHERE id = ?";

    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection conn = DriverManager.getConnection(URL, "root", "1234");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setInt(3, Integer.parseInt(id));
        
        pstmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }    
%>

<!-- 알림창 띄운 후, 상세보기 페이지로 이동 -->
<script>
    alert("글 수정이 완료되었습니다.");
    window.location.href = "qaDetail.jsp?id=<%= id %>";
</script>
	