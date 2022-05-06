<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 
	진행중인 펀딩목록
--%>
<%-- 준비 --%>
<%
request.setCharacterEncoding("UTF-8");

String type = request.getParameter("type");
String keyword = request.getParameter("keyword");

// 정렬
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
	s = 9;
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
		list = projectDao.closingSelectList(p, s, type, keyword, sort);
	} else {
		list = projectDao.closingSelectList(p, s, type, keyword);
	}
} else {
	list = projectDao.closingSelectList(p, s, sort);
}
%>
<title>moa 펀딩마감</title>
	
<style>

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

.flex-container1 .flex-items,
.flex-container2 .flex-items {
	flex-basis:33.33%;
	padding: 2em; 
}

.category{
	padding: 30px;
}


.a {
	flex-grow: 1;
}

.b {
	flex-grow: 1;
} 

.img {
	border-radius: 100%;
	width:60px;
	height: 60px;
}
.project-name {
    text-overflow: ellipsis;
    overflow: hidden;
    height: 3em; 
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
    $(function () {
      $(".sort").change(function () {
    	  this.form.submit();
      });
	});
</script>

<%-- 출력 --%>
<jsp:include page="/template/header.jsp"></jsp:include>


	<div class="container">
	
		<div class="row flex-container1 m30">
			<div class="row center category">
				<a href="comingList.jsp" class="link">
				<h2>펀딩예정</h2>
				</a>
			</div>
			
			<div class="row center category">
				<a href="ongoingList.jsp" class="link">
				<h2>펀딩진행중</h2>
				</a>
			</div>
			
			<div class="row center category">
				<a href="closingList.jsp" class="link">
				<h2>펀딩마감</h2>
				</a>
			</div>
		</div>

		<%-- 카테고리 선택창 --%>
		
		<div class="container">
		
			<div class="row flex-container1">
		
		
				<div class="row center category">
					<a href="closingList.jsp" class="link">
					<img src="<%=request.getContextPath()%>/project/image/전체-카테고리.jpeg" class="img" id="all">
					<hr style="border: solid #B899CD 1px">
					<label for="all">전체</label>
					</a> 
				</div>
		
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=패션/잡화" class="link">
					<img src="<%=request.getContextPath()%>/project/image/패션잡화-카테고리.jpeg" class="img" id="fashion">
					<hr style="border: solid #B899CD 1px">
					<label for="fashion">패션/잡화</label>
					</a>
				</div>
				
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=뷰티" class="link">
					<img src="<%=request.getContextPath()%>/project/image/뷰티-카테고리.jpeg" class="img" id="beauty">
					<hr style="border: solid #B899CD 1px">
					<label for="beauty">뷰티</label>
					</a> 
				</div>
				
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=푸드" class="link">
					<img src="<%=request.getContextPath()%>/project/image/푸드-카테고리.jpeg" class="img" id="food">
					<hr style="border: solid #B899CD 1px">
					<label for="food">푸드</label>
					</a> 
				</div>
				
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=홈/리빙" class="link">
					<img src="<%=request.getContextPath()%>/project/image/홈리빙-카테고리.jpeg" class="img" id="living">
					<hr style="border: solid #B899CD 1px">
					<label for="living">홈/리빙</label>
					</a> 
				</div>
				
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=테크/가전" class="link">
					<img src="<%=request.getContextPath()%>/project/image/테크-카테고리.jpeg" class="img" id="tech">
					<hr style="border: solid #B899CD 1px">
					<label for="tech">테크/가전</label>
					</a>
				</div>
				
				<div class="row center category">
					<a href="closingList.jsp?type=project_category&keyword=기타" class="link">
					<img src="<%=request.getContextPath()%>/project/image/etc-카테고리.jpeg" class="img" id="etc">
					<hr style="border: solid #B899CD 1px">
					<label for="etc">기타</label>
					</a>
				</div>
				
			</div>
		
		</div>
		<%-- 정렬기준 선택창  --%>
		<div class="row right category">
			<%if (isSearch) {%>
			<form action="closingList.jsp#mainList" method="get">
				<input type="hidden" name="type" value="<%=type%>"> 
				<input type="hidden" name="keyword" value="<%=keyword%>"> 
				<select name="sort" class="sort">
					<option>최신순</option>
					<option>좋아요순</option>
					<option>인기순</option>
					<option>펀딩액순</option>
				</select> 
				<!-- <input type="submit" value="정렬"> -->
				<!-- 이 부분은 js에서 onchang로 설정하면 버튼없이 선택하면 바로 바뀜 -->
			</form>
			<%} else {%>
			<form action="closingList.jsp#mainList" method="get">
				<select name="sort" class="sort">
					<option>최신순</option>
					<option>좋아요순</option>
					<option>인기순</option>
					<option>펀딩액순</option>
				</select> 
				<!-- <input type="submit" value="정렬"> -->
				<!-- 이 부분은 js에서 onchang로 설정하면 버튼없이 선택하면 바로 바뀜 -->
			</form>
			<%}%>
			</div>
		
			
	
		<%-- 결과목록 --%>
		<div class="container">
		 <div class="row flex-container2" id="mainList">
		 <%for(ProjectDto projectDto : list) { %>
	 	 	<%-- <% 
		 		int projectNo = projectDto.getProjectNo();
				ProjectAttachDao projectAttachDao = new ProjectAttachDao();
			
				// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
				int attachNo = projectAttachDao.getAttachNo(projectNo);
		 	%> --%>
            <div class="flex-items">
              <div class="row center">
              	<a href="projectDetail.jsp?projectNo=<%=projectDto.getProjectNo() %>">
			       	<%-- <img src="download.kh?attachNo=<%=attachNo %>" width="100%" --%>
                	<img src="<%=request.getContextPath()%>/project/image/기타-카테고리.jpeg" width="100%">
                </a>
              </div>
              <div class="row project-name"><%=projectDto.getProjectName() %></div>
              <div class="row"><%=projectDto.getProjectCategory() %></div>

              <hr style="border: solid #B899CD 1px" />

              <% ProjectVo projectVo = projectDao.selectVo(projectDto.getProjectNo()); %>
              <div class="flex-container2">
                <div style="color:#B899CD " class="row left a"><%=projectVo.getPercent() %>%</div>
                <div class="row right b">펀딩종료</div>
              </div>
            </div>
          <%} %>
          </div>
         </div>


		<!--  순자 페이지네이션 -->
		<%
		int count;
		if (isSearch) {
			count = projectDao.closingCountByPaging(type, keyword);
		} else {
			count = projectDao.closingCountByPaging();
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
			<div class="pagination center">
				<%
				if (p > 1) { // 첫페이지가 아니라면
				%>
				<%if (isSearch) {%>
					<%if(sort != null) { %>
					<a href="closingList.jsp?p=1&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>&sort=<%=sort %>">&laquo;</a>
					<%} else{ %>
					<a href="closingList.jsp?p=1&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&laquo;</a>
					<%} %>
				<%} else {%>
				<a href="closingList.jsp?p=1&s=<%=s%>&sort=<%=sort %>">&laquo;</a>
				<%}%>
				<%}%>

				<%
				if (startBlock > 1) { // 이전 블록이 있으면
				%>
				<%if (isSearch) {%>
				<a
					href="closingList.jsp?p=<%=startBlock - 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&lt;</a>
				<%} else {%>
				<a href="closingList.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
				<%}%>
				<%}%>


				<!-- 숫자 링크 영역 -->
				<%for (int i = startBlock; i <= endBlock; i++) {%>
				<%if (isSearch) {%>
					<%if(sort != null) {%>
						<%if (i == p) {%>
						<a class="active" href="closingList.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>&sort=<%=sort %>"><%=i%></a>
						<%} else {%>
						<a href="closingList.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>&sort=<%=sort %>"><%=i%></a>
						<%}%>
					<%} else { %>
						<%if (i == p) {%>
						<a class="active" href="closingList.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
						<%} else {%>
						<a href="closingList.jsp?p=<%=i%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
						<%}%>
					<%} %>

				<%} else {%>
				<%if (i == p) {%>
				<a class="active" href="closingList.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort %>"><%=i%></a>
				<%} else {%>
				<a href="closingList.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort %>"><%=i%></a>
				<%}%>

				<%}%>
				<%}%>

				<!-- 다음 버튼 영역 -->
				<%if (endBlock < lastPage) {%>
				<%if (isSearch) { // 다음 블록이 있으면 %>
					<%if(sort != null){ %>
					<a href="closingList.jsp?p=<%=endBlock + 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>&sort<%=sort %>">&gt;</a>
					<%} else { %>
					<a href="closingList.jsp?p=<%=endBlock + 1%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&gt;</a>
					<% } %>
				<%} else {%>
				<a href="closingList.jsp?p=<%=endBlock + 1%>&s=<%=s%>&sort=<%=sort %>">&gt;</a>
				<%}%>
				<%}%>

				<%
				if (p < lastPage) { // 마지막 페이지가 아니라면
				%>
				<%if (isSearch) {%>
					<%if(sort != null) { %>
					<a href="closingList.jsp?p=<%=lastPage%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>&sort=<%=sort %>">&raquo;</a>
					<%} else {%>
					<a href="closingList.jsp?p=<%=lastPage%>&s=<%=s%>&type=<%=type%>&keyword=<%=keyword%>">&raquo;</a>
					<%} %>
				<%} else {%>
				<a href="closingList.jsp?p=<%=lastPage%>&s=<%=s%>&sort=<%=sort %>">&raquo;</a>
				<%}%>
				<%}%>
			</div>
			
		</h4>
		
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>

