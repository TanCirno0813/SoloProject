<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/shoppingmall";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int id = Integer.parseInt(request.getParameter("id"));
    String title = "";
    String content = "";
    String date = "";
    String writer = "";
    int views = 0;

    try {
        conn = DriverManager.getConnection(url, "root", "1234");

        // 1️⃣ 조회수 증가 쿼리 실행
        String updateSql = "UPDATE notices SET views = views + 1 WHERE id = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        pstmt.close();

        // 2️⃣ 게시글 정보 가져오기
        String selectSql = "SELECT * FROM notices WHERE id = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            writer = rs.getString("writer");
            content = rs.getString("content");
            date = rs.getString("created_at");
            views = rs.getInt("views");  // 조회수 가져오기
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    // 현재 로그인한 사용자의 role 가져오기
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <script>
        function confirmDelete(id) {
            if (confirm("정말 삭제하시겠습니까?")) {
                window.location.href = "noticeDelete.jsp?id=" + id;
            }
        }
    </script>
</head>
<body>
    <h1>공지사항 상세보기</h1>
   
    <p><strong>제목:</strong> <%= title %></p>
    <p><strong>작성자:</strong> <%= writer %></p>
    <p><strong>작성일:</strong> <%= date %></p>
    <p><strong>조회수:</strong> <%= views %></p> <!-- 조회수 표시 -->
    <hr>
    <p><%= content %></p>
    <br>

    <!-- 수정 버튼 -->
    <a href="noticeUpdateForm.jsp?id=<%= id %>">
        <button>수정</button>
    </a>

    <!-- 삭제 버튼 (ADMIN만 보이도록 설정) -->
    <% if ("ADMIN".equals(role)) { %>
        <button onclick="confirmDelete(<%= id %>)">삭제</button>
    <% } %>

    <!-- 목록으로 돌아가기 버튼 -->
    <a href="notice.jsp">
        <button>돌아가기</button>
    </a>
</body>
</html>
