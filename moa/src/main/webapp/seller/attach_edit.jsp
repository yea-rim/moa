<%@page import="moa.beans.AttachDto"%>
<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int projectNo = Integer.parseInt(request.getParameter("projectNo"));

ProjectAttachDao projectAttachDao = new ProjectAttachDao();
List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);

AttachDao attachDao = new AttachDao();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style>
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
	width: 50%;
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
	margin-left: 10px;
	font-size: 12px;
}
</style>
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
        });
    </script>
    
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
    
<div class="container w900">
	<div class="row center mb40">
		<h1 class="m5">프로젝트 이미지 수정</h1>
		<span class="f12 gray"> 각각 최대 3장 까지 설정 가능합니다.</span>
	</div>
	
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
							class="card-image-wrapper" width="150px" height="112px">
					</div>
					<div class="row mt15 mlr10">
						<div class="filebox-a center w200">
							<form action="attach_edit.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input type="hidden" name="attachNo" value="<%=attachDto.getAttachNo()%>">
								<input class="upload-name" placeholder="<%=attachDto.getAttachUploadname()%>"> 
								<label for="file<%=count%>">선택</label> <input type="file" id="file<%=count++ %>" name="attach">
								<button type="submit" class="link link-small btn-edit f12">수정</button>
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
	<!-- 본문 이미지 수정 -->
	<div class="row m20 mlr30">
		<h2>* 본문 이미지</h2>
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
						<div class="filebox-a center w200">
							<form action="attach_edit.do" method="post" enctype="multipart/form-data">
								<input type="hidden" name="projectNo" value="<%=projectNo%>">
								<input type="hidden" name="attachNo" value="<%=attachDto.getAttachNo()%>">
								<input class="upload-name" placeholder="<%=attachDto.getAttachUploadname()%>"> 
								<label for="file2<%=count2%>">선택</label> <input type="file" id="file2<%=count2++ %>" name="attach">
								<button type="submit" class="link link-small btn-edit f12">수정</button>
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



<jsp:include page="/template/footer.jsp"></jsp:include>