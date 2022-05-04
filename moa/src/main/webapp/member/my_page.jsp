<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 	Integer memberNo = (Integer)session.getAttribute("login");

// 	MemberDao memberDao = new MemberDao();
// 	MemberDto memberDto = memberDao.selectOne(memberNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>
	
	<h1>회원 정보</h1>

<h2><a href="confirmPw.jsp">회원정보 설정</a></h2>
<h2><a href="<%=request.getContextPath()%>/seller/seller_request.jsp">판매자 신청</a></h2>
<h2><a href="profile.jsp">프로필</a></h2>
<h2><a href="jjimList.jsp">관심 프로젝트 목록</a></h2>
<h2><a href="fundingPage.jsp">후원한 펀딩 내역</a></h2>
<h2><a href="sellerMain.jsp">판매자 패이지 메인</a></h2>
<h2><a href="#">포인트 충전</a></h2>
<h2><a href="exit.jsp">탈퇴하기</a></h2>
	
<a href = "logout.do">로그아웃</a>
	
<jsp:include page="/template/footer.jsp"></jsp:include>