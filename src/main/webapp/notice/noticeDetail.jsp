<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String loggedInUser = (String) session.getAttribute("name");
	
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
    String fileName = null; // 🔸 여기에 추가해줌 (미리 선언)

    try {
        conn = DriverManager.getConnection(url, "root", "1234");

        // 조회수 증가
        String updateSql = "UPDATE notices SET views = views + 1 WHERE id = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        pstmt.close();

        // 게시글 정보 가져오기
        String selectSql = "SELECT * FROM notices WHERE id = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            writer = rs.getString("writer");
            content = rs.getString("content");
            date = rs.getString("created_at");
            views = rs.getInt("views");
            fileName = rs.getString("file_name"); // 🔸 ResultSet 닫기 전에 미리 가져오기
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    // 로그인한 사용자의 role 가져오기
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <style>
        body {
            background-color: #fffbf5;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }
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

/* 헤더와 네비게이션 통합 스타일 */
header {
    background-color: #DDD4EB;
    padding: 10px 20px;
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logo a {
    color: #9178B8;
    text-decoration: none;
    font-size: 24px;
}

/* 깔끔하고 심플한 네비게이션 스타일 */
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
    padding: 5px 0;
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
        .container {
            width: 70%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        h1 {
            color: #9178B8;
            border-bottom: 2px solid #DDD4EB;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .details {
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

        .content {
            padding: 20px;
            background-color: #f6f1ff;
            border-radius: 8px;
            min-height: 150px;
            margin-bottom: 20px;
            white-space: pre-wrap; /* 줄바꿈 처리 */
        }

        .btn {
            background-color: #9178B8;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 15px;
            margin-right: 5px;
        }

        .btn:hover {
            background-color: #54485c;
        }

        .file-download {
            margin-top: 15px;
            padding: 10px;
            background-color: #DDD4EB;
            border-radius: 5px;
              margin-bottom: 20px; /* 버튼과의 간격 확보 */
        }

        .file-download a {
            color: #4B2C80;
            text-decoration: none;
            font-weight: bold;
        }

        .file-download a:hover {
            text-decoration: underline;
        }
    </style>

    <script>
        function confirmDelete(id) {
            if (confirm("정말 삭제하시겠습니까?")) {
                window.location.href = "noticeDelete.jsp?id=" + id;
            }
        }
    </script>
</head>
<body>
<div class="top-login">
    <%
        if (loggedInUser != null) {
    %>
        <span><%= loggedInUser %>님 안녕하세요</span> |
        <a href="../cart/cart.jsp">🛒장바구니</a> |
        <a href="../register/checkpasswordForm.jsp">회원정보수정</a> |
        <a href="../login/logout.jsp">로그아웃</a>    
    <% } else { %>
        <a href="../login/login.jsp">로그인</a> | 
        <a href="../register/register.jsp">회원가입</a>
    <% } %>
</div>

<!-- 로고 및 네비게이션 합친 헤더 -->
<header>
    <div class="header-container">
        <h1 class="logo"><a href="../index.jsp">🖥 키보드 쇼핑몰</a></h1>
        <nav class="main-nav">
            <ul>
                <li><a href="../products/products.jsp">제품 리스트</a></li>
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>
    <div class="container">
        

        <div class="details">
            <p><strong>제목:</strong> <%= title %></p>
            <p><strong>작성자:</strong> <%= writer %></p>
            <p><strong>작성일:</strong> <%= date %></p>
            <p><strong>조회수:</strong> <%= views %></p>
        </div>

        <div class="content"><%= content %></div>

        <% if(fileName != null){ %>
        <div class="file-download">
            📎 <strong>첨부 파일:</strong>
            <a href="fileDownload.jsp?fileName=<%=java.net.URLEncoder.encode(fileName,"UTF-8")%>"><%=fileName%></a>
        </div>
        <% } %>

        <div class="actions">
            <% if ("ADMIN".equals(role)) { %>
                <a href="noticeUpdateForm.jsp?id=<%= id %>" class="btn">수정</a>
                <button onclick="confirmDelete(<%= id %>)" class="btn">삭제</button>
            <% } %>
            <a href="notice.jsp" class="btn">목록으로</a>
        </div>
    </div>
</body>
</html>

