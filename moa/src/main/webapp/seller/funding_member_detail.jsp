<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.RewardSelectionDto"%>
<%@page import="moa.beans.RewardSelectionDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="moa.beans.FundingDao"%>
<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 펀딩한 회원 번호 가져오기
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 프로젝트 번호 가져오기 
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	// 펀딩 번호 가져오기
	int fundingNo = Integer.parseInt(request.getParameter("fundingNo"));

	// 프로젝트 관련 정보 
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);

	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	// 펀딩 관련 정보 
	FundingDao fundingDao = new FundingDao();
	FundingDto fundingDto = fundingDao.selectOne(fundingNo, memberNo);
	
	// 회원 프로필 사진 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
	
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
				
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재 
	
	
	// 리워드 정보 조회
	RewardSelectionDao rewardSelectionDao = new RewardSelectionDao();
	List<RewardSelectionDto> list = rewardSelectionDao.getRewardNo(fundingNo);
	
	RewardDao rewardDao = new RewardDao();
	
	// 총 가격 조회
	int totalPay = fundingDao.getTotalPay(fundingNo);
	
	DecimalFormat df = new DecimalFormat("###,###");
%>    
    
<jsp:include page = "/template/header.jsp"></jsp:include>

<style type="text/css">
	.b-gr {
		border: solid 1px rgb(208, 208, 208);
	}
</style>

	<div class="flex-container mt40">
		  <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
		 <a href="<%=request.getContextPath() %>/seller/funding_member_list.jsp?projectNo=<%=projectNo %>">
		    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		 </a>
		<a href="<%=request.getContextPath() %>/seller/funding_member_list.jsp?projectNo=<%=projectNo %>" class="link mlr5">
		    <h2>돌아가기</h2>
		</a>
	</div>
	
	<div class="flex-container m50">
                    <div class="left-wrapper layer-5">
                     	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
							<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150"  height="150px" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
							<%-- <%=memberProfileDto.getAttachNo() %> --%>
						<%} else { // 존재하지 않는다면 %>
							<img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="150px" height="150px" class="img img-circle">
						<%} %>
                    </div>
                    <div class="left-wrapper layer-2">
                        <div class="row w700">
                            <h2 class="m10 left"><%=memberDto.getMemberNick()%></h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left"><%=memberDto.getMemberEmail()%></h4>
                        </div>
                    </div>
                </div>

                <hr>
                
                
                <div class="container m50">
                	
                	<div class= "row m20">
                		<h2>후원 정보</h2>
                	</div>
                	
                	<div class="float-container b-gr p10">
                		<div class="float-container">
                			<div class="float-left layer-5"><h3>후원 날짜</h3></div>
                			<div class="float-left layer-4"><p><%=fundingDto.getFundingDate() %></p></div>
                		</div>
                		<div class="float-container">
                			<div class="float-left layer-5 mt10"><h3>후원 번호</h3></div>
                			<div class="float-left layer-4 mt10"><p><%=fundingDto.getFundingNo() %></p></div>
                		</div>
                		<div class="float-container">
                			<div class="float-left layer-5 mt10"><h3>펀딩 마감일</h3></div>
                			<div class="float-left layer-4 mt10"><p><%=projectDto.getProjectSemiFinish()%></p></div>
                		</div>
                	</div>
                	
                	
                	<div class= "row m20 mt30">
                		<h2>리워드 정보</h2>
                	</div>
                	
                	<%
                		for(RewardSelectionDto rewardSelectionDto : list) { 
                		RewardDto rewardDto = rewardDao.selectReward(rewardSelectionDto.getSelectionRewardNo(), projectNo);
                	%>
	                	<div class="float-container b-gr p10">
	                		<div class="float-container">
	                			<div class="float-left layer-5"><h3>리워드 이름</h3></div>
	                			<div class="float-left layer-4"><p><%=rewardDto.getRewardName()%></p></div>
	                		</div>
	                		<div class="float-container">
	                			<div class="float-left layer-5 mt10"><h3>리워드 옵션</h3></div>
	                			<div class="float-left layer-4 mt10"><p><%=rewardDto.getRewardContent()%></p></div>
	                		</div>
	                		<div class="float-container">
	                			<div class="float-left layer-5 mt10"><h3>개수</h3></div>
	                			<div class="float-left layer-4 mt10"><p><%=df.format(rewardSelectionDto.getSelectionRewardAmount())%></p></div>
	                		</div>
	                		<div class="float-container">
	                			<div class="float-left layer-5 mt10"><h3>리워드 금액</h3></div>
	                			<div class="float-left layer-4 mt10"><p><%=df.format(rewardDto.getRewardPrice()) %>원</p></div>
	                		</div>
	                		<div class="float-container">
	                			<div class="float-left layer-5 mt10"><h3>리워드 배송비</h3></div>
	                			<div class="float-left layer-4 mt10"><p><%=df.format(rewardDto.getRewardDelivery())%>원</p></div>
	                		</div>
	                	</div>
	                	<br>
                	<% } %>
                	
                	
                	<div class= "row m20 mt30 right">
                		<h2>총 결제 금액 : <%=df.format(totalPay)%>원</h2>
                	</div>

<jsp:include page = "/template/footer.jsp"></jsp:include>