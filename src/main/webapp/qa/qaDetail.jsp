<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    String loggedInUser = (String) session.getAttribute("username"); // 현재 로그인한 사용자
%>

<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/shoppingmall";
	
	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	
	int id = Integer.parseInt(request.getParameter("id"));
	String title ="";
	String content ="";
	String date= "";
	String writer="";
	int views = 0;
	
	try {
        conn = DriverManager.getConnection(url, "root", "1234");

        // 조회수 증가 쿼리 실행
        String updateSql = "UPDATE questions SET views = views + 1 WHERE id = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        pstmt.close();

        // 게시글 정보 가져오기
        String selectSql = "SELECT * FROM questions WHERE id = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            writer = rs.getString("writer");
            content = rs.getString("content");
            date = rs.getString("created_at");
            views = rs.getInt("views");  
        }
	}catch(Exception e){
		e.printStackTrace();
	} finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
<script>
        function confirmDelete(id) {
            if (confirm("정말 삭제하시겠습니까?")) {
                window.location.href = "qaDelete.jsp?id=" + id;
            }
        }
</script>
</head>
<body>
    <p><strong>제목:</strong> <%=title%></p>
    <p><strong>작성자:</strong> <%= writer %></p>
    <p><strong>조회수:</strong> <%= views %></p>
    <p><strong>작성일:</strong> <%= date%></p>
    <hr>
    <p><%= content %></p>
    <br>

    <!-- 로그인한 사용자와 작성자가 같을 때만 수정, 삭제 표시 -->
    <% if(loggedInUser != null && loggedInUser.equals(writer)) { %>
        <a href="qaUpdateForm.jsp?id=<%=id%>">
            <button>수정</button>
        </a>
        <button onclick="confirmDelete(<%= id %>)">삭제</button>
    <% } %>

    <a href="qa.jsp">
        <button>돌아가기</button>
    </a>
</body>
</html>
