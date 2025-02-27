<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String loggedInUser = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
        .register-container {
            width: 350px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        input {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #9178B8;
            color: black;
            border: none;
            border-radius: 3px;
            cursor: pointer;
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
    <%
        if (loggedInUser != null) {
    %>
        <span><%= loggedInUser %>님 안녕하세요</span> |
        <a href="../cart/cart.jsp">🛒장바구니</a> |
        <a href="../register/checkpasswordForm.jsp">회원정보수정</a> |
        <a href="../login/logout.jsp">로그아웃</a>    
    <% } else { %>
        <a href="../login/login.jsp">로그인</a> | 
        <a href="register.jsp">회원가입</a>
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
                <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>
 <div class="register-container">
        <h2>회원가입</h2>
        <form action="registerProcess.jsp" method="post">
            <div class="form-group">
                <label>아이디:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>비밀번호:</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>이메일:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>이름:</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>전화번호:</label>
                <input type="text" name="phone">
            </div>
            <div class="form-group">
                <label>주소:</label>
                <input type="text" name="address">
            </div>
            <button type="submit">회원가입</button>
        </form>
    </div>	
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>