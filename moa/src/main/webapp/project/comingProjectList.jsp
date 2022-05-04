<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 
	예정 펀딩목록
	예정 펀딩목록의 경우 정렬기준에서 펀딩액순, 마감임박순을 제외 
	comingSelectList() 메소드 사용
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>moa 예정된 펀딩목록</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/layout.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/commons.css">
	
<style>

.flex-container {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
}

.a {
	width: 25%;
	padding: 10px;
	margin: 15px;
}


.d {
	flex-grow: 1;
}

.e {
	flex-grow: 1;
} 

</style>

</head>
<%-- 준비 --%>
<%
request.setCharacterEncoding("UTF-8");

String type = request.getParameter("type");
String keyword = request.getParameter("keyword");

String sort = request.getParameter("sort");

if (sort == null) {
	sort = "최신순";
}

int p;
try {
	p = Integer.parseInt(request.getParameter("p"));
	if (p <= 0) {
		throw new Exception();
	}
} catch (Exception e) {
	p = 1;
}

int s;
try {
	s = Integer.parseInt(request.getParameter("s"));
	if (s <= 0) {
		throw new Exception();
	}
} catch (Exception e) {
	s = 10;
}

// 시작지점, 종료지점 계산
int end = p * s;
int begin = end - (s - 1);
%>

<%-- 처리 --%>
<%
boolean isSearch = type != null && keyword != null;

ProjectDao projectDao = new ProjectDao();
List<ProjectDto> list;
if (isSearch) {
	if (sort != null) {
		list = projectDao.comingSelectList(p, s, type, keyword, sort);
	} else {
		list = projectDao.comingSelectList(p, s, type, keyword);
	}
} else {
	list = projectDao.comingSelectList(p, s, sort);
}
%>
<%-- 출력 --%>

<body>


	<div class="container w1000">
		<div class="row">
			<h1>예정된 펀딩목록</h1>
		</div>

		<%-- 카테고리 선택창 --%>
		<a href="comingProjectList.jsp">전체</a> <a
			href="comingProjectList.jsp?type=project_category&keyword=패션/잡화">패션/잡화</a>
		<a href="comingProjectList.jsp?type=project_category&keyword=뷰티">뷰티</a> <a
			href="comingProjectList.jsp?type=project_category&keyword=푸드">푸드</a> <a
			href="comingProjectList.jsp?type=project_category&keyword=홈/리빙">홈/리빙</a> <a
			href="comingProjectList.jsp?type=project_category&keyword=테크/가전">테크/가전</a>
		<a href="comingProjectList.jsp?type=project_category&keyword=기타">기타</a>

		<%-- 정렬기준 선택창  --%>
		</form>
		<%
		if (isSearch) {
		%>
		<form action="comingProjectList.jsp" method="get">
			<input type="hidden" name="type" value="<%=type%>"> <input
				type="hidden" name="keyword" value="<%=keyword%>"> <select
				name="sort">
				<option>최신순</option>
				<option>좋아요순</option>
				<option>인기순</option>
			</select> <input type="submit" value="정렬">
			<!-- 이 부분은 js에서 onchang로 설정하면 버튼없이 선택하면 바로 바뀜 -->
		</form>
		<%} else {%>
		<form action="comingProjectList.jsp" method="get">
			<select name="sort">
				<option>최신순</option>
				<option>좋아요순</option>
				<option>인기순</option>
			</select> <input type="submit" value="정렬">
			<!-- 이 부분은 js에서 onchang로 설정하면 버튼없이 선택하면 바로 바뀜 -->
		</form>
		<%}%>		
		
		<%-- 진짜 결과목록 --%>
		<div class="container m30">
		 <div class="flex-container">
		 <%for(ProjectDto projectDto : list) { %>
            <div class="a">
              <div class="row center">
                <img src="download.kh?attachmentNo=6" width="100%">
              </div>
              <div class="row"><%=projectDto.getProjectName() %></div>
              <div class="row"><%=projectDto.getProjectCategory() %></div>

              <hr style="border: solid green 1px" />

              <div class="flex-container">
                <div class="row left d">달성률</div>
                <div class="row right e">D-day</div>
              </div>
            </div>
          <%} %>
          </div>
          </div>


		<!-- 페이지네이션 -->
		<%
		int count;
		if (isSearch) {
			count = projectDao.countByPaging(type, keyword);
		} else {
			count = projectDao.countByPaging();
		}

		// 마지막 페이지 번호 계산
		int lastPage = (count + s - 1) / s;

		// 블록 크기(한 화면에 표시되는 페이지 )
		int blockSize = 10;

		int endBlock = (p + blockSize - 1) / blockSize * blockSize;
		int startBlock = endBlock - (blockSize - 1);

		// 범위를 초과하는 문제를 해결(endBlock > lastPage)
		if (endBlock > lastPage) {
			endBlock = lastPage;
		}
		%>

		<h4>
			<!-- 이전 버튼 영역 -->
			<div class="pagination">
				<%
				if (p > 1) { // 첫페이지가 아니라면
				%>
				<%if (isSearch) {%>
				<a href="list.jsp?p=1&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&laquo;</a>
				<%} else {%>
				<a href="list.jsp?p=1&s=<%=s%>">&laquo;</a>
				<%}%>
				<%}%>

				<%
				if (startBlock > 1) { // 이전 블록이 있으면
				%>
				<%if (isSearch) {%>
				<a
					href="list.jsp?p=<%=startBlock - 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&lt;</a>
				<%} else {%>
				<a href="list.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
				<%}%>
				<%}%>


				<!-- 숫자 링크 영역 -->
				<%for (int i = startBlock; i <= endBlock; i++) {%>
				<%if (isSearch) {%>

				<%if (i == p) {%>
				<a class="active"
					href="list.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
				<%} else {%>
				<a
					href="list.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
				<%}%>

				<%} else {%>
				<%if (i == p) {%>
				<a class="active" href="list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
				<%} else {%>
				<a href="list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
				<%}%>

				<%}%>
				<%}%>

				<!-- 다음 버튼 영역 -->
				<%if (endBlock < lastPage) {%>
				<%if (isSearch) { // 다음 블록이 있으면 %>
				<a
					href="list.jsp?p=<%=endBlock + 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&gt;</a>
				<%} else {%>
				<a href="list.jsp?p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
				<%}%>
				<%}%>

				<%
				if (p < lastPage) { // 마지막 페이지가 아니라면
				%>
				<%if (isSearch) {%>
				<a
					href="list.jsp?p=<%=lastPage%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&raquo;</a>
				<%} else {%>
				<a href="list.jsp?p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
				<%}%>
				<%}%>
			</div>
		</h4>
	</div>

</body>

