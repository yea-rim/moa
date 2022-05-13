<%@page import="moa.beans.AttachDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.MoaNoticeAttachDto"%>
<%@page import="moa.beans.MoaNoticeAttachDao"%>
<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.MoaNoticeDto"%>
<%@page import="moa.beans.MoaNoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 준비 --%>
<% 
	boolean isAdmin = session.getAttribute("admin") != null;

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
%>
<% 
	MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
	MoaNoticeDto moaNoticeDto = moaNoticeDao.selectOne(noticeNo);
	
	MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
	MoaNoticeAttachDto moaNoticeAttachDtoProfile = moaNoticeAttachDao.selectProfile(noticeNo);
	MoaNoticeAttachDto moaNoticeAttachDtoContent = moaNoticeAttachDao.selectContent(noticeNo);
	
	boolean isExistProfile = moaNoticeAttachDtoProfile != null;
	boolean isExistContent = moaNoticeAttachDtoContent != null;
	
	AttachDao attachDao = new AttachDao();
	AttachDto attachDtoProfile;
	AttachDto attachDtoContent;
	
	if(isExistProfile && isExistContent){
		attachDtoProfile = attachDao.selectOne(moaNoticeAttachDtoProfile.getAttachNo()); 
		attachDtoContent = attachDao.selectOne(moaNoticeAttachDtoContent.getAttachNo()); 
	}
	else if(isExistProfile && !isExistContent){
		attachDtoProfile = attachDao.selectOne(moaNoticeAttachDtoProfile.getAttachNo()); 
		attachDtoContent = null;
	}
	else if(!isExistProfile && isExistContent){
		attachDtoProfile = null;
		attachDtoContent = attachDao.selectOne(moaNoticeAttachDtoContent.getAttachNo()); 
	}
	else {
		attachDtoProfile = null;
		attachDtoContent = null; 
	}
%>
<title>moa 공지수정</title>
<style>
textarea[name=noticeContent] {
	height: 400px;
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
.upload-name1,
.upload-name2 {
	display: inline-block;
	height: 35px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #B6B6B6;
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
	background-color: #dddddd;
	border-radius: 0.3em;
	cursor: pointer;
	height: 35px;
	margin-left: 5px;
	font-size: 13px;
}

.table.table-a>tbody>tr>th, .table.table-a>tbody>tr>td {
	text-align: left;
	border-bottom: 0.5px solid #f1f2f6;
	padding: 1em;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$(".notice-title").on("input", function() {
			var content = $(this).val();
			var length = content.length;

			while (length > 30) {
				$(this).val($(this).val().substring(0, length - 1));
				length--;
			}
		});

		$(".notice-content").on("input", function() {
			var content = $(this).val();
			
			var length = content.length;
			while (length > 1300) {
				$(this).val($(this).val().substring(0, length - 1));
				length--;
			}
		});
		
        // 작성중 페이지 이탈 방지
        var checkUnload = true;
        $(".notice-submit").on("click", function () {
          checkUnload = false;
        });
        $(window).on("beforeunload", function () {
          if (checkUnload) {
            return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
          }
        });
        
        function vali(val) {
	          if (val === null) return true;
	          if (val === "") return true;
	          if (typeof val === "undefined") return true;

	          return false;
	        }
        // null 방지 
	      $(".form-all").on("submit", function () {
	          if (vali($(".notice-title").val())) {
	            alert("제목을 입력해주세요");
	            return false;
	          } else {
	            return true;
	          }
	        });
		
		 $(".form-all").on("submit", function () {
	          if (vali($(".notice-content").val())) {
	            alert("내용을 입력해주세요");
	            return false;
	          } else {
	            return true;
	          }
	        });
		 
		
		// 파일명 input에 출력하는 JS
		$("#file1").on('change', function() {
			var fileFullName = $("#file1").val();
			var fileName = fileFullName.substring(12, fileFullName.length);
			$(".upload-name1").val(fileName);
		});
		
		$("#file2").on('change', function() {
			var fileFullName = $("#file2").val();
			var fileName = fileFullName.substring(12, fileFullName.length);
			$(".upload-name2").val(fileName);
		});
		
	});
</script>
<jsp:include page="/template/header.jsp"></jsp:include>






<form action="edit.do" method="post" enctype="multipart/form-data" class="form-all">
<input type="hidden" name="noticeNo" value="<%=noticeNo %>">
	<div class="container w700">
		<div class="row mt50 m10">
			<div class="flex-container">
				<div class="left-wrapper mlr10">
					<h3>공지사항 수정</h3>
				</div>
			</div>
		</div>
		<hr>
		<div class="row">
			<table class="table table-a">
				<tbody>
					<tr>
						<th style="width: 110px">작성자</th>
						<td>
							<h4>moa</h4>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="form-input fill notice-title" name="noticeTitle" value="<%=moaNoticeDto.getNoticeTitle() %>" autocomplete="off">
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">공지내용</th>
						<td>
							<textarea rows="5" class="form-input fill notice-content" name="noticeContent"><%=moaNoticeDto.getNoticeContent() %></textarea>
						</td>
					</tr>
					<tr>
						<th>프로필 파일</th>
						<td>
							<div class="filebox-a">
							<%if(attachDtoProfile != null){ %>
								<input class="upload-name1" placeholder="<%=attachDtoProfile.getAttachUploadname() %>"> 
							<%} else{ %>
								<input class="upload-name1" placeholder="파일첨부"> 
							<%} %>
									<label for="file1">파일선택</label> 
								<input type="file" id="file1" name="attachProfile">
							</div>
						</td>
					</tr>
					<tr>
						<th>본문 파일</th>
						<td>
							<div class="filebox-a">
							<%if(attachDtoContent != null){ %>
								<input class="upload-name2" placeholder="<%=attachDtoContent.getAttachUploadname() %>"> 
							<%} else{ %>
								<input class="upload-name2" placeholder="파일첨부"> 
							<%} %>
									<label for="file2">파일선택</label> 
								<input type="file" id="file2" name="attachContent">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row m50">
			<div class="flex-container">
				<div class="left-wrapper right mlr10">
					<input type="submit" value="수정하기" class="link link-btn w150 notice-submit">
				</div>
				<div class="right-wrapper">
					<a href="detail.jsp?noticeNo=<%=moaNoticeDto.getNoticeNo() %>"> <input type="button" value="취소"
						class="link link-reverse w150">
					</a>
				</div>
			</div>
		</div>
	</div>
</form>


<jsp:include page="/template/footer.jsp"></jsp:include>