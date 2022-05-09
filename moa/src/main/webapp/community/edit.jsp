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
%>
<title>moa 홍보게시글 작성</title>
<style>
textarea[name=communityContent] {
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
			<h2>게시글 작성</h2>
		</div>
		
		<form action="edit.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="communityNo" value="<%=communityNo %>">
			<div class="row fill m10">
				<input type="text" name="communityTitle" required value="<%=communityDto.getCommunityTitle() %>"  class="form-input fill" autocomplete="off">
			</div>
			
			<div class="row fill m10">
				<input type="file" name="attach">
			</div>
			
			<div class="row fill center m10">
				<textarea name="communityContent" required ><%=communityDto.getCommunityContent() %></textarea>
			</div>
			
			<div class="row center fill">
				<button type="submit" class="btn fill">수정</button>
			</div>
		</form>
		
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>