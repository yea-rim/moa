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
%>
<style>
.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
}
.flex-container2 {
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: center;
}
.flex-items1 {
	flex-basis: 20%;
	padding: 10px;
}

.flex-items2 {
	flex-basis: 50%;
	padding: 10px;
}

.flex-items-a{
	flex-basis: 80%;
}
.flex-items-b{
	flex-basis: 20%;
}
.project-name {
	font-size: 25px;
	padding: 10px;
}
.percent{
	color: #B899CD;
	font-size: 15px;
	padding: 10px;
}
.seller{
	font-size: 15px;
	padding: 0px 10px;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>

				<div class="row fill">
                    <img src="https://dummyimage.com/1305x250" alt="" class="fill">
                </div>
                
				<%-- 인기프로젝트 목록 --%>
				<div class="row flex-container1">
	                <div class="row left big-text mt50 mlr10 flex-items2">
    	                <a href="<%=request.getContextPath()%>/project/ongoingList.jsp?sort=인기순" class="link">인기 프로젝트</a>
    	                <hr style="border: solid lightgray 0.5px" />
    	                
    	                <div class="row flex-container2">
    	                <%for(ProjectDto projectDto : list1){ %>
    	                <div class="container fill" style="border-bottom:0.5px solid black">
    	               		<div class="row flex-container1">
    	                	<div class="row flex-container2 flex-items-a">
	    	                	<div class="row project-name m10">
	    	                		<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo() %>" class="link">
	    	                			<%=projectDto.getProjectName() %>
	    	                		</a>
	    	                	</div>
	    	                	
	    	                	<%
	    	                		ProjectVo projectVo = projectDao.selectVo(projectDto.getProjectNo()); 
	    	                		SellerDao sellerDao = new SellerDao();
	    	                  		SellerDto sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
	    	                	%>
	    	                	<div class="row seller"><%=sellerDto.getSellerNick() %></div>
	    	                	<div class="row percent"><%=projectVo.getPercent() %> % </div>
	    	                </div>
    	                		
    	                		<div class="row flex-items-b m10">
    	                			<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo() %>">
	    	                			<img src="https://dummyimage.com/100x100" width="100%">
	    	                		</a>
	    	                	</div>
	    	                </div> 
	    	               </div>
    	                <%} %>
    	                
    	                </div>
        	        </div>
        	        
        	        <%-- 공지사항 --%>
	                <div class="row left big-text mt50 mlr10 flex-items1">
    	                <a href="<%=request.getContextPath() %>/notice/list.jsp" class="link">공지사항</a>
    	             
        	        </div>
				</div>
				
				<%-- 신규프로젝트 목록 --%>
				 <hr style="border: solid lightgray 0.5px" />
                <div class="row left big-text mt50 mlr10">
                    <a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">신규 프로젝트</a>
                </div>
                
				<div class="row flex-container1">
				<%for(ProjectDto projectDto : list2){ %>
					<div class="row flex-items1 m10">
						<div class="row">
							<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo() %>"><img src="https://dummyimage.com/200x200" width="100%"></a>
						</div>
						<div class="row left m10">
							<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectDto.getProjectNo() %>" class="link">
								<span><%=projectDto.getProjectName() %></span>
							</a>
						</div>
					</div>
				<%} %>
				</div>
				
<jsp:include page="/template/footer.jsp"></jsp:include>