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


	<div class="container mt40">
		
		<div class="flex-container">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="<%=request.getContextPath() %>/member/my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="<%=request.getContextPath() %>/member/my_page.jsp" class="link mlr5">
                                <%if(sellerDto.getSellerPermission() == 1) { // 판매자이면 %>
                                	<h2>판매자 정보 변경하기</h2>
                                <%} else { // 판매자 신청 대기 중이면 %>
                                	<h2>판매자 신청 정보 변경하기</h2>
                                <%} %>
                            </a>
        </div>
        
        <div class="row m30"><hr></div>
        
        <div class="container mt60">
			
			<form action="edit.do" method="post">	
			<input type="hidden" name="sellerNo" value="<%=sellerDto.getSellerNo()%>">
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>판매자 닉네임</h2>
						<br>
						<p>판매자로 사용할 닉네임을 입력해주세요.</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerNick" value="<%=sellerDto.getSellerNick()%>" class="row m10 form-input fill" autocomplete="off">
					</div>
				</div>
				
				<br><br>
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>입금 은행</h2>
						<br>
						<p>후원금이 전달될 계좌의 은행명을 입력해주세요.</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerAccountBank" value="<%=sellerDto.getSellerAccountBank()%>" class="row m10 form-input fill" autocomplete="off">
					</div>
				</div>
				
				<br><br>
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>입금 계좌</h2>
						<br>
						<p>후원금이 전달될 계좌번호를 입력해주세요.</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerAccountNo" value="<%=sellerDto.getSellerAccountNo()%>" class="row m10 form-input fill" autocomplete="off">
					</div>
				</div>
				
				<br><br>
				
				<!-- 변경 가능 여부 회의 -->
<%-- 				<div class="float-container">
					<div class="float-left layer-2">
						<h2>판매자 유형</h2>
						<br>
						<p>판매자 유형을 선택해주세요.</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerType" value="<%=sellerDto.getSellerType()%>" class="row m10 form-input fill" autocomplete="off">
					</div>
				</div> --%>
				
				
				<div class="row m20 mt50 center">
					<input type="submit" value="변경하기" class="btn">
				</div>
			
			</form>
			
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>