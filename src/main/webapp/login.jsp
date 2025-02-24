<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedInUser = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
     body {
        background-color: #121212;
        font-family: Arial, sans-serif; 
        margin: 0;
        padding: 0;
    }
        .login-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
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
        .form-group {
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"] {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #ffcc00;
            color: black;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        footer {
	        background-color: #000;
	        text-align: center;
	        padding: 15px;
	        margin-top: 20px;
	        color: white;
	    } 
    </style>
</head>
<body>
<header>
    <table width="100%">
        <tr>
            <td><h1><a href="index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
            <td align="right">
                <% if (loggedInUser != null) { %>
                    <span><%= loggedInUser %>님 안녕하세요</span> |
                    <a href="logout.jsp">로그아웃</a>
                <% } else { %>
                    <a href="login.jsp">로그인</a> | 
                    <a href="register.jsp">회원가입</a>
                <% } %>
            </td>
        </tr>
    </table>
</header>
     <nav>
        <ul>
            <li><a href="products.jsp">제품 리스트</a></li>
            <li><a href="notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
    <div class="login-container">
        <h2>로그인</h2>
        <form action="loginProcess.jsp" method="post">
            <div class="form-group">
                <label for="userid">아이디:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">로그인</button>
        </form>
    </div>
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html> 