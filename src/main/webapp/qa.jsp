<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String URL = "jdbc:mysql://localhost:3306/shoppingmall";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QA게시판</title>
    
<script>
    function confirmDelete(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "qaDelete.jsp?id=" + id;
        }
    }
</script>
</head>
<body>
    <h2></h2>
    <table border="1">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>삭제</th>
        </tr>
        <%		
            

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, "root", "1234");

                String sql = "SELECT * FROM questions ORDER BY created_at DESC";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><a href="qaDetail.jsp?id=<%= rs.getString("id") %>"><%= rs.getString("title") %></a></td>
            <td><%= rs.getString("writer") %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
          
            
            <td><a href="javascript:void(0);" onclick="confirmDelete(<%= rs.getString("id") %>)">삭제</a></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <br>
    <a href="qaWrite.jsp"><button>질문 작성</button></a>
</body>
</html>