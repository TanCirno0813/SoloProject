<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String loggedInUser = (String) session.getAttribute("username");
    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String inputPassword = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    boolean isPasswordCorrect = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingmall", "root", "1234");

        String sql = "SELECT password FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, loggedInUser);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");

            if (storedPassword.equals(inputPassword)) {  // 비밀번호 일치 여부 확인
                isPasswordCorrect = true;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    if (isPasswordCorrect) {
        response.sendRedirect("register_update_form.jsp"); // 비밀번호가 맞으면 수정 폼으로 이동
    } else {
        response.sendRedirect("checkpasswordForm.jsp?error=1"); // 틀리면 다시 입력하도록 유도
    }
%>
