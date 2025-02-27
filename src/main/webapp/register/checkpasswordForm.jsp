<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String loggedInUser = (String) session.getAttribute("name"); // 로그인한 사용자명
    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String error = request.getParameter("error"); // 오류 메시지 처리
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>

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
        background: #F6F1FF;
        padding: 30px;
        width: 400px;
        margin: 100px auto;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        
    }

        .form-group {
            margin-bottom: 15px;
        }
       input {
        width: 100%;
        padding: 5px;
        margin-bottom: 15px;
        border: 1px solid #9178B8;
        border-radius: 5px;
        font-size: 14px;
    }
    
    h2 {
        color: #9178B8;
        margin-bottom: 20px;
    }
 label {
        display: block;
        font-size: 16px;
        margin-bottom: 8px;
    }
    .btn {
        background-color: #9178B8;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
      	
      		
       
    }
    .btn:hover {
        background-color: #6e57a5;
    }

    .error-msg {
        color: red;
        margin-bottom: 15px;
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
        <a href="../register/register_update_form.jsp">회원정보수정</a> |
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
<div class="form-container">
    <h2>🔑 비밀번호 확인</h2>

    <% if (error != null) { %>
        <p class="error-msg">⚠ 비밀번호가 일치하지 않습니다.</p>
    <% } %>

    <form action="check_password.jsp" method="post">
        <label>비밀번호:</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn">확인</button>
    </form>
</div>
<footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>
