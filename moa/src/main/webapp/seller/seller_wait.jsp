<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 회원번호 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container w300">
			<div class="row center">
				<h2>판매자 신청 현황</h2>
			</div>
		
			<div class="row mt30">
				<h3>판매자 닉네임</h3>
			</div>
			<div class="row m5">
				<input type="text" value="<%=sellerDto.getSellerNick()%>" class="form-input" readonly>
			</div>
			
			<div class="row mt30">
				<h3>입금 은행</h3>
			</div>
			<div class="row m10">
				<input type="text" value="<%=sellerDto.getSellerAccountBank()%>" class="form-input" readonly>
			</div>
			
			<div class="row mt30">
				<h3>입금 계좌</h3>
			</div>
			<div class="row m10">
				<input type="text" value="<%=sellerDto.getSellerAccountNo()%>" class="form-input" readonly>
			</div>
			
			<div class="row mt30">
				<h3>판매자 유형</h3>
			</div>
			<div class="row m10">
				<input type="text" value="<%=sellerDto.getSellerType()%>" class="form-input" readonly>
			</div>
			
			<div class="row m10">
				<a href="seller_edit.jsp"><button class="btn fill">수정하기</button></a>
			</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>