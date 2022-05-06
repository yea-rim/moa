<%@page import="moa.beans.CommunityDto"%>
<%@page import="moa.beans.CommunityDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 준비 --%>
<%
//목록과 검색을 한페이지에서 한다.
// 구분이 되어야 한다.
// 주소에 type, keyword가 있으면 검색으로 간주
// 없으면 목록으로 간주
request.setCharacterEncoding("UTF-8");
String memberId = (String) session.getAttribute("login");

String type = request.getParameter("type");
String keyword = request.getParameter("keyword");

// 페이징 관련 파라미터들을 수신
 int p;
 try { // p에 정상적인 숫자가 들어온 경우 -0 이하인 경우 
	 p = Integer.parseInt(request.getParameter("p"));
 	 if(p <= 0){
 		 throw new Exception();
 	 }
 }
 catch(Exception e){ // p가 없거나 숫자가 아닌 경우 +0 이하인 경우
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
	//list = boardDao.search(type, keyword);
	list = communityDao.selectList(p, s, type, keyword);
} else {
	//list = boardDao.selectAll();
	list = communityDao.selectList(p, s);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>moa 홍보게시판</title>
	
<style>
 .table {
        width: 100%;
        border-collapse: collapse;
}
.table > thead > tr > th,
.table > thead > tr > td,
.table > tbody > tr > th,
.table > tbody > tr > td,
.table > tfoot > tr > th,
.table > tfoot > tr > td {
        text-align: center;
        padding: 0.5em;
}

.table.table-border > thead > tr > th,
.table.table-border > thead > tr > td,
.table.table-border > tbody > tr > th,
.table.table-border > tbody > tr > td,
.table.table-border > tfoot > tr > th,
.table.table-border > tfoot > tr > td {
        border: 1px solid black;
}

.table.table-hover {}
.table.table-hover > thead > tr,
.table.table-hover > tfoot > tr {
        background-color: #dcdcf1;
}
.table.table-hover > tbody > tr :hover {
        background-color: #dcdcf1;
}

.btn .btn-primary {
}

</style>
<%-- 출력 --%>
<jsp:include page="/template/header.jsp"></jsp:include>


<%-- 검색창 --%>
<div class="container w1000 m50">
	<div class="row center">
		<form action="list.jsp" method="get">
			<select name="type" required class="form-input input-round">
				<option value="commuity_title">제목</option>
				<option value="board_writer">작성자</option>
			</select> 
		   	 <input type="text" name="keyword" placeholder="검색어 입력" required class="form-input">
			<input type="submit" value="검색" class="btn">
		</form>
	</div>


<%-- 검색결과 --%>
	<div class="row right m10">
		<a href="write.jsp" class="link link-btn">글쓰기</a>
	</div>
	
<div class="row center">

<table class="table table-border table-hover">
	<thead>
		<tr>
			<th>글번호</th>
			<th width="40%">제목</th>
			<th>작성자</th>
		</tr>
	</thead>
	<tbody align="center">
		<%for (CommunityDto communityDto : list) {%>
		<tr>
			<td><%=communityDto.getCommunityNo() %></td>
			<td><%=communityDto.getCommunityTitle() %></td>
		</tr>
		<%}%>
	</tbody>


</table>
</div>
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

<h4>
	<!-- 이전 버튼 영역 -->
<div class="pagination">
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
</h4>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>