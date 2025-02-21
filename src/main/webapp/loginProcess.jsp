<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String sql = "SELECT * FROM users WHERE username=? AND password=?";
	
	    try (Connection conn = DriverManager.getConnection(URL, "root", "1234");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, username);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp"); // index.jsp로 이동
        } else {
%>
            <script>
                alert("로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
                window.location.href = "login.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
