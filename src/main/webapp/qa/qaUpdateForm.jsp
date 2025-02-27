<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String loggedInUser = (String) session.getAttribute("name"); // 현재 로그인한 사용자
    String loggedInUser1 = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role"); // 로그인한 사용자의 역할 (USER / ADMIN)
%>
<%
    // MySQL 연결 및 데이터 조회
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/shoppingmall";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int id = Integer.parseInt(request.getParameter("id"));
    String title = "";
    String content = "";
    String date = "";

    try {
        conn = DriverManager.getConnection(url, "root", "1234");

        String sql = "SELECT * FROM questions WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            date = rs.getString("created_at");
        }
    } catch (Exception e) {
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
    <title>Q&A 글 수정</title>
   <style>
        /* 전체 배경 스타일 */
        body {
            background-color: #fffefc; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0;
            padding: 0;
        }

        /* 최상단 로그인 파트 */
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

        /* 헤더와 네비게이션 */
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

        /* 네비게이션 스타일 */
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

        /* 공지 수정 컨테이너 */
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            width: 500px;
            text-align: center;
            margin: 30px auto;
        }

        h2 {
            margin-bottom: 20px;
            color: #6e57a5;
        }

        /* 입력 폼 스타일 */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 16px;
            margin-bottom: 5px;
            align-self: flex-start;
            color: black;
            font-weight: bold;
        }

        input[type="text"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        textarea {
            height: 150px;
            resize: none;
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
            width: 100%;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #5a478f;
        }

        /* 목록으로 버튼 */
        .btn-back {
            margin-top: 10px;
            background-color: #555;
            color: white;
        }

        .btn-back:hover {
            background-color: #777;
        }

        /* 푸터 스타일 */
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

<!-- 헤더 -->
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

<!-- 본문 슬라이드 배너 -->
<div class="banner">📝 Q&A 질문 수정</div>

<!-- Q&A 수정 폼 -->
<div class="form-container">
    <h2>Q&A 질문 수정</h2>
    <form action="qaUpdate.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">

        <label>제목:</label> 
        <input type="text" name="title" value="<%=title%>" required>

        <label>내용:</label> 
        <textarea name="content" required><%=content%></textarea>

       
            <button type="submit" class="btn">저장</button>
            
    </form>
    <a href="qa.jsp">
                <button type="button" class="btn">취소</button>
            </a>
    
</div>

<!-- 푸터 -->
<footer>
    © 2025 키보드 쇼핑몰. All rights reserved.
</footer>

</body>
</html>
