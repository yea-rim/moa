<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>moa</title>

    <!-- css 링크 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/commons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/layout.css" type="text/css">
    <!-- <link rel="stylesheet" href="./css/test.css" type="text/css"> -->

    <!-- 폰트 cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap" rel="stylesheet"> 

</head>
<body>
    <main>

        <header>
            <div class="float-container">
                <div class="float-left layer-5">
                    <a href="" class="link">
                        <h1 class="header-name m0">moa</h1>
                    </a>
                </div>
                <div class="float-right layer-5 right m10">
                    <a href="<%=request.getContextPath()%>/member/join.jsp" class="link">                    
                        <h3 class="m0">회원가입</h3>
                    </a>
                </div>
                <div class="float-right layer-5 right m10">
                    <a href="" class="link">
                        <h3 class="m0">로그인</h3>
                    </a>
                </div>
            </div>
        </header>

        <nav>
            <ul class="menu">
                <li>
                    <a href="#"><h3 class="m0">프로젝트</h3></a>
                </li>
                <li>
                    <a href="#"><h3 class="m0">커뮤니티</h3></a>
                    <ul>
                        <li><a href="#"><h3 class="m0">공지사항</h3></a></li>
                        <li><a href="#"><h3 class="m0">홍보하기</h3></a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><h3 class="m0">고객센터</h3></a>
                </li>
        </nav>
        <section>
            <article>