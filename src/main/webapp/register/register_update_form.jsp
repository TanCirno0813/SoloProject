<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
    <%
    String loggedInUser = (String) session.getAttribute("username");
%>
<%
    request.setCharacterEncoding("utf-8");

    // 로그인한 사용자 ID 가져오기
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId == null) {
        // 로그인되지 않은 경우 로그인 페이지로 이동
        response.sendRedirect("../login/login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        String sql = "SELECT * FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
 <style>
 body {
        background-color: #121212;
        font-family: Arial, sans-serif; 
        margin: 0;
        padding: 0;
    }
    header {
        background-color: #000;
        padding: 15px 20px;
        color: white;
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
            <td><h1><a href="../index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
            <td align="right">
                <% if (loggedInUser != null) { %>
                    <span><%= loggedInUser %>님 안녕하세요</span> |
                    <a href="../cart/cart.jsp">🛒 장바구니</a> |  <!-- 장바구니 버튼 추가 -->
                     <a href="member/member_update_form.jsp">회원정보수정</a>| 
                    <a href="../login/logout.jsp">로그아웃</a>
                <% } else { %>
                    <a href="../login/login.jsp">로그인</a> | 
                    <a href="register.jsp">회원가입</a>
                <% } %>
            </td>
        </tr>
    </table>
</header>
    <nav>
        <ul>
            <li><a href="../products/products.jsp">제품 리스트</a></li>
            <li><a href="../notice/notice.jsp">공지사항</a></li>
            <li><a href="../qa/qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>
 
 <div class="register-container">
        <h2>회원정보 수정</h2>
        <form action="registerUpdate.jsp" method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            
            <div class="form-group">
                <label>아이디:</label>
                <input type="text" name="username" value="<%= rs.getString("username") %>" readonly>
            </div>
            <div class="form-group">
                <label>비밀번호:</label>
                <input type="password" name="password" value="<%= rs.getString("password") %>" required>
            </div>
            <div class="form-group">
                <label>이메일:</label>
                <input type="email" name="email" value="<%= rs.getString("email") %>" required>
            </div>
            <div class="form-group">
                <label>이름:</label>
                <input type="text" name="name" value="<%= rs.getString("name") %>" required>
            </div>
            <div class="form-group">
                <label>전화번호:</label>
                <input type="text" name="phone" value="<%= rs.getString("phone") != null ? rs.getString("phone") : "" %>">
            </div>
            <div class="form-group">
                <label>주소:</label>
                <input type="text" name="address" value="<%= rs.getString("address") != null ? rs.getString("address") : "" %>">
            </div>
            <button type="submit">회원정보 수정</button>
        </form>
    </div>	
    <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
</body>
</html>
<%
        } else {
            out.println("<script>alert('사용자 정보를 찾을 수 없습니다.'); location.href='../index.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
