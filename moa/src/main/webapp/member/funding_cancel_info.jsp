<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="moa.beans.RewardSelectionDto"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardSelectionDao"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="moa.beans.FundingDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
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
	
	
	// 리워드 정보 조회
	RewardSelectionDao rewardSelectionDao = new RewardSelectionDao();
	List<RewardSelectionDto> list = rewardSelectionDao.getRewardNo(fundingNo);
	
	RewardDao rewardDao = new RewardDao();
	
	// 총 가격 조회
	int totalPay = fundingDao.getTotalPay(fundingNo);
	
	// 프로젝트 프로필 가져오기 
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo()); 
	
	boolean isExistProjectAttach = projectAttachDto != null; 
	
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
		 <a href="<%=request.getContextPath() %>/member/funding_cancel_list.jsp">
		    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		 </a>
		<a href="<%=request.getContextPath() %>/member/funding_cancel_list.jsp" class="link mlr5">
		    <h2>돌아가기</h2>
		</a>
	</div>
	
	<div class="flex-container m50">
                    <div class="left-wrapper layer-5 ">
                   				<%if(isExistProjectAttach) { // 사진이 존재하면 %>
										 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="130px">
								<%} else { // 사진이 없으면 %>
										 <img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="130px">
								<%} %>	    
                    </div>
                    <div class="left-wrapper layer-2 mlr50">
                        <div class="row">
                            <h2 class="m10 left"><%=projectDto.getProjectName() %></h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left"><%=projectDto.getProjectCategory() %></h4>
                        </div>
                    </div>
                </div>
                
                <hr>
                
                
                <div class="container m50">
                	
                	<div class= "row m20">
                		<h2>취소 정보</h2>
                	</div>
                	
                	<div class="float-container b-gr p10">
                		<div class="float-container">
                			<div class="float-left layer-5"><h3>취소 날짜</h3></div>
                			<div class="float-left layer-4"><p><%=fundingDto.getFundingCancelDate() %></p></div>
                		</div>
                		<div class="float-container">
                			<div class="float-left layer-5 mt10"><h3>후원 번호</h3></div>
                			<div class="float-left layer-4 mt10"><p><%=fundingDto.getFundingNo() %></p></div>
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
                	
	                	</div>
	                	<br>                	
                	
                	
                	<div class= "row m20 mt30 right">
                		<h2>취소 금액 : <%=df.format(totalPay)%>원</h2>
                	</div>

<jsp:include page = "/template/footer.jsp"></jsp:include>