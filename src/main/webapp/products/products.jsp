<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String loggedInUser = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 목록</title>
<style>
    /* 전체 배경 설정 */
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
       color:#9178B8;
        text-decoration: none;
        
    }
 
    /* 네비게이션 바 스타일 */
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
    /* 본문 슬라이드 배너 */
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

    /* 제품 목록 스타일 */
    .product-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        padding: 20px;
    }

    /* 개별 제품 카드 */
    .product-card {
        background: #F5F5F5;
        color: black;
        border-radius: 10px;
        padding: 15px;
        margin: 15px;
        width: 250px;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .product-card img {
        width: 100%;
        height: 150px;
        border-radius: 5px;
    }

    .product-card h3 {
        margin: 10px 0;
    }

    .product-card p {
        font-size: 14px;
        color: #555;
    }

    .button-container {
        margin-top: 10px;
    }

    .button-container a {
        display: inline-block;
        padding: 8px 12px;
        margin: 5px;
        border-radius: 5px;
        text-decoration: none;
        color: white;
        font-size: 14px;
    }

    .edit-btn { background: #007bff; }
    .delete-btn { background: #dc3545; }
    .add-btn { background: #28a745; padding: 10px 15px; font-size: 16px; }

    /* 푸터 스타일 */
    footer {
	         background-color: #54485c;
        text-align: center;
        padding: 15px;
        margin-top: 20px;
        color: #F5F5F5;
	    } 
</style>
<script>
    function confirmDelete(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "productsDelete.jsp?id=" + id;
        }
    }
</script>
</head>
<body>

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
<!-- 네비게이션 바 -->
<nav>
    <ul>
        
        <li><a href="products.jsp">제품 리스트</a></li>
        <li><a href="../notice/notice.jsp">공지사항</a></li>
        <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
    </ul>
</nav>

<!-- 본문 슬라이드 배너 -->
<div class="banner">🔥 제품 목록 🔥</div>

<!-- 검색 폼 -->
<div style="text-align: right; margin: 20px;">
    <form action="products.jsp" method="GET">
        <input type="text" name="search" placeholder="제품 이름 검색">
        <input type="submit" value="검색">
    </form>
</div>

<!-- 제품 목록 -->
<div class="product-container">
    <%
        // MySQL 연결 정보
        String url = "jdbc:mysql://localhost:3306/shoppingmall";
        String user = "root"; 
        String password = "1234"; 

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String searchQuery = request.getParameter("search");
            String sql = "SELECT * FROM products";
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql += " WHERE name LIKE ?";
            }

            pstmt = conn.prepareStatement(sql);
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                pstmt.setString(1, "%" + searchQuery + "%");
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
    %>
               <div class="product-card">
               
                    <!-- 제품 이미지 클릭 시 상세 페이지 이동 -->
                    <a href="productsDetail.jsp?id=<%= rs.getInt("id") %>">
                        <img src="<%= rs.getString("image_url") %>" alt="제품 이미지">
                    </a>
                    <!-- 제품명 클릭 시 상세 페이지 이동 -->
                    <h3>
                        <a href="productsDetail.jsp?id=<%= rs.getInt("id") %>" style="text-decoration: none; color: black;">
                            <%= rs.getString("name") %>
                        </a>
                    </h3>
                    <p><strong><%= rs.getInt("price") %>원</strong></p>
                    <p>재고: <%= rs.getInt("stock") %>개</p>
                    <div class="button-container">
                        <a href="productsUpdateForm.jsp?id=<%= rs.getInt("id") %>" class="edit-btn">수정</a>
                        <a href="javascript:void(0);" onclick="confirmDelete(<%= rs.getInt("id") %>)" class="delete-btn">삭제</a>
                         <% if (loggedInUser != null) { %>
       					 <a href="../cart/cartAdd.jsp?id=<%= rs.getInt("id") %>&quantity=1" class="add-btn">장바구니 추가</a>
   						 <% } else { %>
   	     				<a href="login.jsp" class="add-btn" style="background: gray;">로그인 필요</a>
   						 <% } %>
                    </div>
                </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <p style="text-align: center; color: red;">⚠ 제품 정보를 불러오는 중 오류가 발생했습니다.</p>
    <%
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
</div>

<!-- 제품 추가 버튼 -->
<div style="text-align: center; margin-top: 20px;">
    <a href="addproduct.jsp" class="add-btn">제품 추가</a>
</div>

<footer>
    © 2025 키보드 쇼핑몰. All rights reserved.
</footer>

</body>
</html>
