<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 세션에서 로그인한 사용자 확인
        String loggedInUser = (String) session.getAttribute("name");
    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        // 장바구니 목록 조회
        String sql = "SELECT c.id AS cart_id, p.id AS product_id, p.name, p.price, p.image_url, c.quantity FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script>
    function updateQuantity(cartId, change) {
        let newQuantity = parseInt(document.getElementById("quantity-" + cartId).innerText) + change;
        if (newQuantity < 1) return;
        window.location.href = "cartUpdate.jsp?cartId=" + cartId + "&quantity=" + newQuantity;
    }

    function deleteItem(cartId) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "cartDelete.jsp?cartId=" + cartId;
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
        height: 100px;
        background: url('banner.jpg') no-repeat center center;
        background-size: cover;
        text-align: center;
        line-height: 100px;
        font-size: 24px;
        font-weight: bold;
    }
    /* 푸터 스타일 */
    footer {
        background-color: #54485c;
        text-align: center;
        padding: 15px;
        margin-top: 20px;
        olor: #F5F5F5;
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
                <li><a href="../notice/notice.jsp">공지사항</a></li>
                <li><a href="qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>
 <div class="banner">🛒 장바구니</div>   
<table border="1">
    <tr>
        <th>이미지</th>
        <th>제품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>삭제</th>
    </tr>

<%
    int totalPrice = 0;
    while (rs.next()) {
        int cartId = rs.getInt("cart_id");
        int productId = rs.getInt("product_id");
        String productName = rs.getString("name");
        int price = rs.getInt("price");
        String imageUrl = rs.getString("image_url");
        int quantity = rs.getInt("quantity");

        totalPrice += price * quantity;
%>
    <tr>
        <td><img src="<%= imageUrl %>" width="80"></td>
        <td><%= productName %></td>
        <td><%= price * quantity %>원</td>
        <td>
            <button onclick="updateQuantity(<%= cartId %>, -1)">-</button>
            <span id="quantity-<%= cartId %>"><%= quantity %></span>
            <button onclick="updateQuantity(<%= cartId %>, 1)">+</button>
        </td>
        <td>
            <button onclick="deleteItem(<%= cartId %>)">삭제</button>
        </td>
    </tr>
<%
    }
%>
</table>

<h3>총 가격: <%= totalPrice %>원</h3>

<a href="checkout.jsp">결제하기</a>
 <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
