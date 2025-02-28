<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedInUser = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키보드 쇼핑몰</title>
<style>
    /* 전체 배경 */
    body {
        background-color: #fffefc; /* 조금 더 밝게 조정함 */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        margin: 0;
        padding: 0;
    }

   .top-login {
    background-color: #f9f4ff;
    color: #6e57a5;
    padding: 5px 20px;
    font-size: 14px;
    text-align: right;
}

.top-login a {
    color: #6e57a5;
    text-decoration: none;
}

.top-login a:hover {
    text-decoration: underline;
}

/* 헤더와 네비게이션 통합 스타일 */
header {
    background-color: #DDD4EB;
    padding: 10px 20px;
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logo a {
    color: #9178B8;
    text-decoration: none;
    font-size: 24px;
}

/* 깔끔하고 심플한 네비게이션 스타일 */
.main-nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    gap: 25px;
}

.main-nav ul li a {
    color: #6e57a5;
    text-decoration: none;
    padding: 5px 0;
    font-size: 18px;
    font-weight: bold;
    position: relative;
}

.main-nav ul li a::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 0%;
    height: 3px;
    background-color: #9178B8;
    transition: width 0.3s ease-in-out;
}

.main-nav ul li a:hover::after {
    width: 100%;
}

    /* 메인 컨텐츠 */
    main {
        max-width: 1000px;
        margin: 0 auto;
        padding: 30px;
    }

    /* 캐러셀 스타일 */
    .carousel-container {
        position: relative;
        max-width: 800px;
        margin: 20px auto;
        overflow: hidden;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .carousel-slide {
        display: none;
    }
    .carousel-slide img {
        width: 100%;
        border-radius: 15px;
    }

    /* 섹션 스타일 */
    section {
        background-color: #ffffff;
        border-radius: 15px;
        padding: 25px;
        margin-top: 30px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    }
    section h2 {
        color: #6e57a5;
        margin-bottom: 15px;
        border-bottom: 2px solid #DDD4EB;
        padding-bottom: 10px;
        display: inline-block;
    }
    section ul {
        text-align: left;
        margin: auto;
        max-width: 300px;
    }

    /* 푸터 스타일 */
    footer {
        background-color: #54485c;
        text-align: center;
        padding: 15px;
        margin-top: 40px;
        color: #F5F5F5;
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
   <!-- 최상단 간략 로그인 파트 -->
<div class="top-login">
    <%
      
        if (loggedInUser != null) {
    %>
        <span><%= loggedInUser %>님 안녕하세요</span> |
        <a href="cart/cart.jsp">🛒장바구니</a> |
        <a href="register/checkpasswordForm.jsp">회원정보수정</a> |
        <a href="login/logout.jsp">로그아웃</a>    
    <% } else { %>
        <a href="login/login.jsp">로그인</a> | 
        <a href="register.jsp">회원가입</a>
    <% } %>
</div>

<!-- 로고 및 네비게이션 합친 헤더 -->
<header>
    <div class="header-container">
        <h1 class="logo"><a href="index.jsp">🖥 키보드 쇼핑몰</a></h1>
        <nav class="main-nav">
            <ul>
                <li><a href="products/products.jsp">제품 리스트</a></li>
                <li><a href="notice/notice.jsp">공지사항</a></li>
                <li><a href="qa/qa.jsp">Q&A 게시판</a></li>
            </ul>
        </nav>
    </div>
</header>

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
