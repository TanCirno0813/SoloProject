<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>

      
<%
    String loggedInUser = (String) session.getAttribute("username");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp"); // 로그인 안 했으면 로그인 페이지로 이동
        return;
    }

    int userId = (Integer) session.getAttribute("user_id"); // 유저의 고유 ID 가져오기
    int productId = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        // 이미 장바구니에 존재하는지 확인
        String checkQuery = "SELECT * FROM cart WHERE user_id = ? AND product_id = ?";
        pstmt = conn.prepareStatement(checkQuery);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, productId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 이미 존재하면 수량 증가
            String updateQuery = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
        } else {
            // 존재하지 않으면 새로 추가
            String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
        }
        pstmt.executeUpdate();
        %>
        <script>
            if (confirm("장바구니에 추가하였습니다. 장바구니로 이동하시겠습니까?")) {
                window.location.href = "cart.jsp";
            } else {
                window.history.back(); // 이전 페이지로 돌아가기
            }
        </script>
    <%
    } catch (Exception e) {
        e.printStackTrace();
        %>
        <script>
            alert("장바구니 추가 중 오류가 발생했습니다.");
            window.history.back();
        </script>
    <%
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    
%>
