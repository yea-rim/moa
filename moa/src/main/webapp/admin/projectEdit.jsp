<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);
%>
<style>
	.insert-li{
		padding: 0px 0px 35px 20px;
		border-left: 1px solid #dcdcdc;
		list-style-type: disc;
	}
</style>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_insert.js"></script>

		<div class="container w600 m30 ">
		<div class="row center m50">
			<h1>프로젝트 정보 수정</h1>
		</div>
		<hr>
		<div class="row m20">
			<h3>*프로젝트 기본 정보</h3>
		</div>
<form action="projectEdit.do" method="post" >
	<input type="hidden" name="projectNo" value="<%=projectDto.getProjectNo()%>"> 
		<div class="row m20">		     					
			<label>카테고리</label> 
			<select name="projectCategory" class="form-input fill" value="<%=projectDto.getProjectCategory()%>">
			<%if(projectDto.getProjectCategory().equals("패션/잡화")){ %>
				<option value="">선택</option>
				<option selected>패션/잡화</option>
				<option>뷰티</option>
				<option>푸드</option>
				<option>홈/리빙</option>
				<option>테크/가전</option>
				<option>기타</option>
			<%}else if(projectDto.getProjectCategory().equals("뷰티")){  %>
				<option value="">선택</option>
				<option >패션/잡화</option>
				<option selected>뷰티</option>
				<option>푸드</option>
				<option>홈/리빙</option>
				<option>테크/가전</option>
				<option>기타</option>
			<%}else if(projectDto.getProjectCategory().equals("푸드")){  %>
				<option value="">선택</option>
				<option >패션/잡화</option>
				<option>뷰티</option>
				<option selected>푸드</option>
				<option>홈/리빙</option>
				<option>테크/가전</option>
				<option>기타</option>
			<%}else if(projectDto.getProjectCategory().equals("홈/리빙")){  %>
				<option value="">선택</option>
				<option >패션/잡화</option>
				<option>뷰티</option>
				<option>푸드</option>
				<option selected>홈/리빙</option>
				<option>테크/가전</option>
				<option>기타</option>
			<%}else if(projectDto.getProjectCategory().equals("테크/가전")){  %>
				<option value="">선택</option>
				<option >패션/잡화</option>
				<option>뷰티</option>
				<option>푸드</option>
				<option>홈/리빙</option>
				<option selected>테크/가전</option>
				<option>기타</option>				
			<%}else{ %>
				<option value="">선택</option>
				<option >패션/잡화</option>
				<option>뷰티</option>
				<option>푸드</option>
				<option>홈/리빙</option>
				<option>테크/가전</option>
				<option selected>기타</option>
			<%} %>
		</select>
		</div>
		<div class="row m20">
			<label>프로젝트명</label> 
			<input type="text" name="projectName" class="form-input fill text-length" value="<%=projectDto.getProjectName()%>" 
			data-len="30" data-success-msg="" data-fail-msg="30자 이내로 입력해주세요." required>
			<div class="flex-container length">
				<div class="left-wrapper msg f12 red"></div>
				<div class="right-wrapper right count f12 gray"></div><span class="f12 gray">/30</span>
			</div>
		</div>
		<div class="row m20">
			<label>프로젝트 요약글</label>
			<textarea name="projectSummary" rows="10" class="form-input fill text-length" data-len="100"
				data-success-msg="" data-fail-msg="100자 이내로 입력해주세요."><%=projectDto.getProjectSummary()%></textarea>
				<div class="flex-container length">
					<div class="left-wrapper msg f12 red"></div>
					<div class="right-wrapper right count f12 gray">0</div><span class="f12 gray">/100</span>
				</div>
		</div>
		<div class="row m20">
			<label>펀딩 목표 금액</label> 
			<input type="number" name="projectTargetMoney" class="form-input fill" value="<%=projectDto.getProjectTargetMoney()%>"> 
			<span class="font-on" style="color: red; font-size: 12px"></span><br>
			<span style="color: gray; font-size: 12px"> 
				※목표 금액 설정 시 꼭알아두세요!<br> 
				종료일까지 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.<br> 
				종료 전 후원 취소를 대비해 10% 이상 초과 달성을 목표로 해주세요.<br> 
				제작비, 선물 배송비, 인건비, 예비 비용 등을 함께 고려해주세요.<br>
			</span>
		</div>
		<hr>
		<div class="row m30">
			<h3>*펀딩 일정</h3>
		</div>
		<div class="row m20">
			<ul>
				<li class="insert-li">
					<div class="row">펀딩 시작일</div>
					<div class="row m5">
						<input type="text" name="projectStartDate" id="start" autocomplete="off" class="form-date" value="<%=projectDto.getProjectStartDate()%>">
					</div>
				</li>
				<li class="insert-li">
					<div class="row">
						<span>펀딩기간</span>
						<span class="days gray"></span>
					</div>
				</li>
				<li class="insert-li">
					<div class="row">펀딩 마감일</div>
					<div class="row m5">
						<input type="text" name="projectSemiFinish" id="end" autocomplete="off" class="form-date" value="<%=projectDto.getProjectSemiFinish()%>">
					</div>
				</li>
				<li class="insert-li">
					<div class="row">정산일</div>
					<div class="row m5">
						<span class="f13 gray">펀딩 마감과 동시에 정산이 진행됩니다.</span>
					</div>
				</li>
				<li class="insert-li">
					<div class="row">
						배송 마감일 ( <%=projectDto.getProjectFinishDate() %> )
					</div>
					
					<div class="row m5">
						<span class="f13 gray">기간 이내에 배송을 모두 완료 해야합니다.</span>
					</div>
				</li>
			</ul>
		</div>
		
		<hr>
	
		<div class="row mt50">
			<input type="submit" class="btn fill" value="수정하기"> 
		</div>
		<div class="row m10 mb50">
			<a href="project_detail.jsp?projectNo=<%=projectNo%>" class="link link-reverse fill center">돌아가기</a> 
		</div>
</form>
	</div>
		<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>