<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
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
</head>
<body>
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
</body>
</html>