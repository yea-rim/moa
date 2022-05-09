<%@page import="moa.beans.CommunityReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.CommunityReplyDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
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
<%-- 처리 --%>
<% 
	CommunityDao communityDao = new CommunityDao();
	CommunityDto communityDto = communityDao.selectOne(communityNo);
	
	// 작성자 정보 가져오기
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(communityDto.getCommunityMemberNo());
	
	// 프로젝트 정보 가져오기
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(communityDto.getCommunityProjectNo());
	
	// 해당 게시글 사진 가져오기
	CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
	CommunityPhotoDto communityPhotoDto = communityPhotoDao.selectOne(communityNo);
	
	// 게시글에 사진이 있는지 없는지 판단
	boolean isExistPhoto = communityPhotoDto != null;
	
	
	// 댓글 가져오기
	CommunityReplyDao communityReplyDao = new CommunityReplyDao();
	List<CommunityReplyDto> list = communityReplyDao.selectAll(communityNo); 
%>
<style>
.community-title {
	font-size: 20px;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container w800 m30">
	<div class="row m10" class="community-title">
			<h2><%=communityDto.getCommunityTitle() %></h2>
	</div>
	<div class="row">
		<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=communityDto.getCommunityProjectNo() %>" class="link" style="color:gray">
		<h4>/ <%=projectDto.getProjectName() %></h4>
		</a>
	</div>
	<div class="row m10 right">
		<h5><%=memberDto.getMemberNick() %></h5>
		<h5><%=communityDto.getCommunityTime() %></h5>
	</div>
	<hr style="border:solid 0.5px gray">
	<div class="row m10 right">
		<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=communityDto.getCommunityProjectNo() %>" class="link" style="color:#B899CD">해당프로젝트 보러가기</a>
	</div>
	<div class="row m20">
		<%if(isExistPhoto){ %>
		<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=communityPhotoDto.getAttachNo() %>" width="100%">
		<%}else{ %>
		<span></span>
		<%} %>
	</div>
	<div class="row m50">
		<%=communityDto.getCommunityContent() %>
	</div>
	<div class="row right">
		<a href="edit.jsp?communityNo=<%=communityNo %>" class="btn-reverse link">수정</a>
		<a href="delete.do?communityNo=<%=communityNo %>" class="btn-reverse link">삭제</a>
	</div>
	
	<%-- 댓글 입력창 --%>
	<div class="container w800 m20">
		<div class="row fill">
			<form action="reply_insert.do" method="post">
				<input type="hidden" name="communityNo" value="<%=communityNo %>">
				<input type="text" name="community_reply_content" autocomplete="off">
				<input type="submit" value="작성">
			</form>
		</div>
		
	<%-- 댓글 목록 --%>
		<div class="row">
		<%for(CommunityReplyDto communityReplyDto : list){ %>
			<ul>
				<li><%=communityReplyDto.getCommunityReplyContent() %></li>
			</ul>
		<%} %>
		</div>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>