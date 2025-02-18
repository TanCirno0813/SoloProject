<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>제품 목록</h1>
	<!-- 검색폼 --> 
	<form action="products.jsp" method="GET">
        <input type="text" name="search" placeholder="제품 이름 검색">
        <input type="submit" value="검색">
    </form>
    
    <table border="1">
        <tr>
        	<th>이미지</th>
            <th>제품명</th>
            <th>설명</th>	
            <th>가격</th>
            <th>재고</th>
        </tr>

        <%
            // MySQL 연결 정보
            String url = "jdbc:mysql://localhost:3306/shoppingmall";
            String user = "root"; // MySQL 사용자 이름
            String password = "1234"; // MySQL 비밀번호

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // JDBC 드라이버 로드
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // 데이터베이스 연결
                conn = DriverManager.getConnection(url, user, password);
                
                // 검색어 가져오기
                String searchQuery = request.getParameter("search");
                
                // SQL 문 생성 (검색어가 있을 경우 WHERE 조건 추가)
                String sql = "SELECT name, description, price, stock,image_url FROM products";
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sql += " WHERE name LIKE ?";
                }

                pstmt = conn.prepareStatement(sql);
                
                // 검색어가 있으면 % 포함하여 설정
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    pstmt.setString(1, "%" + searchQuery + "%");
                }

                rs = pstmt.executeQuery();
	
                // 결과 출력
                while (rs.next()) {
                
        %>
                <tr>
                 	 <td>
					    <% 
					        String imageUrl = rs.getString("image_url");
					    
					        if (imageUrl != null && !imageUrl.isEmpty()) { 
					    %>
					        <img src="<%= imageUrl %>" alt="제품 이미지" width="100" height="100">
					    <% 
					        } else { 
					    %>
					        <span>이미지 없음</span>
					    <% 
					        } 
					    %>
					</td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getInt("price") %>원</td>
                    <td><%= rs.getInt("stock") %>개</td>
                 
                </tr>
               
              
        <% 	
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <tr>
                    <td colspan="4">⚠ 제품 정보를 불러오는 중 오류가 발생했습니다.</td>
                </tr>
                 
        <%
            } finally {
                // 자원 해제
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </table>
    
	<!-- 제품 추가 버튼 -->
		<a href="addproduct.jsp">
		    <button>제품 추가</button>
		</a>
</body>
</html>