<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.CommunityDto"%>
<%@page import="moa.beans.CommunityDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%-- 준비 --%>
<%
request.setCharacterEncoding("UTF-8");

String type = request.getParameter("type");
String keyword = request.getParameter("keyword");

 int p;
 try {  
	 p = Integer.parseInt(request.getParameter("p"));
 	 if(p <= 0){
 		 throw new Exception();
 	 }
 }
 catch(Exception e){ 
	 p = 1;
 }
 
 int s;
 try{
	 s = Integer.parseInt(request.getParameter("s"));
	 if(s <= 0){
		 throw new Exception();
	 }
 }
 catch(Exception e){
	 s = 10;
 }
 
 // 시작지점, 종료지점 계산
 int end = p*s;
 int begin = end - (s-1);

%>

<%-- 처리 --%>
<%
boolean isSearch = type != null && keyword != null;

CommunityDao communityDao = new CommunityDao();
List<CommunityDto> list;
if (isSearch) {
	list = communityDao.selectList(p, s, type, keyword);
} else {
	list = communityDao.selectList(p, s);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>moa 홍보게시판</title>
	
<style>
.flex-container1 {
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: center;
}
.flex-container2 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	height: 60px;
}
.flex-items1 {
	flex-basis:10%;
}
.flex-items2 {
	flex-basis:60%;
}
.flex-items3 {
	flex-basis:15%;
}
.flex-items4 {
	flex-basis:15%;
}
.bottom{
	align-self: flex-end;
}
.community-name {
    text-overflow: ellipsis;
    overflow: hidden;
}
.search{
	justify-content: center;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>



<%-- 검색결과 --%>
<hr style="border:solid 0.5px lightgray">

<div class="container m50">
	<div class="row center">
		<a href="list.jsp?p=1&s=10" class="link">
			<h1>홍보게시판</h1>
		</a>
	</div>
</div>

<div class="container w800 m70">
				
				<hr style="border:solid 1px #B899CD">
			<div class="row flex-container2">
				<div class="flex-items1">번호</div>
				<div class="flex-items2 center">제목 / 프로젝트이름</div>
				<div class="flex-items3">날짜</div>
				<div class="flex-items4 right">작성자</div>
			</div>
			<hr style="border:solid 1px #B899CD">
			<div class="row flex-container1">
		<%for (CommunityDto communityDto : list) {%>
			
				<div class="row flex-container2">
				
					<div class="flex-items1 bottom">
						<span><%=communityDto.getCommunityNo() %> </span>
					</div>
					
					<% 
						ProjectDao projectDao = new ProjectDao();
						ProjectDto projectDto = projectDao.selectOne(communityDto.getCommunityProjectNo());
					%>
					<div class="flex-items2 bottom community-name">
						<span>
							<a href="detail.jsp?communityNo=<%=communityDto.getCommunityNo() %>" class="link">
								<h3><%=communityDto.getCommunityTitle() %>(<%=communityDto.getCommunityReplycount() %>)</h3>
							</a>
						</span>
						<span class="m10">
							<h5>/ <%=projectDto.getProjectName() %></h5>
						</span>
					</div>

					<div class="flex-items3 bottom">
						<span><%=communityDto.getCommunityTime() %></span>
					</div>
								
					<% 
						MemberDao memberDao = new MemberDao();
						MemberDto memberDto = memberDao.selectOne(communityDto.getCommunityMemberNo());
					%>
					<div class="flex-items4 row right bottom">
						<span><%=memberDto.getMemberNick() %></span>
					</div>
					
				</div>
		<%}%>
			</div>
			
			<br><hr style="border:solid 1px #B899CD">

<!--  순자 페이지네이션 -->
<%
int count;
if(isSearch)
{
	count = communityDao.countByPaging(type, keyword);
}else
{
	count = communityDao.countByPaging();
}

// 마지막 페이지 번호 계산
int lastPage = (count + s - 1) / s;

// 블록 크기(한 화면에 표시되는 페이지 )
int blockSize = 10;

// 시작블록 혹은 종료 블록 중 하나만 계산하면 반대편은 계산이 가능하다.
// 종료블록에 영향을 미치는 데이터는 현재 페이지(p)이다. 
// 하단 블록에는 반드시 현재페이지 번호가 포함되어야 하므로 반드시 현재 페이지(p)가 포함되어 계산한다. 
int endBlock = (p + blockSize - 1) / blockSize * blockSize;
int startBlock = endBlock - (blockSize - 1);

// 범위를 초과하는 문제를 해결(endBlock > lastPage)
if(endBlock>lastPage)
{
	endBlock = lastPage;
}
%>

<h3>
	<!-- 이전 버튼 영역 -->
<div class="pagination center m50">
<%if(p>1){ // 첫페이지가 아니라면 %>
	<%if (isSearch) {%>
	<a href="list.jsp?p=1&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&laquo;</a>
	<%} else {%>
	<a href="list.jsp?p=1&s=<%=s%>">&laquo;</a>
	<%}%>
	<%}%>

<%if(startBlock>1){ // 이전 블록이 있으면%>
	<%if (isSearch) {%>
	<a href="list.jsp?p=<%=startBlock - 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&lt;</a>
	<%} else {%>
	<a href="list.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
	<%}%>
<%}%>


<!-- 숫자 링크 영역 -->
<%for(int i = startBlock;i<=endBlock;i++){ %>
	<%if (isSearch) {%>
	
	<%if(i==p){ %>
	<a class="active" href="list.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
	<%} else{ %>
	<a href="list.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
	<%} %>
	
	<%} else {%>
	<%if(i==p){ %>
	<a class="active" href="list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
	<%} else{ %>
	<a href="list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
	<%} %>
	
	<%}%>
<%}%>

<!-- 다음 버튼 영역 -->
<%if(endBlock<lastPage) {%>
	<%if (isSearch) { // 다음 블록이 있으면 %>
	<a href="list.jsp?p=<%=endBlock + 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&gt;</a>
	<%} else {%>
	<a href="list.jsp?p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
	<%}%>
<%}%>

<%if(p<lastPage) { // 마지막 페이지가 아니라면%>
	<%if (isSearch) {%>
	<a href="list.jsp?p=<%=lastPage%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&raquo;</a>
	<%} else {%>
	<a href="list.jsp?p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
	<%}%>
<%}%>
</div>

</h3>
<%-- 검색창 --%>
	
		<form action="list.jsp" method="get">
			<div class="flex-container search">
				<div>
					<select name="type" required class="form-input">
						<option value="community_title">제목</option>
						<option value="community_content" selected>내용</option>
					</select> 
				</div>
				<div>
			   	 	<input type="text" name="keyword" placeholder="검색어 입력" autocomplete="off" required class="form-input" style="height:100%">
			   	 </div>
			   	 <div>
				 	<button type="submit" class="btn-reverse" style="height:100%">검색</button>
				 </div>
			</div>
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>