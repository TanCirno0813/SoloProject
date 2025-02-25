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
    <title>QA게시판</title>
    
<script>
    function confirmDelete(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "qaDelete.jsp?id=" + id;
        }
    }
</script>
 <style>
        /* 전체 배경 */
        body {
            background-color: #fffbf5; 
           
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 0;
        }

        /* 헤더 스타일 */
        header {
            background-color: #DDD4EB; 

            padding: 15px 20px;
        }
        header h1 {
            display: inline;
        }
        header a {
            	color: #9178B8;
            text-decoration: none;
        }
        /* 헤더 테이블 스타일 제외 */
        header table {
            border: none;
        }

        /* 네비게이션 바 */
        nav {
            background-color: #9178B8;
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
            color: #F2C6E1;
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

        /* 게시판 스타일 */
        .board-container {
            width: 80%;
            margin: 20px auto;
            text-align: center;
        }
        
        /* 게시판 테이블 스타일만 적용 */
        .board-container table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .board-container table, 
        .board-container th, 
        .board-container td {
           
        }
        .board-container th, 
        .board-container td {
            padding: 10px;
            background-color: #F6F1FF;
            text-align: center;
        }
        .board-container th {
            background-color: #9178B8;
            color: #F5F5F5;
        }
        .board-container td a {
            color: #4B2C80;
            text-decoration: none;
        }
        .board-container td a:hover {
            text-decoration: underline;
            color: #F2C6E1;
        }

        /* 버튼 스타일 */
        .btn {
            background-color: #9178B8;
            color: black;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #DDD4EB;
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
  <header>
    <table width="100%">
        <tr>
            <td><h1><a href="../index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
            <td align="right">
                <% if (loggedInUser != null) { %>
                    <span><%= loggedInUser %>님 안녕하세요</span> |
                    <a href="../cart/cart.jsp">🛒 장바구니</a> |  <!-- 장바구니 버튼 추가 -->
                     <a href="../register/register_update_form.jsp">회원정보수정</a> | 
                    <a href="../login/logout.jsp">로그아웃</a>
                <% } else { %>
                    <a href="../login/login.jsp">로그인</a> | 
                    <a href="../register/register.jsp">회원가입</a>
                <% } %>
            </td>
        </tr>
    </table>
</header>
<nav>
        <ul>
            <li><a href="../products/products.jsp">제품 리스트</a></li>
            <li><a href="../notice/notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
    <div class="banner">🔥 Q&A게시판 🔥</div>
    <div class="board-container">
    <table>
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

                // rownum을 내림차순 정렬
                String sql = "SELECT (@rownum := @rownum + 1) AS rownum, n.* " +
                             "FROM (SELECT * FROM questions ORDER BY created_at ASC) n, " +
                             "(SELECT @rownum := 0) r " +
                             "ORDER BY rownum DESC"; 
                
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
         <tr>
                <td><%= rs.getInt("rownum") %></td>  <!-- 연속된 글번호 (내림차순) -->
                <td><a href="qaDetail.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
                <td><%= rs.getString("writer") %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
                <td><a href="javascript:void(0);" onclick="confirmDelete(<%= rs.getInt("id") %>)">삭제</a></td>
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
    <a href="qaWrite.jsp"><button class="btn">질문 작성</button></a>
      </div>
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>