<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

<%
int projectNo = Integer.parseInt(request.getParameter("projectNo"));

RewardDao rewardDao = new RewardDao();
List<RewardDto> rewardList = rewardDao.selectProject(projectNo); /* 해당 리워드목록 리스트 불러오기 */
%>
<div class="container w600">
		<div class="row center m50">
			<h1>리워드 수정</h1>
		</div>
<form action="rewardEdit.do" method="post">
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
				<div class="right-wrapper right">
					<a href="rewardDelete.do?rewardNo=<%=rewardDto.getRewardNo()%>&projectNo=<%=rewardDto.getRewardProjectNo() %>" class="link link-reverse del">삭제</a>
				</div>
			</div>
		</div>
			<input type="hidden" name="rewardNo" value="<%=rewardDto.getRewardNo()%>">
			<div class="row m20">
				<label>리워드 이름</label> <input type="text" name="rewardName"
					class="form-input fill" value="<%=rewardDto.getRewardName()%>">
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="5" class="form-input fill"><%=rewardDto.getRewardContent()%></textarea>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> <input type="number" name="rewardPrice" 
				class="form-input fill"  value="<%=rewardDto.getRewardPrice()%>">
			</div>
			<div class="row m20">
				<label>리워드 재고</label> <input type="number" name="rewardStock"
					class="form-input fill"  value="<%=rewardDto.getRewardStock()%>">
			</div>
			<div class="row m20">
				<div class="row"><label>배송비</label></div>
				<input type="number" name="rewardDelivery" class="form-input w80p" value="<%=rewardDto.getRewardDelivery()%>">
				<input type="checkbox"  class="form-input rewardEach-cb" value="<%=rewardDto.getRewardEach()%>">
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
				<div class="row m10 mb50">
			<a href="project_detail.jsp?projectNo=<%=projectNo%>" class="link link-reverse fill center">돌아가기</a> 
		</div>
</form>
</div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>