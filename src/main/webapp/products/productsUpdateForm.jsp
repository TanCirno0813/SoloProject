<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    <%
     String loggedInUser = (String) session.getAttribute("name");
%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/shoppingmall";
	String sql = "select * from products where id = "+request.getParameter("id");
	int id= 0;
	String name ="";
	String description ="";
	int price =0;
	int stock =0;
	String image_url ="";
	
	try(
			Connection conn = DriverManager.getConnection(url,"root","1234");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			){
		if(rs.next()){
			id = rs.getInt("id");
			name = rs.getString("name");
			description = rs.getString("description");
			price = rs.getInt("price");
			stock = rs.getInt("stock");
			image_url = rs.getString("image_url");

			
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 수정</title>
<style>
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
	     .form-container {
        background: white;
        color: black;
        max-width: 400px;
        margin: 40px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
.login-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
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
                <li><a href="products.jsp">제품 리스트</a></li>
                <li><a href="../notice/notice.jsp">공지사항</a></li>
                <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>

    <div class="form-container">
  <h1>제품 수정</h1>
    <form action=productsUpdate.jsp>
    	<label>ID:</label> <input type="text" name="id" value="<%=id%>" required><br>
        <label>제품명:</label> <input type="text" name="name" value="<%=name%>" required><br>
        <label>설명:</label> <input type="text" name="description" value="<%=description%>"required><br>
        <label>가격:</label> <input type="number" name="price" value="<%=price%>" required><br>
        <label>재고:</label> <input type="number" name="stock" value="<%=stock%>" required><br>
        <label>이미지 파일명:</label> <input type="text" name="image_url" value="<%=image_url%>"  required><br>
        <input type="submit" value="제품 수정"/>
   

    <br>
    <!-- 제품 목록으로 돌아가는 버튼 -->

    <a href="products.jsp">
        <button>취소</button>
    </a>
    </div>
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>