<%@page import="moa.beans.MoaNoticeAttachDto"%>
<%@page import="moa.beans.MoaNoticeAttachDao"%>
<%@page import="moa.beans.MoaNoticeDto"%>
<%@page import="moa.beans.MoaNoticeDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 준비 --%>
<% 
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	boolean isAdmin = session.getAttribute("admin") != null; 
%>
<%-- 처리 --%>
<% 
	MoaNoticeDao moaNoticeDao = new MoaNoticeDao();
	moaNoticeDao.editReadCount(noticeNo);
	
	MoaNoticeDto moaNoticeDto = moaNoticeDao.selectOne(noticeNo);
	
	// 해당 게시글 사진 가져오기
	MoaNoticeAttachDao moaNoticeAttachDao = new MoaNoticeAttachDao();
	MoaNoticeAttachDto moaNoticeAttachDto = moaNoticeAttachDao.selectContent(noticeNo);
	
	// 사진이 있는지 판정
	boolean isExistPhoto = moaNoticeAttachDto != null;
%>
<style>
.community-title {
	font-size: 20px;
}
.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
}
.flex-container2 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
}
.flex-items1 {
	flex-basis:10%;
}
.flex-items2 {
	flex-basis:65%;
}
.flex-items3 {
	flex-basis:15%;
}

.reply-btn {
	height: 40px;
}

.flex-item-a {
	flex-basis:10%;
}
.flex-item-b {
	flex-basis:90%;
}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>    
<div class="container w800">
<div class="container w800 m30">
	<div class="row m10" class="community-title">
			<h2><%=moaNoticeDto.getNoticeTitle() %></h2>
	</div>
	<div class="row flex-container">
		<div class="row left flex-item-a">
			<br>
			<%-- <h5>조회수: <%=to.getCommunityReadcount() %></h5> --%>
		</div>
		<div class="row right flex-item-b">
			<h5><%=moaNoticeDto.getNoticeTime() %></h5>
		</div>
	</div>
	<hr style="border:solid 0.5px #B899CD">
	<div class="row m20">
 		<%if(isExistPhoto){ %>
		<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=moaNoticeAttachDto.getAttachNo() %>" width="100%">
		<%}else{ %>
		<span></span>
		<%} %>
	</div>
	<div class="row m50 noticeContent">
			<%=moaNoticeDto.getNoticeContent() %>
	</div>
	<hr style="border:solid 0.5px #B899CD">
</div>

	 <%-- <%if(isAdmin){ %> --%>
		<div class="row right">
			<a href="edit.jsp?noticeNo=<%=noticeNo %>" class="btn-reverse link">수정</a>
			<a href="delete.do?noticeNo=<%=noticeNo %>" class="btn-reverse link">삭제</a>
		</div>
	<%-- <%} %> --%> 
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>