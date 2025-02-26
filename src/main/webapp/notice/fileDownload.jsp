<%@page import="java.io.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 다운로드할 파일명 파라미터로 받기
    String fileName = request.getParameter("fileName");
    
    // 파일이 실제로 저장된 위치 (파일이 업로드된 절대경로)
    String filePath = "C:/boardUpload"; 
    
    File file = new File(filePath, fileName);
    
    if (file.exists() && file.isFile()) {
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(fileName, "UTF-8"));
        response.setContentLength((int) file.length());

        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;

        try {
            bis = new BufferedInputStream(new FileInputStream(file));
            bos = new BufferedOutputStream(response.getOutputStream());

            byte[] buffer = new byte[1024];
            int bytesRead;

            while ((bytesRead = bis.read(buffer)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (bis != null) bis.close();
            if (bos != null) bos.close();
        }
    } else {
        out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
    }
%>
