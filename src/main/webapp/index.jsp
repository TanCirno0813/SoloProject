<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키보드 쇼핑몰</title>
<style>
    /* 전체 배경 */
    body {
        background-color: #121212;
        color: white;
        font-family: Arial, sans-serif; 
        margin: 0;
        padding: 0;
    }

    /* 헤더 스타일 */
    header {
        background-color: #000;
        padding: 15px 20px;
    }
    header h1 {
        display: inline;
    }
    header a {
        color: #ffcc00;
        text-decoration: none;
       
    }

    /* 네비게이션 바 */
    nav {
        background-color: #000;
        padding: 10px 0;
        text-align: center;
    }
    nav ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    nav ul li {
        display: inline;
        margin: 0 15px;
    }
    nav ul li a {
        color: white;
        text-decoration: none;
        font-size: 18px;
        padding: 10px;
    }
    nav ul li a:hover {
        color: #ffcc00;
    }

    /* 메인 컨텐츠 */
    main {
        text-align: center;
        padding: 20px;
    }
    
    /* 캐러셀 스타일 */
    .carousel-container {
        position: relative;
        max-width: 600px;
        margin: auto;
    }
    .carousel-slide {
        display: none;
    }
    .carousel-slide img {
        width: 100%;
        border-radius: 10px;
    }
    
    /* 푸터 스타일 */
    footer {
        background-color: #000;
        text-align: center;
        padding: 15px;
        margin-top: 20px;
    }
</style>
<script>
    let slideIndex = 0;
    
    function showSlides() {
        let slides = document.getElementsByClassName("carousel-slide");
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) { slideIndex = 1; }
        slides[slideIndex - 1].style.display = "block";
        setTimeout(showSlides, 3000); // 3초마다 변경
    }
    
    window.onload = function() {
        showSlides();
    };
</script>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <table width="100%">
            <tr>
                <td><h1><a href = "index.jsp">🖥 키보드 쇼핑몰</a></h1></td>
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
            <li><a href="qa.jsp">Q&A 게시판</a></li>
        </ul>
    </nav>

    <!-- 메인 컨텐츠 -->
    <main>
        <!-- 캐러셀 (이미지 슬라이드) -->
        <section>
            <h2>대표 제품</h2>
            <div class="carousel-container">
                <div class="carousel-slide"><img src="images/keyboard1.jpg" alt="키보드 1"></div>
                <div class="carousel-slide"><img src="images/keyboard2.jpg" alt="키보드 2"></div>
                <div class="carousel-slide"><img src="images/keyboard3.jpg" alt="키보드 3"></div>
            </div>
        </section>

        <!-- 브랜드 소개 -->
        <section>
            <h2>브랜드 소개</h2>
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
