<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // 세션 초기화 (로그아웃)
%>
<script>
    alert("로그아웃되었습니다.");
    window.location.href = "../index.jsp";
</script>