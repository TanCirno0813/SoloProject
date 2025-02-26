<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    request.setCharacterEncoding("UTF-8");

    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equals(role)) {
        out.println("<script>alert('관리자만 글을 작성할 수 있습니다.'); history.back();</script>");
        return;
    }

    // 절대 경로는 직접 지정 (C 드라이브의 boardUpload 폴더에 저장)
    String uploadPath = "C:/boardUpload";

    // 폴더 존재 여부 체크하고, 없으면 자동 생성
    java.io.File uploadDir = new java.io.File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    // MultipartRequest 객체 생성 (파일 업로드 처리)
    MultipartRequest multi = new MultipartRequest(
        request,
        uploadPath,
        10 * 1024 * 1024, // 최대 업로드 파일 크기 10MB
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    // 업로드 후 파라미터 얻기
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    String writer = multi.getParameter("writer");
    String fileName = multi.getFilesystemName("uploadFile"); // "uploadFile"은 noticeWrite.jsp의 input name과 동일해야 함

    String URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String sql = "INSERT INTO notices (title, content, writer, file_name) VALUES (?, ?, ?, ?)";

    Class.forName("com.mysql.cj.jdbc.Driver");
    try (Connection conn = DriverManager.getConnection(URL, "root", "1234");
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, writer);
        pstmt.setString(4, fileName); // 파일 이름 저장
        pstmt.executeUpdate();
%>
        <script>
            alert("공지사항이 등록되었습니다.");
            window.location.href = "notice.jsp";
        </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
