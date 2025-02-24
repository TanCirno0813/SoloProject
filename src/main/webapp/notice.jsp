<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String loggedInUser = (String) session.getAttribute("username");
%>
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
    <title>공지사항</title>
    
<script>
    function confirmDelete(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "noticeDelete.jsp?id=" + id;
        }
    }
</script>
<style>
    /* 전체 배경 */
    body {
        background-color: #121212;
        color: white;
        font-family: Arial, sans-serif; 
        margin: 0;
        padding: 0;
    }

    /* 헤더 스타일 */
    header {
        background-color: #000;
        padding: 15px 20px;
    }
    header h1 {
        display: inline;
    }
    header a {
        color: #ffcc00;
        text-decoration: none;
       
    }

    /* 네비게이션 바 */
    nav {
        background-color: #000;
        padding: 10px 0;
        text-align: center;
    }
    nav ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    nav ul li {
        display: inline;
        margin: 0 15px;
    }
    nav ul li a {
        color: white;
        text-decoration: none;
        font-size: 18px;
        padding: 10px;
    }
    nav ul li a:hover {
        color: #ffcc00;
    }

    /* 메인 컨텐츠 */
    main {
        text-align: center;
        padding: 20px;
    }
    
    
    .banner {
        width: 100%;
        height: 300px;
        background: url('banner.jpg') no-repeat center center;
        background-size: cover;
        text-align: center;
        line-height: 300px;
        font-size: 24px;
        font-weight: bold;
    }
    /* 푸터 스타일 */
    footer {
        background-color: #000;
        text-align: center;
        padding: 15px;
        margin-top: 20px;
    }
</style>
</head>
<body>
    <!-- 헤더 -->
  <header>
    <table width="100%">
        <tr>
            <td><h1><a href="index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
            <td align="right">
                <% if (loggedInUser != null) { %>
                    <span><%= loggedInUser %>님 안녕하세요</span> |
                    <a href="cart.jsp">🛒 장바구니</a> |  <!-- 장바구니 버튼 추가 -->
                    <a href="logout.jsp">로그아웃</a>
                <% } else { %>
                    <a href="login.jsp">로그인</a> | 
                    <a href="register.jsp">회원가입</a>
                <% } %>
            </td>
        </tr>
    </table>
</header>
 <!-- 네비게이션 바 -->
    <nav>
        <ul>
            <li><a href="products.jsp">제품 리스트</a></li>
            <li><a href="notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
<div class="banner">🔥 공지 사항 🔥</div>
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

                String sql = "SELECT * FROM notices ORDER BY created_at DESC";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><a href="noticeDetail.jsp?id=<%= rs.getString("id") %>"><%= rs.getString("title") %></a></td>
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
    <a href="noticeWrite.jsp"><button>공지 작성</button></a>
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>