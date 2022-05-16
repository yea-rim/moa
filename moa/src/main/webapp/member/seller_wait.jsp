<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 회원번호 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberNo);
	
	boolean isWaiting = sellerDto.getSellerPermission() == 0; 
	boolean isRefused = sellerDto.getSellerPermission() == 2; 
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container mt40">
		
		<div class="flex-container">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="<%=request.getContextPath() %>/member/my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="<%=request.getContextPath() %>/member/my_page.jsp" class="link mlr5">
                                <h2>판매자 신청 현황</h2>
                            </a>
        </div>
        
        <div class="row m30"><hr></div>
        
        <div class="container w400 mt100">
		        <div class="row m30 center">
		        	<%if(isWaiting) { %>
		        		<h1 class="link-purple">판매자 승인 대기 중입니다.</h1>
		        	<%} else if (isRefused) {%>
		        		<h1 class="link-purple">판매자 승인 거절되었습니다.</h1>
		        		<p class="mt10 link-purple">사유 : <%=sellerDto.getSellerRefuseMsg() %></p>
		        	<%} %>
		        </div>

				<div class="row mt100">
					<h2>판매자 닉네임</h2>
				</div>
				<div class="row m10">
					<p class="link-gray"><%=sellerDto.getSellerNick() %></p>
				</div>
				
				<div class="row mt40">
					<h2>입금 은행</h2>
				</div>
				<div class="row m10">
					<p class="link-gray"><%=sellerDto.getSellerAccountBank()%></p>
				</div>
				
				<div class="row mt40">
					<h2>입금 계좌</h2>
				</div>
				<div class="row m10">
					<p class="link-gray"><%=sellerDto.getSellerAccountNo()%></p>
				</div>
				
				<div class="row mt40">
					<h2>판매자 유형</h2>
				</div>
				<div class="row m10">
					<p class="link-gray"><%=sellerDto.getSellerType()%></p>
				</div>
			<div class="row m20 mt50 center">
				<%if(isWaiting) { %>
					<a href="seller_edit.jsp" class="link link-btn fill">변경하기</a>
				<%} else if(isRefused)  {%>
					<p></p>
				<%} %>
				<a href="<%=request.getContextPath() %>/member/seller_edit.jsp" class="link link-btn fill">변경하기</a>
			</div>
			</div>
			
			
		</div>

<jsp:include page="/template/footer.jsp"></jsp:include>