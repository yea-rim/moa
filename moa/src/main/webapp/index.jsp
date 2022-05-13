<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.MoaNoticeDto"%>
<%@page import="moa.beans.MoaNoticeDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ProjectDao projectDao = new ProjectDao();
List<ProjectDto> list1 = projectDao.selectTop();
List<ProjectDto> list2 = projectDao.selectNew();
List<ProjectDto> list3 = projectDao.selectSoon();
%>

<%
ProjectVo projectVo;
SellerDao sellerDao = new SellerDao();
SellerDto sellerDto;

ProjectAttachDto projectAttachDto = new ProjectAttachDto();
ProjectAttachDao projectAttachDao = new ProjectAttachDao();
%>
<style>
.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: space-between;
}

.flex-container2 {
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.flex-container4 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-end;
}

.flex-items1 {
	flex-basis: 60%;
	padding: 20px;
}

.flex-items2 {
	flex-basis: 20%;
	padding: 10px;
}

.flex-items3 {
	flex-basis: 35%;
	padding: 15px;
}

.flex-items-a {
	flex-basis: 5%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.flex-items-b {
	flex-basis: 50%;
	padding: 5px;
	justify-content: center;
}

.flex-items-c {
	flex-basis: 30%;
}

.project-name {
	font-size: 15px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: wrap;
}
.more-btn {
	font-size: 15px;
	color: gray;
	text-decoration: none;
}
.new-name {
	font-size: 20px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: wrap;
}

.percent {
	color: #B899CD;
	font-size: 15px;
}

.seller {
	font-size: 10px;
}

.notice-date {
	font-size: 15px;
	padding: 10px;
}
.category{
	color: gray;
	font-size: 10px;
}
.modu{
	 border-top:1px solid gray;
	 padding-top: 50px;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>


<div class="row flex-container1 flex-items2 modu">
	
	<div class="flex-items1 flex-container2">
	
	<div class="row fill">
		<img src="https://dummyimage.com/500x400" alt="" width="660" height="400">
	</div>
	
	<%-- 신규프로젝트 목록 --%>

	<div class="row flex-items1">
		<div class="row left big-text mt30 mlr10">
			<a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">
				신규 프로젝트
			</a>
		<hr style="border: solid lightgray 0.5px" />
		</div>

		<div class="row flex-container1">
			<%for (ProjectDto projectDto : list2) {%>
			<div class="row flex-items2 m10">
		
				<div class="row">
				<% 	
					// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
					projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
								
					//사진이 있는지 판정
					boolean isExistPhoto = projectAttachDto != null;	
				%> 
					<a href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
					<%if(isExistPhoto){ %>
						<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo() %>" width="200px" height="170px">
					<%} else{ %>
						<img src="https://dummyimage.com/200x200" width="200px" height="170px">
					<%} %>
					</a>
				</div>
			
			<% 
				projectVo = projectDao.selectVo(projectDto.getProjectNo());
				sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
			%>
			<div class="flex-container2">
				<div class="category left">
					<span><%=projectDto.getProjectCategory() %> | <%=sellerDto.getSellerNick() %></span>
				</div>
				<div class="left new-name">
					<a href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link"> 
						<span><%=projectDto.getProjectName()%></span>
					</a>
				</div>
				<div class="left percent">
					<span><%=projectVo.getPercent() %> %</span>
				</div>
			</div>
			
			
			</div>
			<%}%>
		</div>
		<div class="center mt30">
			<a href="<%=request.getContextPath() %>/project/ongoingList.jsp" class="btn-reverse link" style="padding:5px 30px">전체 보러가기</a>
		</div>
	</div>
</div>
	
	<%-- 인기프로젝트 목록 --%>
	<div class="row left big-text flex-items3">
		<a href="<%=request.getContextPath()%>/project/ongoingList.jsp?sort=인기순" class="link">실시간 랭킹</a>
		<hr style="border: solid lightgray 0.5px" />
		<%int count = 0;%>
		<div class="row flex-container2 mt10">
			<%for (ProjectDto projectDto : list1) {%>
			<%count++;%>
			<div class="container fill" style="border-bottom: 0.5px solid #f1f2f6">
				<div class="row flex-container1">
					<div class="row flex-items-a">
						<span style="color: #B899CD"><%=count%></span>
					</div>
					<div class="row flex-container2 flex-items-b">
						<div class="row project-name m10">
							<a
								href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>"
								class="link"> <%=projectDto.getProjectName()%>
							</a>
						</div>

						<%
						projectVo = projectDao.selectVo(projectDto.getProjectNo());
						sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
						%>
							<div class="row seller"><%=sellerDto.getSellerNick()%></div>
							<div class="left percent">
								<span><%=projectVo.getPercent() %>%</span>
							</div>
					</div>

					<div class="row flex-items-c m10 right">
					<% 	
						// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
						projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
						
				 		//사진이 있는지 판정
				 		boolean isExistPhoto = projectAttachDto != null;	
				 	%> 
						<a href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
						<%if(isExistPhoto){ %>
							<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo() %>" width="130px" height="110px">
						<%} else { %>
							<img src="https://dummyimage.com/500x400" width="130px" height="110px">
						<%} %>
						</a>
					</div>
				</div>
			</div>
			<%}%>
		</div>
	</div>
	
</div>
	<%-- 공개예정 프로젝트 목록 --%>

	<div class="row flex-items1">
	<hr style="border: solid #f1f2f6 0.5px" />
		<div class="row left big-text mt50 mlr10">
			<div class="flex-container1">
				<div>
					<a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">
						공개예정 프로젝트
					</a>
				</div>
					<a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="more-btn" >
						더 보러가기
					</a>
			</div>
		</div>

<div class="row flex-container3">
	<%for (ProjectDto projectDto : list3) {%>
	<div class="row flex-items2 m10">

		<div class="row">
		<% 	
			// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
			projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
						
			//사진이 있는지 판정
			boolean isExistPhoto = projectAttachDto != null;	
		%> 
			<a href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
			<%if(isExistPhoto){ %>
				<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo() %>" width="240px" height="200px">
			<%} else{ %>
				<img src="https://dummyimage.com/200x200" width="240px" height="200px">
			<%} %>
			</a>
		</div>
		
		<div class="flex-container2">
			<div class="left mt10" style="color:#B899CD">
				<span><%=projectDto.getProjectStartDate() %> 오픈예정</span>
			</div>
			<div class="left new-name">
				<a href="<%=request.getContextPath()%>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link"> 
					<span><%=projectDto.getProjectName()%></span>
				</a>
			</div>
		</div>
	</div>
	<%}%>
</div>




<jsp:include page="/template/footer.jsp"></jsp:include>