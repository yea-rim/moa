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
%>
<title>moa 공지수정</title>
<style>
textarea[name=noticeContent] {
	width: 100%;
	height: 500px;
	resize: none;
	padding: 1em;
}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<hr style="border:solid 0.5px lightgray">
	<div class="container w800 m50">
		
		<div class="row">
			<h2>공지 수정</h2>
		</div>
		
		<form action="edit.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="noticeNo" value="<%=noticeNo %>">
			<div class="row fill m10">
				<input type="text" name="noticeTitle" required  class="form-input fill" autocomplete="off" value="<%=moaNoticeDto.getNoticeTitle() %>">
			</div>
			
			<div class="row fill m10">
				<input type="file" name="attachProfile">
			</div>
			<div class="row fill m10">
				<input type="file" name="attachContent">
			</div>
			
			<div class="row fill center m10">
				<textarea name="noticeContent" required><%=moaNoticeDto.getNoticeContent() %></textarea>
			</div>
			
			<div class="row center fill">
				<button type="submit" class="btn fill">수정</button>
			</div>
		</form>
		
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>