<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String loggedInUser = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지 작성</title>
    
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
       
        /* 공지 작성 컨테이너 */
        .qa-container {
            background-color: #F6F1FF;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.2);
            width: 400px;
            text-align: center;
        }

        /* 제목 */
        h2 {
            margin-bottom: 20px;
            color: #9178B8;
        }

        /* 입력 폼 스타일 */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            
        }

        label {
            font-size: 16px;
            margin-bottom: 5px;
            align-self: flex-start;
            color:black;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #666;
            border-radius: 5px;
            background-color: #F5F5F5;
            
            font-size: 14px;
        }

        textarea {
            height: 150px;
            resize: none;
        }

        /* 버튼 스타일 */
        .btn {
            background-color:#9178B8;
            color: black;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        .btn:hover {
            background-color: #DDD4EB; 
        }

        /* 목록으로 버튼 */
        .btn-back {
            margin-top: 10px;
            background-color: #555;
            color: white;
        }

        .btn-back:hover {
            background-color: #777;
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
    <div class="qa-container">
        <h2>📢 질문 작성</h2>
        <form action="qaProcess.jsp" method="post">
            <label>제목:</label>
            <input type="text" name="title" required>

            <label>내용:</label>
            <textarea name="content" required></textarea>
			<label>작성자:</label>
              <input type="text" name="writer" value="<%= session.getAttribute("username") %>">

            <input type="submit" value="등록" class="btn">
        </form>

        <a href="qa.jsp"><button class="btn btn-back">목록으로</button></a>
    </div>
<footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>
