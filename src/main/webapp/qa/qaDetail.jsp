<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String loggedInUser = (String) session.getAttribute("name"); // 현재 로그인한 사용자
    String loggedInUser1 = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role"); // 로그인한 사용자의 역할 (USER / ADMIN)
%>

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
    String adminReply = ""; // 🔹 관리자 답변 저장 변수

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
            adminReply = rs.getString("admin_reply"); // 🔹 관리자 답변 가져오기
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) rs.close();
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
        function showReplyForm() {
            document.getElementById("replyForm").style.display = "block";  // 입력 폼 표시
            document.getElementById("editReplyBtn").style.display = "none"; // 수정 버튼 숨김
        }
    </script>

    <style>
        /* 전체 스타일 */
        body {
            background-color: #fffefc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* 최상단 로그인 바 */
        .top-login {
            background-color: #f9f4ff;
            color: #6e57a5;
            padding: 5px 20px;
            font-size: 14px;
            text-align: right;
        }

        .top-login a {
            color: #6e57a5;
            text-decoration: none;
        }

        .top-login a:hover {
            text-decoration: underline;
        }

        /* 헤더 & 네비게이션 */
        header {
            background-color: #DDD4EB;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo a {
            color: #9178B8;
            text-decoration: none;
            font-size: 24px;
        }

        .main-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            gap: 25px;
        }

        .main-nav ul li a {
            color: #6e57a5;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            position: relative;
        }

        .main-nav ul li a::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 0%;
            height: 3px;
            background-color: #9178B8;
            transition: width 0.3s ease-in-out;
        }

        .main-nav ul li a:hover::after {
            width: 100%;
        }

        /* 배너 스타일 */
        .banner {
            width: 100%;
            height: 200px;
            
            color: black;
            text-align: center;
            line-height: 200px;
            font-size: 24px;
            font-weight: bold;
        }

        /* Q&A 상세보기 컨테이너 */
        .qa-container {
            width: 70%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        h2 {
            margin-bottom: 20px;
            color: #6e57a5;
        }

        .qa- .details {
            margin-bottom: 30px;
        }

        .details p {
            font-size: 16px;
            line-height: 1.6;
        }

        .details p strong {
            color: #54485c;
            width: 70px;
            display: inline-block;
        }
        .qa-content {
             padding: 20px;
            background-color: #f6f1ff;
            border-radius: 8px;
            min-height: 150px;
            margin-bottom: 20px;
            white-space: pre-wrap; /* 줄바꿈 처리 */
        }

        .qa-info {
            font-size: 14px;
            color: gray;
            margin-bottom: 10px;
        }

        /* 버튼 스타일 */
        .btn {
            background-color: #6e57a5;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
           
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #5a478f;
        }

        .btn-back {
            margin-top: 10px;
            background-color: #555;
            color: white;
        }

        .btn-back:hover {
            background-color: #777;
        }
         .admin-reply {
            background: #f1f1f1;
            padding: 10px;
            border-radius: 5px;
        }
        

        /* 푸터 */
        footer {
            background-color: #54485c;
            text-align: center;
            padding: 15px;
            margin-top: 20px;
            color: #F5F5F5;
        }
         	
    </style>
</head>
<body>

<!-- 최상단 로그인 파트 -->
<div class="top-login">
    <%
        if (loggedInUser != null) {
    %>
        <span><%= loggedInUser %>님 안녕하세요</span> |
        <a href="../cart/cart.jsp">🛒 장바구니</a> |
        <a href="../register/checkpasswordForm.jsp">회원정보수정</a> |
        <a href="../login/logout.jsp">로그아웃</a>    
    <% } else { %>
        <a href="../login/login.jsp">로그인</a> | 
        <a href="../register/register.jsp">회원가입</a>
    <% } %>
</div>

<!-- 로고 & 네비게이션 -->
<header>
    <h1 class="logo"><a href="../index.jsp">🖥 키보드 쇼핑몰</a></h1>
    <nav class="main-nav">
        <ul>
            <li><a href="../products/products.jsp">제품 리스트</a></li>
            <li><a href="../notice/notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
</header>

<!-- 배너 -->
<div class="banner">📝 Q&A 상세보기 📝</div>

<!-- Q&A 상세보기 컨테이너 -->
<div class="qa-container">
	<div class = "details">
    <p><strong>제목:</strong> <%= title %></p>
    <p><strong>작성자:</strong> <%= writer %> </p>
    <p><strong>조회수:</strong> <%= views %></p>
    <p><strong>작성일:</strong> <%= date %></p>
    </div>
    <hr>
    <p class="qa-content"><%= content %></p>
  <div class="admin-reply">
        <h3>💬 관리자 답변</h3>
        <% if (adminReply != null && !adminReply.trim().isEmpty()) { %>
            <p><%= adminReply %></p>
            <% if ("ADMIN".equals(role)) { %>
                <button id="editReplyBtn" class="btn" onclick="showReplyForm()">✏ 수정</button>
            <% } %>
        <% } else { %>
            <p style="color: gray;">❌ 아직 답변이 없습니다.</p>
        <% } %>
    </div>
      <!-- 🔹 관리자 답변 입력 폼 (초기에 숨김) -->
    <% if ("ADMIN".equals(role)) { %>
    <div id="replyForm" class="hidden">
        <form action="qaReplyProcess.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <textarea name="admin_reply" required style="width: 100%; height: 100px;"></textarea>
            <br>
            <button type="submit" class="btn">💾 답변 등록</button>
        </form>
    </div>
    <% } %>
     <!-- 작성자만 수정 & 삭제 가능 -->
    <% if(loggedInUser1 != null && loggedInUser1.equals(writer)) { %>
        <a href="qaUpdateForm.jsp?id=<%=id%>">
            <button class="btn">수정</button>
        </a>
        <button class="btn" onclick="confirmDelete(<%= id %>)">삭제</button>
    <% } %>
    <a href="qa.jsp">
        <button class="btn btn-back">목록으로</button>
    </a>
</div>

<footer>
    © 2025 키보드 쇼핑몰. All rights reserved.
</footer>

</body>
</html>
