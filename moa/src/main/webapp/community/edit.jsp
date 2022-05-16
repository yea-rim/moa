<%@page import="moa.beans.AttachDto"%>
<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.CommunityPhotoDto"%>
<%@page import="moa.beans.CommunityPhotoDao"%>
<%@page import="moa.beans.CommunityDto"%>
<%@page import="moa.beans.CommunityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 준비 --%>
<%
	int communityNo = Integer.parseInt(request.getParameter("communityNo"));
%>
<% 
	CommunityDao communityDao = new CommunityDao();
	CommunityDto communityDto = communityDao.selectOne(communityNo);
	
	// 해당 게시글 사진 정보 가져오기
	CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
	CommunityPhotoDto communityPhotoDto = communityPhotoDao.selectOne(communityNo);
	
	// 게시글에 사진이 있는지 없는지 판단
	boolean isExistPhoto = communityPhotoDto != null;
	
	// 게시글 사진 정보 가져오기
	AttachDao attachDao = new AttachDao();
	AttachDto attachDto;
	if(isExistPhoto){
		attachDto = attachDao.selectOne(communityPhotoDto.getAttachNo());
	}
	else {
		attachDto = null;
	}
	
	communityDto.getCommunityContent();
%>
<title>moa 홍보게시글 작성</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">
<style>
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/board.js"></script>
<script type="text/javascript">
</script>
<jsp:include page="/template/header.jsp"></jsp:include>

<form action="edit.do" method="post" enctype="multipart/form-data" class="form-all">
<input type="hidden" name="communityNo" value="<%=communityNo %>">
	<div class="container w700">
		<div class="row mt50 m10">
			<div class="flex-container">
				<div class="left-wrapper mlr10">
					<h3>게시글 수정</h3>
				</div>
			</div>
		</div>
		<hr>
		<div class="row">
			<table class="table table-a">
				<tbody>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="form-input fill board-title" name="communityTitle" autocomplete="off" value="<%=communityDto.getCommunityTitle() %>">
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">공지내용</th>
						<td>
							<textarea rows="5" class="form-input fill board-content" name="communityContent"><%=communityDto.getCommunityContent() %></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<div class="filebox-a">
							<%if(attachDto != null) {%>
								<input class="upload-name" placeholder="<%=attachDto.getAttachUploadname() %>" disabled> 
							<%} else{ %>
								<input class="upload-name" placeholder="첨부파일" disabled> 
							<%} %>
									<label for="file">파일선택</label> 
								<input type="file" id="file" accept="image/*" name="attach">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row m50">
			<div class="flex-container">
				<div class="left-wrapper right mlr10">
					<input type="submit" value="작성하기" class="link link-btn w150 board-submit">
				</div>
				<div class="right-wrapper">
					<a href="list.jsp"> <input type="button" value="취소" class="link link-reverse w150">
					</a>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>