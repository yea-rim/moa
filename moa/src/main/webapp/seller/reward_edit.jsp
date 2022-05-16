<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	String rejected = request.getParameter("rejected");
	
	RewardDao rewardDao = new RewardDao();
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/add_reward.js"></script>


	<div class="flex-container mt40">
		 <!-- 마이페이지 메인으로 이동 -->
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/seller/permit_project_detail.jsp?projectNo=<%=projectNo %>">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="<%=request.getContextPath() %>/seller/permit_project_detail.jsp?projectNo=<%=projectNo %>" class="link mlr5">
                     <h2>돌아가기</h2>
              </a>
	</div>


<div class="container w600">
		<div class="row center m50">
			<h1>리워드 수정</h1>
		</div>
	<form action="reward_edit.do" method="post" class="edit-form">	
	<%if(rejected!=null){ %>	
		<input type="hidden" name="rejected" value="<%=rejected%>">
		<%} %>
		<input type="hidden" name="projectNo" value="<%=projectNo%>">
		<%
		int num =1;
		for (RewardDto rewardDto : rewardList) {
		%>
		<div class="row mt50">
			<div class="flex-container">
				<div class="left-wrapper">
					<h3>리워드 <%=num %></h3>
				</div>
				<%if(num!=1){ %>
				<div class="right-wrapper right">
					<a href="rewardDelete.do?rewardNo=<%=rewardDto.getRewardNo()%>&projectNo=<%=rewardDto.getRewardProjectNo() %>" class="link link-reverse del">삭제</a>
				</div>
				<%} %>
			</div>
		</div>
			<input type="hidden" name="rewardNo" value="<%=rewardDto.getRewardNo()%>">
			<div class="row m20">
				<label>리워드 이름</label> 
				<input type="text" name="rewardName" class="form-input fill checkValue" value="<%=rewardDto.getRewardName()%>" autocomplete="off">
					<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="5" class="form-input fill checkValue" autocomplete="off"><%=rewardDto.getRewardContent()%></textarea>
				<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> 
				<input type="number" name="rewardPrice" class="form-input fill checkValue"  value="<%=rewardDto.getRewardPrice()%>" autocomplete="off">
				<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<div class="row"><label>리워드 재고</label></div>
				<input type="number" name="rewardStock" class="form-input w80p checkValue"  value="<%=rewardDto.getRewardStock()%>" autocomplete="off">
				<span class="f12 red"></span>
				<input type="checkbox" class="form-input ckbox" value="<%=rewardDto.getRewardIsoption()%>">
				<input type="hidden" name="rewardIsOption" value="<%=rewardDto.getRewardIsoption()%>">
				<label class="f12 gray">상세 옵션 여부</label>
			</div>
			<div class="row m20">
				<div class="row"><label>배송비</label></div>
				<input type="number" name="rewardDelivery" class="form-input w80p checkValue" value="<%=rewardDto.getRewardDelivery()%>" autocomplete="off">
				<span class="f12 red"></span>
				<input type="checkbox"  class="form-input ckbox" value="<%=rewardDto.getRewardEach()%>">
				<input type="hidden" name="rewardEach" value="<%=rewardDto.getRewardEach()%>">
				<label class="f12 gray">개별 배송 여부</label>
			</div>
		<%num++; 
		} %>
		<div id="add-reward"></div>
			<div class="row right">
				<a class="btn-delReward"><img src="<%=request.getContextPath()%>/image/del-icon.png" width="20"></a>
				<a class="btn-addReward"><img src="<%=request.getContextPath()%>/image/add-icon.png" width="20"></a>
			</div>
		<div class="row mt50">
			<button type="submit"  class="btn fill">수정하기</button>
		</div>
</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>