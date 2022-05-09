<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션에 저장된 로그인 정보 가져오기
	Integer memberNo = (Integer) session.getAttribute("login");

	// 회원 상세 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
		
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재 
	
	
	// seller인지 판단 
	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberDto.getMemberNo());
	
	boolean isSeller = sellerDto != null; // true면 seller 
%>

<jsp:include page="/template/header.jsp"></jsp:include>
	
				<div class="container fill">
				
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        
                        	<!-- 프로필 사진 출력 -->
                            <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150px" height="150px" class="img img-circle">
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
                                    	
                                    <%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                             <%} else { // 존재하지 않는다면 %>
                                    <img src="https://dummyimage.com/200x200" alt="기본 프로필" width="150px" height="150px" class="img img-circle">
                             <%} %>
                            
                        </div>
                        <div class="float-left m20 mlr20">
                            <div class="row m10">
                            	<div class="float-container">
                            		 <%if(isSeller) { // 판매자이면 %>
                            		 		<div class="float-left">
                            					<h4>(판매자 번호) </h4>
	                            			</div>
	                            			<div class="float-left mlr10">
	                            				<h3><%=sellerDto.getSellerNo() %></h3>
	                            			</div>
                            		<%} else { // 일반 회원이면 %>
	                            			<div class="float-left">
	                            				<h4>(회원번호) </h4>
	                            			</div>
	                            			<div class="float-left mlr10">
	                            				<h3><%=memberDto.getMemberNo() %></h3>
	                            			</div>
                            		<% } %>
                            		<div class="float-left">
                            			<h4>(회원번호) </h4>
                            		</div>
                            		<div class="float-left mlr10">
                            			<h3><%=memberDto.getMemberNo()%></h3>
                            		</div>
                            	</div>
                            </div>
                            <div class="row">
                                <%if(isSeller) { %>
                                		<h2><%=sellerDto.getSellerNick() %></h2>
                                <%} else { %>
                                		<h2><%=memberDto.getMemberNick() %></h2>
                                <% } %>
                                <h2><%=memberDto.getMemberNick()%></h2>
                            </div>
                        </div> 
                        <div class="float-right m70 mlr20">
                        	<%if(isSeller) { %>
                        			<a href="" class="link link-reverse h40">
	                                	<h3>나의 프로젝트 관리</h3>
	                            	</a>
                        	<%} else { %>
                        			<a href="<%=request.getContextPath() %>/seller/seller_request.jsp" class="link link-reverse h60">
	                                	<h3>판매자 신청</h3>
	                                	<h3 class="center">(신청현황)</h3>
	                            	</a>
                        	<%} %>
                        <div class="float-right m60 mlr20">
                            <a href="<%=request.getContextPath()%>/seller/seller_join.jsp" class="link link-reverse" style="height: 60px;">
                                <h3>판매자 신청</h3>
                                <h3>(신청현황)</h3>
                            </a>
                        </div>
                    </div>

                    <!-- 개인정보 설정 -->
                    <div class="row m20">
                        <h3 class="right">
                        	<a href="profile.jsp" class="link mlr20">프로필 설정</a>
                            <a href="confirm_pw.jsp" class="link">개인정보 설정</a>
                        </h3>
                    </div>

                    <!-- 관심 프로젝트 -->
                    <div class="row m20">
                        <h2>
                            <a href="" class="link">관심 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                        내용
                    </div>
                    
                    <!-- 후원한 프로젝트 -->
                    <div class="row m20">
                        <h2>
                            <a href="" class="link">후원 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                        내용
                    </div>
                </div>
	
	<a href = "logout.do" class="link link-gray">로그아웃</a>
	
<jsp:include page="/template/footer.jsp"></jsp:include>