<%@page import="moa.beans.SellerDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	SellerDto sellerDto = new SellerDto();
%>
	
<jsp:include page="/template/header.jsp"></jsp:include>

	<h1>판매자 신청 완료!</h1>
	<h2>현재 상태 : <%= %></h2>
	<h2>
		<a href="<%=request.getContextPath()%>">메인페이지로 이동</a>
	</h2>
	<h2>
		<a href="/member/login.jsp">로그인 하러가기</a>
	</h2>
<jsp:include page="/template/footer.jsp"></jsp:include>