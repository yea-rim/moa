<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="java.util.Date"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

	// 세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	boolean isLogin = memberNo != null; 
	
	// 세션에서 admin 정보 꺼내기
	String adminId = (String) session.getAttribute("admin");
	// adminId 데이터 여부 판단 -> 관리자 권한 판단
	boolean isAdmin = adminId != null;
	
	Integer sellerNo = (Integer) session.getAttribute("sellerNo");
	String sellerRegistDate = (String) session.getAttribute("sellerRegistDate");
	boolean isApprove = sellerRegistDate != null;

	// 판매자 여부 판단 
	boolean isSeller = sellerNo != null; 
%>

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
    <%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/test.css" type="text/css"> --%>
    
    <!-- 폰트 cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap" rel="stylesheet"> 
    
    <!-- jquery cdn -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
	

</head>
<body>
임시 출력 : memberNo = <%=memberNo %> , adminId = <%=adminId %> , sellerNo = <%=sellerNo %>, sellerRegistDate = <%=sellerRegistDate %>
    <main>

        <header>
            <div class="float-container">
                <div class="float-left layer-5">
                    <a href="<%=request.getContextPath() %>" class="link">
                        <h1 class="header-name m0">moa</h1>
                    </a>
                </div>
                <%if(isLogin) { // 로그인 상태라면 %>               	
                		<%if(isSeller) { // 판매자라면 %>
                			<div class="float-right layer-5 center m10">
	                			<a href="<%=request.getContextPath() %>/project/insert.jsp" class="link link-purple">
	                				<button class="btn-reverse">
	                					<h3>프로젝트 신청</h3>
	                				</button>
	                			</a>
	                		</div>
                		<%} else { // 일반 회원이라면 %>
                				<div class="float-right layer-5 center m10">
		                			<a href="<%=request.getContextPath() %>/seller/seller_join.jsp" class="link link-purple">
		                				<button class="btn-reverse">
		                					<h3>프로젝트 신청</h3>
		                				</button>
		                			</a>
		                		</div>
                		<%} %>
                		<div class="float-right layer-5 center m10 mt20">
                			<a href="<%=request.getContextPath() %>/member/my_page.jsp" class="link">
                					<h3>마이페이지</h3>
                			</a>
                		</div>
                <%}else if(isAdmin){ //관리자 상태이면%> 
                    <div class="float-right layer-5 center m10">
                		<a href="<%=request.getContextPath() %>/admin/admin_main.jsp" class="link">
                			<h3>관리자 메뉴</h3>
                		</a>
                	</div>
                	<div class="float-right layer-5 center m10">
                		<a href="<%=request.getContextPath() %>/member/logout.do" class="link">
	                        <h3>로그아웃</h3>
	                    </a>
                	</div>
                	<%}else { // 로그인 상태가 아니면 %>           
                	<div class="float-right layer-5 center m10">
                		<a href="<%=request.getContextPath() %>/member/join.jsp" class="link">
                			<h3>회원가입</h3>
                		</a>
                	</div>
                	<div class="float-right layer-5 center m10">
                		<a href="<%=request.getContextPath() %>/member/login.jsp" class="link">
	                        <h3>로그인</h3>
	                    </a>
                	</div>         	
                <%} %>
            </div>
        </header>

        <nav>
            <ul class="menu">
                <li>
                    <a href="<%=request.getContextPath()%>/project/ongoingList.jsp"><h3 class="m0">프로젝트</h3></a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/community/list.jsp"><h3 class="m0">커뮤니티</h3></a>
                    <ul>
                        <li><a href="#"><h3 class="m0">공지사항</h3></a></li>
                        <li><a href="<%=request.getContextPath() %>/community/list.jsp"><h3 class="m0 ft">홍보하기</h3></a></li>
                    </ul> 
                </li>
                <li>
                    <a href="#"><h3 class="m0">고객센터</h3></a>
                </li>
        </nav>
        <section>
            <article>