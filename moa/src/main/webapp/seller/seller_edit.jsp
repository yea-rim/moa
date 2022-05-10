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
			<h2>판매자 정보 변경하기</h2>
		</div>
		
		<form action="" method="post">
			<div class="row mt30">
				<label>
					<div class="">판매자 닉네임</div>
					<input type="text" name="sellerNick" value="<%=sellerDto.getSellerNick()%>" class="row m10 form-input fill">
				</label>
			</div>
			
			<div class="row m10">
				<label>
					<div class="">입금은행</div>
					<input type="text" name="sellerAccountBank" value="<%=sellerDto.getSellerAccountBank()%>" class="row m10 form-input fill">
				</label>
			</div>
			
			<div class="row m10">
				<label>
					<div class="">입금계좌</div>
					<input type="text" name="sellerAccountNo" value="<%=sellerDto.getSellerAccountNo()%>" class="row m10 form-input fill">
				</label>
			</div>
			
			<div class="row m20">
					<input type="submit" value="변경하기" class="row m10 btn fill">
			</div>
		</form>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>