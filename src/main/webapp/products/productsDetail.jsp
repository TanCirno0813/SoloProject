<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 세션에서 로그인한 사용자 정보 가져오기
    String loggedInUser = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role"); // 관리자 여부 확인
%>
<%
    String productId = request.getParameter("id");

    String url = "jdbc:mysql://localhost:3306/shoppingmall";
    String user = "root"; 
    String password = "1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String name = "", imageUrl = "", desc = "";
    int price = 0, stock = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM products WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(productId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            price = rs.getInt("price");
            stock = rs.getInt("stock");
            desc = rs.getString("description");
            imageUrl = rs.getString("image_url");
        }
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= name %> - 제품 상세보기</title>

<style>
    /* 전체 배경 스타일 */
    body {
        background-color: #fffefc; /* 조금 더 밝게 조정함 */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0;
        padding: 0;
        text-align: center;
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
    /* 본문 슬라이드 배너 */
    /* 컨테이너 스타일 */
    .container {
        width: 50%;
        margin: 50px auto;
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* 제품 이미지 스타일 */
    .product-img {
        width: 100%;
        max-width: 400px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-bottom: 15px;
    }

    /* 제목 스타일 */
    .container h1 {
        font-size: 26px;
        color: #4B2C80;
        margin-bottom: 10px;
    }

    /* 가격 스타일 */
   .container h2 {
        font-size: 22px;
        color: #6e57a5;
        margin: 10px 0;
    }

    /* 설명 스타일 */
    .container p {
        font-size: 16px;
        color: #333;
        line-height: 1.5;
        margin-bottom: 10px;
    }

    /* 버튼 스타일 */
    .back-btn {
        display: inline-block;
        text-decoration: none;
        background-color: #9178B8;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        transition: 0.3s;
    }
	 .add-btn {display: inline-block;
        padding: 8px 12px;
        margin: 5px;
        border-radius: 5px;
        text-decoration: none;
        color: white;
        font-size: 14px; background: #28a745; padding: 10px 15px; font-size: 16px; text-align: center; margin-top: 20px; }
   	
    .back-btn:hover {
        background-color: #6e57a5;
    }
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
    <% if (loggedInUser != null) { %>
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
                <li><a href="products.jsp">제품 리스트</a></li>
                <li><a href="../notice/notice.jsp">공지사항</a></li>
                <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>
<div class="container">
    <h1><%= name %></h1>
    <img src="<%= imageUrl %>" alt="제품 이미지" class="product-img">
    <p><%= desc %></p>
    <h2><%= price %>원</h2>
    <p>재고: <%= stock %>개</p>
      <% if (loggedInUser != null) { %>
                            <a href="../cart/cartAdd.jsp?id=<%= rs.getInt("id") %>&quantity=1" class="add-btn">장바구니 추가</a>
                        <% } else { %>
                            <a href="../login/login.jsp" class="add-btn" style="background: gray;">로그인 필요</a>
                        <% } %>
    <a href="products.jsp" class="back-btn">목록으로 돌아가기</a>
</div>
<%
} catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }%>
    <footer>
    © 2025 키보드 쇼핑몰. All rights reserved.
</footer>
</body>
</html>
