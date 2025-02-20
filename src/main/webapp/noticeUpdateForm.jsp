<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
    
    
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/shoppingmall";
	String sql = "select * from notices where id = "+request.getParameter("id");
	int id  = 0;
	String title ="";
	String content ="";
	String date= "";
	
	try(
			Connection conn = DriverManager.getConnection(url,"root","1234");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			){
		if(rs.next()){
			id = rs.getInt("id");
			title = rs.getString("title");
			content = rs.getString("content");
			date = rs.getString("created_at");
			
	
			
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h1>제품 수정</h1>
    <form action=noticeUpdate.jsp>
    	<label>ID:</label> <input type="text" name="id" value="<%=id%>" required><br>
        <label>제목:</label> <input type="text" name="title" value="<%=title%>" required><br>
        <label>내용:</label> <textarea type="text" name="content" required><%=content%></textarea><br>
      	 <input type="submit" value="제품 수정"/>
   

    <br>
    <!-- 제품 목록으로 돌아가는 버튼 -->

    <a href="notice.jsp">
        <button>취소</button>
    </a>
</body>
</html>