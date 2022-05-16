<%@page import="moa.beans.BannerDto"%>
<%@page import="moa.beans.BannerDao"%>
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

// 기간에 해당되는 배너 4개만
BannerDao bannerDao = new BannerDao();
List<BannerDto> banner = bannerDao.selectBanner();
%>
<!-- 스와이퍼 -->
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainIndex.css">
    
<style>

</style>

<!-- 스와이퍼 -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/swiper.js"></script>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row flex-container1 flex-items2 modu">
	
	<div class="flex-items1 flex-container2">
	
	  <div class="flex-container">
			<div class="swiper">
				<div class="swiper-wrapper">
					
					<%if(banner.size() > 0){ %>
						<%for(BannerDto bannerDto : banner) { %>
						    <div class="swiper-slide">
						    	<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=bannerDto.getProjectNo() %>">
					           		<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=bannerDto.getAttachNo() %>" width="660px" height="400px" onerror="javascript:this.src='https://dummyimage.com/200x200'">
					           	</a>
				            </div>
						<%} %>
			           	<%}else{ %>
			            	<div class="swiper-slide">
			            		<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=">
				                    <img src="https://via.placeholder.com/500x300" width="660px" height="400px">
			                    </a>
				            </div>
				        <%} %>
				        
				</div>
				
				<div class="swiper-pagination"></div>
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
			</div>
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
			<div class="flex-container2">
				<% 	
					// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
					projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
								
					//사진이 있는지 판정
					boolean isExistPhoto = projectAttachDto != null;	
				%> 
					<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
					<%if(isExistPhoto){ %>
						<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo() %>" width="200px" height="170px">
					<%} else{ %>
						<img src="https://dummyimage.com/200x200" width="200px" height="170px">
					<%} %>
					</a>
			
			<% 
				projectVo = projectDao.selectVo(projectDto.getProjectNo());
				sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
			%>
			
				<div class="row category left mt10">
					<%=projectDto.getProjectCategory() %> | <%=sellerDto.getSellerNick() %> 
				</div>
		
				<div class="row left new-name m10">
					<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link"> 
						<%=projectDto.getProjectName()%>
					</a>
				</div>
				<div class="row left percent">
					<%=projectVo.getPercent() %> %
				</div>
			</div>
			
			
			</div>
			<%}%>
		</div>
		<div class="center mt30">
			<a href="<%=request.getContextPath() %>/project/ongoingList.jsp" class="more-btn">전체 보러가기</a>
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
							<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link"> 
								<%=projectDto.getProjectName()%>
							</a>
						</div>

						<%
						projectVo = projectDao.selectVo(projectDto.getProjectNo());
						sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
						%>
							<div class="row seller">
								<%=sellerDto.getSellerNick()%>
							</div>
							<div class="left percent">
								<span><%=projectVo.getPercent() %>%</span>
							</div>
					</div>

					<div class="row flex-items-c m10 right img-hover">
					<% 	
						// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
						projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
						
				 		//사진이 있는지 판정
				 		boolean isExistPhoto = projectAttachDto != null;	
				 	%> 
						<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
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
					<a href="<%=request.getContextPath()%>/project/comingList.jsp" class="link">
						공개예정 프로젝트
					</a>
				</div>
					<a href="<%=request.getContextPath()%>/project/comingList.jsp" class="more-btn" >
						더 보러가기
					</a>
			</div>
		</div>

	<div class="row flex-container3">
		<%for (ProjectDto projectDto : list3) {%>
		<div class="row flex-items2 m10">
	
			<% 	
				// 프로젝트에 프로필 하나의 attachNo만 정보만 가져옴
				projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
							
				//사진이 있는지 판정
				boolean isExistPhoto = projectAttachDto != null;	
			%> 
			<div class="img-hover">
				<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>">
				<%if(isExistPhoto){ %>
					<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo() %>" width="230px" height="200px" style="border-radius: 10%;">
				<%} else{ %>
					<img src="https://dummyimage.com/200x200" width="230px" height="200px" style="border-radius: 10%;">
				<%} %>
				</a>
			</div>
			
			<div class="flex-container2">
				<div class="left mt10" style="color:#B899CD">
					<span><%=projectDto.getProjectStartDate() %> 오픈예정</span>
				</div>
				</div>
	
			<div class="row m10 left new-name">
				<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo()%>" class="link"> 
					<span><%=projectDto.getProjectName()%></span>
				</a>
			</div>
		</div>
		<%}%>
	</div>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>