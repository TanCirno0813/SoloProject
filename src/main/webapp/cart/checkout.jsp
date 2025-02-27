<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 세션에서 로그인한 사용자 확인
    String loggedInUser = (String) session.getAttribute("name");
    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        // 현재 사용자의 장바구니 삭제
        String sql = "DELETE FROM cart WHERE user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        pstmt.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 완료</title>
<script>
    alert("결제가 완료되었습니다!");
    window.location.href = "../index.jsp"; // 메인 페이지로 이동
</script>
</head>
<body>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("결제 중 오류가 발생했습니다. 다시 시도해주세요.");
            window.location.href = "cart.jsp";
        </script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
