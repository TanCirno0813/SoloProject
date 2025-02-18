<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String image_url = request.getParameter("image_url");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

            String sql = "INSERT INTO products (name, description, price, stock, image_url) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setInt(3, price);
            pstmt.setInt(4, stock);
            pstmt.setString(5, image_url);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
%>
            <script>
                alert("제품이 추가되었습니다.");
                window.location.href = "products.jsp"; // 제품 목록 페이지로 이동
            </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류 발생: " + e.getMessage() + "');</script>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 추가</title>
</head>
<body>
	  <h1>제품 추가</h1>
    <form method="post">
        <label>제품명:</label> <input type="text" name="name" required><br>
        <label>설명:</label> <input type="text" name="description" required><br>
        <label>가격:</label> <input type="number" name="price" required><br>
        <label>재고:</label> <input type="number" name="stock" required><br>
        <label>이미지 파일명:</label> <input type="text" name="image_url" placeholder="/SoloProject/images/keyboard" required><br>
        <input type="submit" value="제품 추가">
    </form>

    <br>
    <!-- 제품 목록으로 돌아가는 버튼 -->
    <a href="products.jsp">
        <button>취소</button>
    </a>
</body>
</html>