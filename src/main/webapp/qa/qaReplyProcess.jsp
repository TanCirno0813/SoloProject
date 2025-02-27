<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");
    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equals(role)) {
        out.println("<script>alert('관리자만 답변을 등록할 수 있습니다.'); history.back();</script>");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String adminReply = request.getParameter("admin_reply");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        String sql = "UPDATE questions SET admin_reply = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, adminReply);
        pstmt.setInt(2, id);
        pstmt.executeUpdate();

        response.sendRedirect("qaDetail.jsp?id=" + id);

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
