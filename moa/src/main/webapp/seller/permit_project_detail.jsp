<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);
	
	RewardDao rewardDao = new RewardDao();
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo);
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectNo); 
	
	boolean isExistProjectAttach = projectAttachDto != null; 
	
	DecimalFormat df = new DecimalFormat("###,###");
%>    
<jsp:include page = "/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".pr-delete").on("click", function(){
			return confirm("프로젝트를 삭제하시겠습니까?");
		});
	});
</script>

	<div class="flex-container mt40">
		 <!-- 마이페이지 메인으로 이동 -->
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/seller/my_page.jsp">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="my_permit_project.jsp" class="link mlr5">
                     <h2>돌아가기</h2>
              </a>
	</div>

                <div class="flex-container m50">
                    <div class="left-wrapper layer-5">
	                     <%if(isExistProjectAttach) { // 사진이 존재하면 %>
									<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="112px">
						<%} else { // 사진이 없으면 %>
									<img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="112px">
						<%} %>
                    </div>
                    <div class="left-wrapper layer-3">
                        <div class="row">
                            <h2 class="m10 left"><%=projectDto.getProjectName() %></h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left"><%=projectDto.getProjectCategory() %></h4>
                        </div>
                    </div>
                    <div class="right-wrapper layer-3">
                        <div class="row mlr30 right">
                            <a href="project_edit.jsp?projectNo=<%=projectNo %>" class="link link-reverse w150 center">프로젝트 수정</a>
                        </div>
                        <div class="row mt5 mlr30 right">
                            <a href="attach_edit.jsp?projectNo=<%=projectNo %>" class="link link-reverse w150 center">이미지 수정</a>
                        </div>
                        <div class="row mt5 mlr30 right">
                            <a href="reward_edit.jsp?projectNo=<%=projectNo %>" class="link link-reverse w150 center">리워드 수정</a>
                        </div>
                        <div class="row mt5 mlr30 right">
                            <a href="project_delete.do?projectNo=<%=projectNo %>" class="link link-btn w150 center pr-delete">프로젝트 삭제</a>
                        </div>
                    </div>
                </div>

                <hr>

                <div class="container m30">
                    <!-- 프로젝트 정보 -->
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr50">
                            <h2>프로젝트 요약글</h2>
                        </div>
                        <div class="left-wrpper layer-2 p30">
                            <p><%=projectDto.getProjectSummary() %></p>
                        </div>
                    </div>
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr50">
                            <h2>펀딩 목표 금액</h2>
                        </div>
                        <div class="left-wrpper layer-2 p30">
                            <p><%=df.format(projectDto.getProjectTargetMoney()) %>원</p>
                        </div>
                    </div>
                    <div class="flex-container">
                        <div class="left-wrapper layer-4 p30 mlr50">
                            <h2>펀딩 일정</h2>
                        </div>
                        <div class="left-wrpper layer-2 p30">
                            <div class="row">
                                <h4>펀딩 시작일</h4>
                                <p class="m5 link-gray"><%=projectDto.getProjectStartDate() %></p>
                            </div>
                            <div class="row m15">
                                <h4>펀딩 마감일</h4>
                                <p class="m5 link-gray"><%=projectDto.getProjectSemiFinish() %></p>
                            </div>
                            <div class="row m15">
                                <h4>정산일</h4>
                                <p class="m5 link-gray">펀딩 마감과 동시에 정산이 진행됩니다.</p>
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
	                        <div class="left-wrapper layer-4 p30 mlr50">
	                            <h2>리워드 <%=count %></h2>
	                        </div>
	                        <div class="left-wrpper layer-2 p30">
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
	                                <p class="m5 link-gray"><%=df.format(rewardDto.getRewardPrice()) %>원</p>
	                            </div>
	                            <div class="row m15">
	                                <h4>리워드 재고</h4>
	                                <p class="m5 link-gray"><%=df.format(rewardDto.getRewardStock()) %>개</p>
	                            </div>
	                            <div class="row m15">
	                                <h4>배송비</h4>
	                                <p class="m5 link-gray"><%=df.format(rewardDto.getRewardDelivery()) %>원</p>
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