<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

<%
int ProjectNo = Integer.parseInt(request.getParameter("projectNo"));

ProjectDao projectDao = new ProjectDao();
ProjectDto projectDto = projectDao.selectOne(ProjectNo); /* 프로젝트불러오기 */

RewardDao rewardDao = new RewardDao();
List<RewardDto> rewardList = rewardDao.selectProject(ProjectNo); /* 해당 리워드목록 리스트 불러오기 */

DecimalFormat f = new DecimalFormat("#,###.#");
%>

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
				<img src="https://via.placeholder.com/400x300" width="100%">
			</div>
		</div>
	</div>
	<div class="float-left w40p left p10px">
		<!-- 프로필부분의 오른쪽 플로트 -->
		<div class="row fill m20">
			<h2>
				[카테고리]
				<%=projectDto.getProjectCategory()%></h2>
		</div>
		<div class="row fill m20">
			<h2>
				[목표금액]
				<%=f.format(projectDto.getProjectTargetMoney())%>원
			</h2>
		</div>
		<div class="row fill m20 h150">
			<h2>[설명]</h2>
			<div class="row m10"><%=projectDto.getProjectSummary()%></div>
		</div>
		<div class="row fill h20 m20">
			<h3>
				[펀딩기간]
				<%=projectDto.getProjectStartDate()%>
				~
				<%=projectDto.getProjectSemiFinish()%>
			</h3>
		</div>

		<div class="row fill mt100">
			<div class="float-container">
				<div class="float-left center layer-2 h40 " style="font-size: 14px;">
					<a
						href="<%=request.getContextPath()%>/admin/projectEdit.jsp?projectNo=<%=projectDto.getProjectNo()%>">
						<button class="btn w90p h100p">수정</button>
					</a>
				</div>
				<div class="float-left center layer-2 h40" style="font-size: 14px;">
					<a
						href="<%=request.getContextPath()%>/project/delete.do?projectNo=<%=projectDto.getProjectNo()%>"
						class="del">
						<button class="btn w90p h100p">삭제</button>
					</a>
				</div>
			</div>
			<div class="row fill m5">
				<div class="float-container ">
					<div class="float-left center layer-2 h40 "
						style="font-size: 14px;">
						<a
							href="<%=request.getContextPath()%>/admin/projectPermit.do?projectNo=<%=projectDto.getProjectNo()%>">
							<button class="btn w90p h100p">승인</button>
						</a>
					</div>
					<div class="float-left center layer-2 h40" style="font-size: 14px;">
						<a href="#" class="btn-refuse">
							<button class="btn w90p h100p">거절</button>
						</a>
					</div>
				</div>
				<div class="row m20 refuse-msg">
					<form action="projectRefuse.do" method="post">
						<label>거절 메세지 입력</label> <input type="hidden" name="projectNo" value="<%=projectDto.getProjectNo()%>">
						<textarea name="projectRefuseMsg" rows="5" class="float-right fill form-input mt5" placeholder="내용입력" autocomplete="off"></textarea>
						<div class="row center">
							<button class="btn btn-reverse fill">거절하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="float-container center m30">
	<!-- 상세페이지 본문 부분-->
	<div class="float-left w60p">
		<h3 class="left m10">펀딩소개</h3>
		<img src="https://via.placeholder.com/400x500" width="100%">
	</div>

	<!-- 본문 오른쪽 리워드 부분 -->
	<div class="float-left w40p p10px-left">
		<div class="row left mb10">
			<span>리워드 </span> <a
				href="rewardEdit.jsp?projectNo=<%=projectDto.getProjectNo()%>"
				class="link link-reverse">리워드 수정</a>
		</div>
		<%for (RewardDto rewardDto : rewardList) {%>
		<div class="fill m-b10">
			<a href="#" class="link">
				<button class="btn btn-reverse fill reward" style="text-align: left;">
					리워드 이름<%=rewardDto.getRewardName()%><br> 리워드 내용<%=rewardDto.getRewardContent()%><br>
					리워드 가격<%=rewardDto.getRewardPrice()%><br> 리워드 재고<%=rewardDto.getRewardStock()%>
				</button>
			</a>
		</div>
		<%}%>
	</div>
</div>
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>