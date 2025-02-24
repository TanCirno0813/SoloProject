<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    int cartId = Integer.parseInt(request.getParameter("cartId"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, quantity);
        pstmt.setInt(2, cartId);
        pstmt.executeUpdate();

        response.sendRedirect("cart.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
