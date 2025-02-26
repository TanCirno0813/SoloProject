<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String image_url = request.getParameter("image_url");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

            String sql = "INSERT INTO products (name, description, price, stock, image_url) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setInt(3, price);
            pstmt.setInt(4, stock);
            pstmt.setString(5, image_url);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
%>
            <script>
                alert("제품이 추가되었습니다.");
                window.location.href = "products.jsp"; // 제품 목록 페이지로 이동
            </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류 발생: " + e.getMessage() + "');</script>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 추가</title>
<style>
    /* 전체 배경 스타일 */
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

    /* 제품 추가 폼 스타일 */
    .form-container {
        background: #f9f4ff;
        color: black;
        max-width: 400px;
        margin: 40px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .form-container h2 {
        text-align: center;
    }

    .form-container label {
        display: block;
        font-weight: bold;
        margin: 10px 0 5px;
    }

    .form-container input {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .button-container {
        text-align: center;
        margin-top: 20px;
    }

    .button-container button {
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        color: white;
        cursor: pointer;
    }

    .submit-btn { background: #007bff; }
    .cancel-btn { background: #dc3545; }

    /* 푸터 스타일 */
   footer {
        background-color: #54485c;
        text-align: center;
        padding: 15px;
        margin-top: 40px;
        color: #F5F5F5;
    }
</style>
</head>
<body>

<header>
    키보드 쇼핑몰
</header>

	

<!-- 본문 슬라이드 배너 -->
<div class="banner">🆕 신제품 추가 페이지 🆕</div>

<!-- 제품 추가 폼 -->
<div class="form-container">
    <h2>제품 추가</h2>
    <form method="post">
        <label>제품명:</label> 
        <input type="text" name="name" required>

        <label>설명:</label> 
        <input type="text" name="description" required>

        <label>가격:</label> 
        <input type="number" name="price" required>

        <label>재고:</label> 
        <input type="number" name="stock" required>

        <label>이미지 파일명:</label> 
        <input type="text" name="image_url" placeholder="/SoloProject/images/keyboard" required>

        <div class="button-container">
            <button type="submit" class="submit-btn">제품 추가</button>
            <a href="products.jsp">
                <button type="button" class="cancel-btn">취소</button>
            </a>
        </div>
    </form>
</div>

<footer>
    © 2025 키보드 쇼핑몰. All rights reserved.
</footer>

</body>
</html>
