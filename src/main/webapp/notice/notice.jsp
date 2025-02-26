<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
String loggedInUser = (String) session.getAttribute("name");
String role = (String) session.getAttribute("role");
%>

<%
int pageSize = 4;  // 한 페이지에 표시될 게시글 개수
int pageNum = 1;    // 현재 페이지 번호 (기본값: 1)

String pageNumStr = request.getParameter("pageNum");
if (pageNumStr != null) {
    pageNum = Integer.parseInt(pageNumStr);
}

// SQL LIMIT를 위한 변수
int startRow = (pageNum - 1) * pageSize;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String keyword = request.getParameter("keyword"); // 검색어
    String URL = "jdbc:mysql://localhost:3306/shoppingmall";
    
%>
<%
int totalCount = 0;  // 총 게시글 개수

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(URL, "root", "1234");

    String countSql = "SELECT COUNT(*) FROM notices WHERE 1=1 ";

    if (keyword != null && !keyword.trim().isEmpty()) {
        countSql += " AND title LIKE ?";
    }

    pstmt = conn.prepareStatement(countSql);

    if (keyword != null && !keyword.trim().isEmpty()) {
        pstmt.setString(1, "%" + keyword + "%");
    }

    rs = pstmt.executeQuery();
    if (rs.next()) {
        totalCount = rs.getInt(1);
    }

    rs.close();
    pstmt.close();
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
        background-color: #fffefc; /* 조금 더 밝게 조정함 */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0;
        padding: 0;
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
     <!-- 최상단 간략 로그인 파트 -->
<div class="top-login">
    <%
        if (loggedInUser != null) {
    %>
        <span><%= loggedInUser %>님 안녕하세요</span> |
        <a href="../cart/cart.jsp">🛒장바구니</a> |
        <a href="../register/register_update_form.jsp">회원정보수정</a> |
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

    <div class="banner">🔥 공지 사항 🔥</div>

    <div class="board-container">
        <table>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
               <th>조회수</th>
            </tr>
            
            <%	
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         // 실제 게시글을 페이징하여 가져오는 쿼리
            String sql = "SELECT (@rownum:=@rownum-1) AS rownum, n.* FROM " +
                         "(SELECT * FROM notices WHERE 1=1 ";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND title LIKE ? ";
            }

            sql += " ORDER BY created_at DESC LIMIT ?, ?) n, " +
                   "(SELECT @rownum:=?+1) r";  // rownum 시작 번호 계산을 위한 설정

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        pstmt.setString(1, "%" + keyword + "%");
                    }
                    pstmt.setInt(paramIndex++, startRow);
                    pstmt.setInt(paramIndex++, pageSize);
                    pstmt.setInt(paramIndex, totalCount - startRow);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                    	 String formattedDate = sdf.format(rs.getTimestamp("created_at"));
            %>
            <tr>
                <td><%= rs.getInt("rownum") %></td>  <!-- 연속된 글번호 (내림차순) -->
                <td><a href="noticeDetail.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
                <td><%= rs.getString("writer") %></td>
                  <td><%= formattedDate %></td> <!-- 🔹 날짜 형식 변경된 부분 -->
                  <td><%= rs.getInt("views") %></td> <!-- 조회수 표시 -->
               
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
        <div style="text-align: center; margin-top: 20px;">
    <%
    int pageCount = (totalCount / pageSize) + ((totalCount % pageSize == 0) ? 0 : 1);

    // 페이지 번호 출력 (1 2 3 4 ...)
    for(int i = 1; i <= pageCount; i++) {
        if(i == pageNum) {
            %>
            <strong>[<%= i %>]</strong>
            <%
        } else {
            %>
            <a href="notice.jsp?pageNum=<%= i %><%= keyword != null ? "&keyword=" + keyword : "" %>">[<%= i %>]</a>
            <%
        }
    }
    %>
</div>
<% if ("ADMIN".equals(role)) { %>
    <a href="noticeWrite.jsp"><button class="btn">공지 작성</button></a>
<% } %>
       
	</div>
	  <!-- 🔎 검색 폼 (제목으로만 검색) -->
	  <form action="notice.jsp" method="get">
        <input type="text" name="keyword" placeholder="제목을 입력하세요" value="<%= (keyword != null) ? keyword : "" %>">
        <input type="submit" value="검색">
    </form>
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>
