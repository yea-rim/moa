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

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">
<style>
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/board.js"></script>
<script type="text/javascript">
</script>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>



<form action="notice_edit.do" method="post" enctype="multipart/form-data" class="form-all">
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
							<input type="text" class="form-input fill board-title" name="noticeTitle" value="<%=moaNoticeDto.getNoticeTitle() %>" autocomplete="off">
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">공지내용</th>
						<td>
							<textarea rows="5" class="form-input fill board-content" name="noticeContent"><%=moaNoticeDto.getNoticeContent() %></textarea>
						</td>
					</tr>
					<tr>
						<th>프로필 파일</th>
						<td>
							<div class="filebox-a">
							<%if(attachDtoProfile != null){ %>
								<input class="upload-name1" placeholder="<%=attachDtoProfile.getAttachUploadname() %>" disabled> 
							<%} else{ %>
								<input class="upload-name1" placeholder="파일첨부" disabled> 
							<%} %>
									<label for="file1">파일선택</label> 
								<input type="file" id="file1" accept="image/*" name="attachProfile">
							</div>
						</td>
					</tr>
					<tr>
						<th>본문 파일</th>
						<td>
							<div class="filebox-a">
							<%if(attachDtoContent != null){ %>
								<input class="upload-name2" placeholder="<%=attachDtoContent.getAttachUploadname() %>" disabled> 
							<%} else{ %>
								<input class="upload-name2" placeholder="파일첨부" disabled> 
							<%} %>
									<label for="file2">파일선택</label> 
								<input type="file" id="file2" accept="image/*" name="attachContent">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row m50">
			<div class="flex-container">
				<div class="left-wrapper right mlr10">
					<input type="submit" value="수정하기" class="link link-btn w150 board-submit">
				</div>
				<div class="right-wrapper">
					<a href="notice_detail.jsp?noticeNo=<%=moaNoticeDto.getNoticeNo() %>"> 
						<input type="button" value="취소" class="link link-reverse w150">
					</a>
				</div>
			</div>
		</div>
	</div>
</form>


<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>