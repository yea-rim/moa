<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 회원번호 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
			
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재 
%>    
    
<jsp:include page = "/template/header.jsp"></jsp:include>

	<div class="flex-container mt40">
            <!-- 마이페이지 메인으로 이동 -->
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/member/my_page.jsp">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="<%=request.getContextPath() %>/member/my_page.jsp" class="link mlr5">
                     <h2>나의 프로젝트 관리</h2>
              </a>
        </div>
        
        <div class="row m30"><hr></div>


	<div class="container mb30">
        <div class="float-container b-purple">
        
			<div class="float-left m20 mlr20">
				<!-- 프로필 사진 출력 -->
				<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
					<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150"  height="150px" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
					<%-- <%=memberProfileDto.getAttachNo() %> --%>
				<%} else { // 존재하지 않는다면 %>
					<img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="150px" height="150px" class="img img-circle">
				<%} %>
			</div>
        	
        	<div class="float-left">
	        	<div class="row m30 mlr20">
	                <h2><a href="<%=request.getContextPath() %>/project/seller_page.jsp?sellerNo=<%=sellerDto.getSellerNo()%>" class="link link-purple">[<%=sellerDto.getSellerNick() %>]</a></h2>
	            </div>
	
	            <div class="row mt30 m10 mlr20 link-gray">
	                <p>판매자 등록일 : <%=sellerDto.getSellerRegistDate() %></p>
	            </div>
	
	            <div class="row m10 mlr20 link-gray">
	                <p>입금 은행 : <%=sellerDto.getSellerAccountBank() %></p>
	            </div>
	
	            <div class="row m10 mlr20 mb20 link-gray">
	                <p>입금 계좌 : <%=sellerDto.getSellerAccountNo() %></p>
	            </div>
        	</div>
        	
        	<div class="float-right mt70 mlr20">
        		<a href="<%=request.getContextPath() %>/seller/seller_edit.jsp" class="link link-reverse h40">
					<h3>정보 수정</h3>
				</a>
        	</div>
        	
        </div> 

        <div class="float-container">
            <div class="float-left layer-3 mt50 center p10">
                <h2><a href="<%=request.getContextPath() %>/seller/my_ongoing_project.jsp" class="link link-purple link-reverse fill">프로젝트 관리</a></h2>
            </div>
            <div class="float-left layer-3 mt50 center p10">
                <h2><a href="<%=request.getContextPath() %>/seller/my_success_project.jsp" class="link link-purple link-reverse fill">성공한 프로젝트</a></h2>
            </div>
            <div class="float-left layer-3 mt50 center p10">
                <h2><a href="<%=request.getContextPath() %>/seller/my_fail_project.jsp" class="link link-purple link-reverse fill">미달성한 프로젝트</a></h2>
            </div>
        </div>
    </div>

<jsp:include page = "/template/footer.jsp"></jsp:include>