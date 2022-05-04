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
	boolean isExistProfile = memberProfileDto != null; 
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
	
				<div class="container fill">
				
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        
                        	<!-- 프로필 사진 출력 -->
                            <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150" class="img img-circle">
                                    	
                                    <%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                             <%} else { // 존재하지 않는다면 %>
                                    <img src="https://dummyimage.com/200x200" alt="기본 프로필" width="200" class="img img-circle">
                             <%} %>
                            
                        </div>
                        <div class="float-left m20 mlr20">
                            <div class="row m10">
                            	<div class="float-container">
                            		<div class="float-left">
                            			<h4>(회원번호) </h4>
                            		</div>
                            		<div class="float-left mlr10">
                            			<h3><%=memberDto.getMemberNo() %></h3>
                            		</div>
                            	</div>
                            </div>
                            <div class="row">
                                <h2><%=memberDto.getMemberNick() %></h2>
                            </div>
                        </div> 
                        <div class="float-right m60 mlr20">
                            <a href="" class="link link-reverse h60">
                                <h3 class="center">판매자 신청</h3>
                                <h4 class="center">(신청현황)</h4>
                            </a>
                        </div>
                    </div>

                    <!-- 개인정보 설정 -->
                    <div class="row m20">
                        <h3 class="right">
                            <a href="information.jsp" class="link">개인정보 설정</a>
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