<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 	String memberEmail = (String)session.getAttribute("login");

// 	MemberDao memberDao = new MemberDao();
// 	MemberDto memberDto = memberDao.selectOne(memberEmail);
%>

<jsp:include page="/template/header.jsp"></jsp:include>
	
	<h1>회원 정보</h1>

<a href="confirmPw.jsp">회원정보 설정</a>
<a href="sellerRequest.jsp">판매자 신청</a>
<a href="profile.jsp">프로필</a>
<a href="jjimList.jsp">관심 프로젝트 목록</a>
<a href="fundingPage.jsp">후원한 펀딩 내역</a>
<a href="sellerMain.jsp">판매지</a>
<a href="#">포인트 충전</a>
<a href="exit.jsp">탈퇴하기</a>
	
<a href = "logout.do">로그아웃</a>
	
<jsp:include page="/template/footer.jsp"></jsp:include>