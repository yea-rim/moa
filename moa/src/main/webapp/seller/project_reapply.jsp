<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.AttachDto"%>
<%@page import="moa.beans.ProjectAttachDto"%>
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
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
	List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);
	
	int profileListSize = profileList.size();
	int detailListSize = detailList.size();
	
	AttachDao attachDao = new AttachDao();
	
	RewardDao rewardDao = new RewardDao();
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo); /* 해당 리워드목록 리스트 불러오기 */
%>
    
<jsp:include page = "/template/header.jsp"></jsp:include>

<style>
	.insert-li{
		padding: 0px 0px 35px 20px;
		border-left: 1px solid #dcdcdc;
		list-style-type: disc;
	}
.filebox-a input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}
/* 인풋 스타일 변경 */
.filebox-a .upload-name {
	display: inline-block;
	height: 30px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #dddddd;
	border-radius: 0.3em;
	width: 40%;
	color: #999999;
}
/* label 스타일 변경 */
.filebox-a label {
	display: inline-block;
	padding: 10px 10px;
	color: white;
	vertical-align: middle;
	background-color: #d8c8e3;
	border-radius: 0.3em;
	cursor: pointer;
	height: 30px;
	font-size: 12px;
}
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/add_reward.js"></script>

    <script type="text/javascript">
        $(function(){
	        // 파일명 input에 출력하는 JS
	        $('input[name="attach"]').each(function(){
		        $(this).on('change',function(){
		            var fileFullName = $(this).val();
		            
		            var fileName = fileFullName.substring(12,fileFullName.length);
		            $(this).prev().prev().val(fileName);
		        });
	        });
	       
	      //추가,수정 시 파일 첨부 검사  
	     $(".btn-file").each(function(){
				$(this).click(function(){
			    	 var file = $(this).prev('input').val();
			    	 if(file==""){
			    		 alert("파일을 첨부해주세요");
			    		 return false;
			    	 }
				});
	     });   
	      
        });
    </script>


<div class="flex-container mt40">
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="rejected_project_detail.jsp?projectNo=<%=projectNo%>">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="rejected_project_detail.jsp?projectNo=<%=projectNo%>" class="link mlr5">
                     <h2>돌아가기</h2>
              </a>
	</div>


<!-- 프로젝트 수정 파트 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		<div class="container w900 m30 ">
		<div class="row center m50">
			<h1>프로젝트 정보</h1>
		</div>
		<hr>
		<div class="row m20">
			<h3>*프로젝트 기본 정보</h3>
		</div>
<form action="project_edit.do" method="post" class="insert-form">
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
				<input type="text" name="projectName" class="form-input fill checkValue" value="<%=projectDto.getProjectName()%>">
				<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<label>프로젝트 요약글</label>
				<textarea name="projectSummary" rows="5" class="form-input fill checkValue"><%=projectDto.getProjectSummary()%></textarea>
				<span class="f12 red"></span>
			</div>
			<div class="row m30">
				<label>펀딩 목표 금액</label> 
				<input type="number" name="projectTargetMoney" class="form-input fill checkValue"  value="<%=projectDto.getProjectTargetMoney()%>"> 
				<span class="font-on f12 red"></span><br>
				<span class="f12 gray" > 
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
						<input type="text" name="projectStartDate" id="start" autocomplete="off" class="form-date checkValue" value="<%=projectDto.getProjectStartDate()%>">
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
						<input type="text" name="projectSemiFinish" id="end" autocomplete="off" class="form-date checkValue" value="<%=projectDto.getProjectSemiFinish()%>">
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
			<input type="submit" class="btn fill" value="프로젝트 수정하기"> 
		</div>
</form>
	</div>

<!-- 프로젝트 이미지 수정 파트 -->	
	
	
	<div class="container w900 mt100">
	<div class="row center mb40">
		<h1 class="m5">프로젝트 이미지 수정</h1>
		<span class="f12 gray"> 각각 최대 3장 까지 설정 가능합니다.</span>
	</div>
	
	<hr>
	<!-- 대표 이미지 수정 -->
	<div class="row m20 mlr30">
		<h2>* 대표 이미지</h2>
	</div>
	<div class="row m20">
		<div class="container">
			<div class="flex-container3">
				<%
					int count = 1;
				for (ProjectAttachDto projectAttachDto : profileList) {
					AttachDto attachDto = attachDao.selectOne(projectAttachDto.getAttachNo());
				%>
				<div class="list-card2 mlr20 m15 center">
					<div class="row center">
						<img
							src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=attachDto.getAttachNo()%>"
							class="card-image-wrapper" width="160px" height="112px">
					</div>
					<div class="row mt15">
						<div class="filebox-a center w220">
							<form action="attach_edit.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input type="hidden" name="attachNo" value="<%=attachDto.getAttachNo()%>">
								<input class="upload-name" placeholder="<%=attachDto.getAttachUploadname()%>"> 
								<label for="file<%=count%>">선택</label> <input type="file" id="file<%=count++ %>" name="attach" class="attach">
								<button type="submit" class="link link-small btn-file f12">수정</button>
							</form>
							<%if(count > 2){ %>
								<a href="<%=request.getContextPath()%>/seller/attach_delete.do?attachNo=<%=attachDto.getAttachNo()%>&projectNo=<%=projectNo%>">
									<button type="button" class="link link-small btn-del f12">삭제</button>
								</a>
							<%} %>	
						</div>
					</div>
				</div>
				<%
				}
				%>
				<%
					for (int i=0; i<3-profileListSize; i++) {
				%>
				<div class="list-card2 mlr20 m15 center">
					<div class="row center">
						<img
							src="<%=request.getContextPath() %>/image/no_image.png"
							class="card-image-wrapper" width="150px" height="112px">
					</div>
					<div class="row mt15 mlr10">
						<div class="filebox-a center w220">
							<form action="attach_insert.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input class="upload-name" placeholder="파일첨부"> 
								<label for="file1<%=i%>">선택</label> <input type="file" id="file1<%=i%>" name="profileAttach" class="attach">
								<button type="submit" class="link link-small btn-file f12">추가</button>
							</form>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- 대표 이미지 수정 -->
	<div class="row m20 mlr30">
		<h2>* 본문 이미지 </h2>
	</div>
	<div class="row m20">
		<div class="container">
			<div class="flex-container3">
				<%
				int count2 = 1;
				for (ProjectAttachDto projectAttachDto : detailList) {
					AttachDto attachDto = attachDao.selectOne(projectAttachDto.getAttachNo());
				%>
				<div class="list-card2 mlr20 m15 center">
					<div class="row center">
						<img
							src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=attachDto.getAttachNo()%>"
							class="card-image-wrapper" width="150px" height="112px">
					</div>
					<div class="row mt15 mlr10">
						<div class="filebox-a center w220">
							<form action="attach_edit.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input type="hidden" name="attachNo" value="<%=attachDto.getAttachNo()%>">
								<input class="upload-name" placeholder="<%=attachDto.getAttachUploadname()%>"> 
								<label for="file2<%=count2%>">선택</label> <input type="file" id="file2<%=count2++ %>" name="attach" class="attach">
								<button type="submit" class="link link-small btn-file f12">수정</button>
							</form>
							<%if(count2>2){ %>
									<a href="<%=request.getContextPath()%>seller/attach_delete.do?attachNo=<%=attachDto.getAttachNo()%>">
									<button type="button" class="link link-small btn-del f12">삭제</button>
								</a>
							<%} %>
						</div>
					</div>
				</div>
				<%}%>
				<%
					for (int i=0; i<3-detailListSize; i++) {
				%>
				<div class="list-card2 mlr20 m15 center">
					<div class="row center">
						<img
							src="<%=request.getContextPath() %>/image/no_image.png"
							class="card-image-wrapper" width="150px" height="112px">
					</div>
					<div class="row mt15 mlr10">
						<div class="filebox-a center w220">
							<form action="attach_insert.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input class="upload-name" placeholder="파일첨부"> 
								<label for="file3<%=i%>">선택</label> <input type="file" id="file3<%=i %>" name="detailAttach" class="attach">
								<button type="submit" class="link link-small btn-file f12">추가</button>
							</form>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</div>
	


<!-- 리워드 수정 파트 -->
<div class="container w900 mt100">
		<div class="row center m50">
			<h1>리워드 수정</h1>
		</div>
		
		<hr>
		
<form action="reward_edit.do" method="post" class="edit-form">
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
				<input type="text" name="rewardName" class="form-input fill checkValue" value="<%=rewardDto.getRewardName()%>">
					<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="5" class="form-input fill checkValue"><%=rewardDto.getRewardContent()%></textarea>
				<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> 
				<input type="number" name="rewardPrice" class="form-input fill checkValue"  value="<%=rewardDto.getRewardPrice()%>">
				<span class="f12 red"></span>
			</div>
			<div class="row m20">
				<div class="row"><label>리워드 재고</label></div>
				<input type="number" name="rewardStock" class="form-input w80p checkValue"  value="<%=rewardDto.getRewardStock()%>">
				<span class="f12 red"></span>
				<input type="checkbox" class="form-input ckbox" value="<%=rewardDto.getRewardIsoption()%>">
				<input type="hidden" name="rewardIsOption" value="<%=rewardDto.getRewardIsoption()%>">
				<label class="f12 gray">상세 옵션 여부</label>
			</div>
			<div class="row m20">
				<div class="row"><label>배송비</label></div>
				<input type="number" name="rewardDelivery" class="form-input w80p checkValue" value="<%=rewardDto.getRewardDelivery()%>">
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
			<button type="submit"  class="btn fill">리워드 수정하기</button>
		</div>
</form>
		
	</div>

<jsp:include page = "/template/footer.jsp"></jsp:include>