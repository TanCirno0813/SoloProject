<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    <%
    String loggedInUser = (String) session.getAttribute("username");
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
        background-color: #121212;
        font-family: Arial, sans-serif; 
        color:white;
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
        
        footer {
	        background-color: #000;
	        text-align: center;
	        padding: 15px;
	        margin-top: 20px;
	        color: white;
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
<!-- 네비게이션 바 -->
    <nav>
        <ul>
            <li><a href="products.jsp">제품 리스트</a></li>
            <li><a href="notice.jsp">공지사항</a></li>
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
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