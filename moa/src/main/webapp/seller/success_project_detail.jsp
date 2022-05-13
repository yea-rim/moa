<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);

	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo()); 
	
	boolean isExistProjectAttach = projectAttachDto != null;
	
	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	RewardDao rewardDao = new RewardDao();
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo);
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style type="text/css">
	.mlr60{margin-left: 60px; margin-right: 60px;}
	.ptb30{padding-top: 30px; padding-bottom: 30px;}
</style>


			<div class="flex-container mt40">
		             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
		             <a href="<%=request.getContextPath() %>/seller/my_success_project.jsp">
		                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		             </a>
		             <a href="<%=request.getContextPath() %>/seller/my_success_project.jsp" class="link mlr5">
		                     <h2>돌아가기</h2>
		              </a>
			</div>

			<div class="flex-container m50">
                    <div class="left-wrapper layer-5">
                       			<%if(isExistProjectAttach) { // 사진이 존재하면 %>
										 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="130px">
								<%} else { // 사진이 없으면 %>
										 <img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="130px">
								<%} %>
                    </div>
                    <div class="left-wrapper layer-4">
                        <div class="row">
                            <h2 class="m10 left"><%=projectDto.getProjectName()%></h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left"><%=projectDto.getProjectCategory() %></h4>
                        </div>
                    </div>
                    <div class="right-wrapper layer-4 left  mlr40 ">
                        <div class="row mt10 m10">
                            <h3>모인 금액</h3>
                        </div>
                        <div class="row m10">
                            <p><%=projectVo.getPresentMoney() %>원</p>
                        </div>
                        <div class="row mt20 m10 p-red">
                            <h3>달성율</h3>
                        </div>
                        <div class="row m10 p-red">
                            <p><%=projectVo.getPercent() %>%</p>
                        </div>
                        <div class="row mt20 m10">
                            <h3>후원자 수</h3>
                        </div>
                        <div class="row m10">
                            <p><%=projectVo.getSponsor() %>명</p>
                        </div>
                    </div>
                </div>

                <hr>


                <div class="container m30">
                    <!-- 프로젝트 정보 -->
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr40">
                            <h2>프로젝트 요약글</h2>
                        </div>
                        <div class="left-wrapper layer-5 ptb30">
                            <p><%=projectDto.getProjectSummary() %></p>
                        </div>
                    </div>
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr40">
                            <h2>펀딩 목표 금액</h2>
                        </div>
                        <div class="left-wrapper layer-5 ptb30">
                            <p><%=projectDto.getProjectTargetMoney() %>원</p>
                        </div>
                    </div>
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr40">
                            <h2>펀딩 일정</h2>
                        </div>
                        <div class="left-wrapper layer-5 ptb30">
                            <div class="row">
                                <h4>펀딩 시작일</h4>
                                <p class="m5 link-gray"><%=projectDto.getProjectStartDate() %></p>
                            </div>
                            <div class="row m15">
                                <h4>펀딩 마감일</h4>
                                <p class="m5 link-gray"><%=projectDto.getProjectSemiFinish() %></p>
                            </div>
                            <div class="row m15">
                                <h4>배송 마감일</h4>
                                <p class="m5 link-gray"><%=projectDto.getProjectFinishDate() %></p>
                            </div>
                        </div>
                    </div>

                    <!-- 리워드 정보 -->
                    <%
                    	int count = 1; 
                    	for(RewardDto rewardDto : rewardList) { 
                    %>
	                    <div class="flex-container">
	                        <div class="left-wrapper layer-4 p30 mlr40">
	                            <h2>리워드 <%=count %></h2>
	                        </div>
	                        <div class="left-wrapper layer-5 ptb30">
	                            <div class="row">
	                                <h4>리워드 이름</h4>
	                                <p class="m5 link-gray"><%=rewardDto.getRewardName() %></p>
	                            </div>
	                            <div class="row m15">
	                                <h4>리워드 내용</h4>
	                                <p class="m5 link-gray"><%=rewardDto.getRewardContent() %></p>
	                            </div>
	                            <div class="row m15">
	                                <h4>리워드 가격</h4>
	                                <p class="m5 link-gray"><%=rewardDto.getRewardPrice() %>원</p>
	                            </div>
	                            <div class="row m15">
	                                <h4>리워드 재고</h4>
	                                <p class="m5 link-gray"><%=rewardDto.getRewardStock() %>개</p>
	                            </div>
	                            <div class="row m15">
	                                <h4>배송비</h4>
	                                <p class="m5 link-gray"><%=rewardDto.getRewardDelivery() %>원</p>
	                            </div>
	                            <div class="row m15">
	                                <h4>개별 배송 여부</h4>
	                                <%if(rewardDto.getRewardEach() == 1) { %>
	                                	<p class="m5 link-gray">YES</p>
	                                <%} else { %>
	                                	<p class="m5 link-gray">NO</p>
	                                <%} %>
	                            </div>
	                        </div>
	                    </div>
                    <% count++; } %>
                </div>
                
                
                
<jsp:include page = "/template/footer.jsp"></jsp:include>