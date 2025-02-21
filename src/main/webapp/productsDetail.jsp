<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String productId = request.getParameter("id");

    String url = "jdbc:mysql://localhost:3306/shoppingmall";
    String user = "root"; 
    String password = "1234"; 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String name = "", imageUrl = "", desc = "";
    int price = 0, stock = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM products WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(productId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            price = rs.getInt("price");
            stock = rs.getInt("stock");
            desc=rs.getString("description");
            imageUrl = rs.getString("image_url");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= name %> - 제품 상세보기</title>
</head>
<body>

<div class="container">
    <h1><%= name %></h1>
    <img src="<%= imageUrl %>" alt="제품 이미지" class="product-img">
    <p><%= desc %></p>
    <h2><%= price %>원</h2>
    <p>재고: <%= stock %>개</p>
    <a href="products.jsp" class="back-btn">목록으로 돌아가기</a>
</div>

</body>
</html>