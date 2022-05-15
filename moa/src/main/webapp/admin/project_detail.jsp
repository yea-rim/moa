<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.reward {
    border: 1px solid #e5e0e9;
    color: gray;
    font-weight: lighter;
    font-size: 15px;
    transition: 0.3s ease-in-out;
    border-radius: 0.3em;
    cursor: pointer;
    background-color: white;
    padding: 1em;
}
.swiper{
	width: 600px;
	height: 450px;
	resize: hori;
}

.swiper-pagination,
.swiper-button-prev,
.swiper-button-next {
	color: black;
}

.swiper-pagination-bullet-active{
	background-color: black;
}
</style>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<!-- 스와이퍼 -->
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/swiper.js"></script>

<%
//프로젝트 번호
int projectNo = Integer.parseInt(request.getParameter("projectNo"));

/* 프로젝트불러오기 */
ProjectDao projectDao = new ProjectDao();
ProjectDto projectDto = projectDao.selectOne(projectNo); 

/* 해당 리워드목록 리스트 불러오기 */
RewardDao rewardDao = new RewardDao();
List<RewardDto> rewardList = rewardDao.selectProject(projectNo); 

//금액 표시
DecimalFormat f = new DecimalFormat("#,###.#");

//현재 날짜
Date now = new Date();

ProjectAttachDao projectAttachDao = new ProjectAttachDao();

List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);

boolean isProfile = profileList.size() > 0;
%>

<div class="container w100p">
<div class="row center">
	<h1 class="mb50">
		<%=projectDto.getProjectName()%>
	</h1>
</div>

<div class="float-container center m30">
	<!-- 상세페이지 프로필 부분 -->
	<div class="float-left w60p">
		<!-- 프로필부분의 왼쪽 플로트-->
		<div class="row layer-1">

				<div class="img block">
						<div class="swiper">
							<div class="swiper-wrapper">
								  <%if(isProfile){ %>
				            		<%for(ProjectAttachDto projectAttachDto : profileList){ %>
					            		<div class="swiper-slide">
					            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="100%" height="100%">
					            		</div>
				            		<%} %>
				            		<%}else{ %>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				                	<%} %>
							</div>
							<div class="swiper-pagination"></div>
							
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
				</div>	
		</div>

		</div>
	</div>
	<div class="float-left w40p left p10px" style="min-height: 400px">
		<!-- 프로필부분의 오른쪽 플로트 -->
		<div class="row fill m20">
			<h3>
				[카테고리]
				<%=projectDto.getProjectCategory()%></h3>
		</div>
		<div class="row fill m20">
			<h3>
				[목표금액]
				<%=f.format(projectDto.getProjectTargetMoney())%>원
			</h3>
		</div>
		<div class="row fill h20 m20">
			<h3>
				[펀딩기간]
				<%=projectDto.getProjectStartDate()%>
				~
				<%=projectDto.getProjectSemiFinish() %>
			</h3>
		</div>
		<!--펀딩요약 -->
        <div class="row center shadow summary-box m20 w400">
        	<div class="m-b10 left" style="text-align: left;">
        		<span style="font-size: 15px; font-weight: bold;">펀딩 요약</span>
        		<hr style="background-color: white; border-bottom: 1px dotted rgb(231, 231, 231);">
        	</div>
        	<div style="text-align: left; font-size: 13px;">
	        	<%=projectDto.getProjectSummary() %>
        	</div>
        </div>

		<div class="row fill" style="margin-top: 160px;">
					<%
					boolean beforeStart = projectDto.getProjectStartDate().after(now);
					if(beforeStart) {%>
			<div class="float-container">
				<div class="float-left center layer-2 h40 f14 right">
					<a href="<%=request.getContextPath()%>/admin/projectEdit.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="edit">
						<button class="btn w90p h100p"> 프로젝트 수정</button>
					</a>					
				</div>
				<div class="float-left center layer-2 h40 f14">
					<a href="<%=request.getContextPath()%>/project/delete.do?projectNo=<%=projectDto.getProjectNo()%>"
						class="del">
						<button class="btn w90p h100p">삭제</button>
					</a>
				</div>
			</div>
				<%}else{ %>
				<div class="row center m10 f14">
			<div class="float-container">
				<div class="float-left center layer-2 h40 f14 right">
					<a class="link link-reverse link-gray center w90p h100p">수정 불가</a>					
				</div>
				<div class="float-left center layer-2 h40 f14">
					<a href="<%=request.getContextPath()%>/project/delete.do?projectNo=<%=projectDto.getProjectNo()%>"
						class="del">
						<button class="btn w90p h100p">삭제</button>
					</a>
				</div>
			</div>
			<%}%>
			
			<% 
				boolean beforePermit = projectDto.getProjectPermission() != 1;
				if(beforePermit){ 
			%>
			<div class="row fill m10">
				<div class="float-container ">
					<div class="float-left center layer-2 h40 f14 right">
						<a href="<%=request.getContextPath()%>/admin/projectPermit.do?projectNo=<%=projectDto.getProjectNo()%>">
							<button class="btn w90p h100p">승인</button>
						</a>
					</div>
					<div class="float-left center layer-2 h40 f14">
						<a href="#" class="btn-refuse">
							<button class="btn w90p h100p">반려</button>
						</a>
					</div>
				</div>
				<div class="row m20 refuse-msg">
					<form action="projectRefuse.do" method="post">
						<label>반려 메세지 입력</label> <input type="hidden" name="projectNo" value="<%=projectDto.getProjectNo()%>">
						<textarea name="projectRefuseMsg" rows="5" class="float-right fill form-input mt5" placeholder="내용입력" autocomplete="off"></textarea>
						<div class="row center">
							<button class="btn btn-reverse fill">반려하기</button>
						</div>
					</form>
				</div>
			</div>
			<%}%>
			
		</div>
	</div>
</div>

<div class="float-container center m30">
	<!-- 상세페이지 본문 부분-->
	<div class="float-left w60p">
		<div class="row left mb10">
			<span>펀딩 소개　</span> 
			<%if(beforeStart){ %>
			<a href="project_attach_edit.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link link-reverse">이미지 수정</a>
			<%} %>
		</div>
		<img src="https://via.placeholder.com/400x500" width="100%">
	</div>

	<!-- 본문 오른쪽 리워드 부분 -->
	
	<div class="float-left w40p p10px-left">
		<div class="row left mb10">
			<span>리워드　</span> 
			<%if(beforeStart){ %>
			<a href="rewardEdit.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link link-reverse">리워드 수정</a>
			<%} %>
		</div>
		<%for (RewardDto rewardDto : rewardList) {%>
		<div class="fill m-b10">
                    		<button class="fill reward" style="text-align: left;">
		                        <div style="color: black;">
		                        	<h3><span class="number">가격 : <%=rewardDto.getRewardPrice() %></span>원</h3>
		                        </div>
		                        <br>
		                        <span>
			                        <%=rewardDto.getRewardName() %>
		                        </span>
		                        <br>
		                        <span style="font-size: 13px;">
			                        · <%=rewardDto.getRewardContent() %>
		                        </span>
		                        <br>
		                        <span style="font-size: 13px;">
		                        	재고 : <%=rewardDto.getRewardStock() %>
		                        </span>
                    		</button>
                		</div>
		<%}%>
	</div>
</div>
</div>
</div>
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>