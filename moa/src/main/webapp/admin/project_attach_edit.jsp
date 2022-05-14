<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.AttachDto"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int projectNo = Integer.parseInt(request.getParameter("projectNo"));

ProjectAttachDao projectAttachDao = new ProjectAttachDao();
List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);

int profileListSize = profileList.size();
int detailListSize = detailList.size();

AttachDao attachDao = new AttachDao();
%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
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
    <script type="text/javascript">
        $(function(){
	        // 파일명 input에 출력하는 JS
	        $(".attach").each(function(){
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
	      
	 	//삭제 기본 이벤트 차단
	 	$(".btn-del").click(function() {
	 		return confirm("정말 삭제 하시겠습니까?");
	 	});
	        
        });
    </script>
    
     <div class="flex-container mt40">
		 <!-- 마이페이지 메인으로 이동 -->
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/admin/project_project_detail.jsp?projectNo=<%=projectNo %>">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="<%=request.getContextPath() %>/admin/project_detail.jsp?projectNo=<%=projectNo %>" class="link mlr5">
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
								<a href="<%=request.getContextPath()%>/admin/attach_delete.do?attachNo=<%=attachDto.getAttachNo()%>&projectNo=<%=projectNo%>">
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
									<a href="<%=request.getContextPath()%>/admin/attach_delete.do?attachNo=<%=attachDto.getAttachNo()%>">
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



<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>