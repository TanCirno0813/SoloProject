<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키보드 쇼핑몰</title>
</head>
<body>
	<header>
        <table width="100%">
            <tr>
                <td><h1> 키보드 쇼핑몰</h1></td>
                <td align="right">
                    <a href="login.jsp">로그인</a> | 
                    <a href="register.jsp">회원가입</a>
                </td>
            </tr>
        </table>
    </header>
       <!-- 네비게이션 바 -->
     <nav>
        <ul>
            <li><a href="products.jsp">제품 리스트</a></li>
            <li><a href="notice.jsp">공지사항</a></li>
            <li><a href="qa.html">Q&A 게시판</a></li>
        </ul>
    </nav>
      <main>

        <!-- 캐러셀 (이미지 슬라이드 자리) -->
        <section>
            <h2>대표 제품</h2>
            <p>여기에 대표 제품 이미지를 배치할 예정</p>
            <img src="keyboard1.jpg" alt="키보드 이미지 1" width="300">
            <img src="keyboard2.jpg" alt="키보드 이미지 2" width="300">
            <img src="keyboard3.jpg" alt="키보드 이미지 3" width="300">
        </section>

        <!-- 브랜드 소개 -->
        <section>
            <h2>우리 브랜드 소개</h2>
            <p>최고의 타건감을 자랑하는 기계식 키보드를 제작하는 브랜드입니다.</p>
        </section>

        <!-- 브랜드 제품 장점 -->
        <section>
            <h2>브랜드 제품의 장점</h2>
            <ul>
                <li>✅ 뛰어난 내구성</li>
                <li>✅ 다양한 스위치 옵션</li>
                <li>✅ 편안한 타이핑 경험</li>
            </ul>
        </section>
    </main>
     <!-- 푸터 -->
     <footer>
        <p>© 2025 키보드 쇼핑몰. All rights reserved.</p>
    </footer>
    
</body>
</html>	