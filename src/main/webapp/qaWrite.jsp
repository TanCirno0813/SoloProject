<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h2>질문 작성</h2>
    <form action="qaProcess.jsp" method="post">
        <label>제목:</label>
        <input type="text" name="title" required><br>

        <label>내용:</label>
        <textarea name="content" required></textarea><br>

        <input type="text" name="writer" value="<%= session.getAttribute("username") %>">
        
        <input type="submit" value="등록">
    </form>
    <br>
    <a href="qa.jsp"><button>목록으로</button></a>
</body>
</html>