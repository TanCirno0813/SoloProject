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
	String writer="";
	
	try(
			Connection conn = DriverManager.getConnection(url,"root","1234");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			){
		if(rs.next()){
			id = rs.getInt("id");
			title = rs.getString("title");
			writer = rs.getString("writer");
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
 <h1></h1>
   
   
  <p><strong>제목:</strong> <%=title%></p>
        <p><strong>작성자:</strong> <%= writer %></p>
        <p><strong>작성일:</strong> <%= date%></p>
        <hr>
        <p><%= content %></p>
    <br>
    <!-- 제품 목록으로 돌아가는 버튼 -->
	
	 <a href="noticeUpdateForm.jsp?id=<%=id%>">
        <button>수정</button>
    </a>
    
    <a href="notice.jsp">
        <button>돌아가기</button>
    </a>
</body>
</html>