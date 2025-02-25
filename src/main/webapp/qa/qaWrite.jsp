<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String loggedInUser = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지 작성</title>
    
    <style>
        /* 전체 배경 */
        body {
            background-color: #fffbf5; 
            color: white;
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
            color:  #9178B8;
            text-decoration: none;
        }
        /* 헤더 테이블 스타일 제외 */
        header table {
            border: none;
        }

        /* 네비게이션 바 */
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
<!-- 헤더 -->
    <header>
        <table width="100%">
            <tr>
                <td><h1><a href="../index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
                <td align="right">
                    <% if (loggedInUser != null) { %>
                        <span><%= loggedInUser %>님 안녕하세요</span> |
                        <a href="../cart/cart.jsp">🛒 장바구니</a> |  
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
  <nav>
        <ul>
            <li><a href="../products/products.jsp">제품 리스트</a></li>
            <li><a href="../notice/notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
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
