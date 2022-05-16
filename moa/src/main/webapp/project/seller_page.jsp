<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션에 저장된 로그인 정보 가져오기
	Integer memberNo = (Integer) session.getAttribute("login");

	// 준비
	int sellerNo = Integer.parseInt(request.getParameter("sellerNo"));

	// 판매자 상세 조회
	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(sellerNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(sellerNo);
		
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null;
	
	ProjectDao projectDao = new ProjectDao();
	List<ProjectDto> list1 = projectDao.comingSelectList(sellerNo);
	List<ProjectDto> list2 = projectDao.ongoingSelectList(sellerNo);
	List<ProjectDto> list3 = projectDao.closingSelectList(sellerNo);
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();	
%>


<jsp:include page="/template/header.jsp"></jsp:include>
	
				<div class="container fill">
				
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        
                        	<!-- 프로필 사진 출력 -->
                            <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150" class="img img-circle">
                                    	
                                    <%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                             <%} else { // 존재하지 않는다면 %>
                                    <img src="https://dummyimage.com/200x200" alt="기본 프로필" width="200" class="img img-circle">
                             <%} %>
                        </div>
                        
                        <%if(sellerDto == null) {%>
                        <h1>존재하지 않는 판매자입니다.</h1>
                        <%} else { %>
                        <div class="float-left m20 mlr20">
                            <div class="row m10">
                            	<div class="float-container">
                            		<div class="float-left">
                            			<h4>(판매자번호) </h4>
                            		</div>
                            		<div class="float-left mlr10">
                            			<h3><%=sellerDto.getSellerNo() %></h3>
                            		</div>
                            	</div>
                            </div>
                            <div class="row">
                                <h2><%=sellerDto.getSellerNick() %></h2>
                            </div>
                        </div> 
                        <div class="float-right m60 mlr20">
                            <a href="" class="link link-reverse">
                                <h3 class="center">판매자 구독</h3>
                            </a>
                        </div>
                    </div>

                <div class="row m20">
<!-- 예정된 프로젝트 -->                        
				<hr style="border: solid lightgray 0.5px"/>
                <div class="row left mt50 mlr10">
                    <h2><a href="<%=request.getContextPath()%>/project/comingList.jsp" class="link">예정된 프로젝트</a></h2>
                <hr>
                </div>
                

                <div class="container">
            		<div class="flex-container3">
                
                <%for (ProjectDto projectDto : list1) {
					int projectNo = projectDto.getProjectNo();
					
					projectDto = projectDao.selectOne(projectNo);
					sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
					
					ProjectAttachDto projectAttachDto = projectAttachDao.selectOne(projectNo);
					boolean isExistFile = projectAttachDto != null;
					%> 
					
				<div class="list-card mlr30 m15">
		        	<!-- 이미지 자리 -->
		        	<%if(isExistFile) {%>
		            <div class="row center">
		                <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
<!-- 		                     <img src="https://dummyimage.com/150x112" alt="" class="card-image-wrapper" width="150px" height="112px"> -->
		                     <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img card-image-wrapper" width="150px" height="112px">
		                     
		                     </a></div>
		            <%} else { %>
		            <div class="row center">
		                <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
		                     <img src="https://dummyimage.com/150x112" alt="" class="card-image-wrapper" width="150px" height="112px"></a></div>
		            <%} %>
		                    
		             <!-- 제목 -->
		             <div class="row flex-title m10 mlr10 txt-overflow">
		                 <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>"class="link">
		                     <h2><%=projectDto.getProjectName() %></h2></a></div>
		
		             <!-- 판매자 -->
		             <div class="row m10 mlr10">
		                  <p><%=sellerDto.getSellerNick() %></p></div>
		
		             <!-- 카테고리 -->
		             <div class="row m30 mlr10">
		                  <p class="link-purple"><%=projectDto.getProjectCategory() %></p></div>
		             </div>
				<%} %>
 					</div>
			   </div>
<!-- 여기까지 예정된 프로젝트 -->


<!-- 진행 중인 프로젝트 -->                        
				<hr style="border: solid lightgray 0.5px"/>
                <div class="row left mt50 mlr10">
                    <h2><a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">진행 중인 프로젝트</a></h2>
                <hr>
                </div>
                
                <div class="container">
            		<div class="flex-container3">
                
                <%for (ProjectDto projectDto : list2) {
					int projectNo = projectDto.getProjectNo();
					
					projectDto = projectDao.selectOne(projectNo);
					sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
					
					ProjectAttachDto projectAttachDto = projectAttachDao.selectOne(projectNo);
					boolean isExistFile = projectAttachDto != null;
					%> 
					
				<div class="list-card mlr30 m15">
		        	<!-- 이미지 자리 -->
		        	<%if(isExistFile) {%>
		            <div class="row center">
		            <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img card-image-wrapper" width="150px" height="112px">
					</a></div>
		            <%} else { %>
		            <div class="row center">
		                <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
		                     <img src="https://dummyimage.com/150x112" alt="" class="card-image-wrapper" width="150px" height="112px"></a></div>
		            <%} %>
		                    
		             <!-- 제목 -->
		             <div class="row flex-title m10 mlr10 txt-overflow">
		                 <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>"class="link">
		                     <h2><%=projectDto.getProjectName() %></h2></a></div>
		
		             <!-- 판매자 -->
		             <div class="row m10 mlr10">
		                  <p><%=sellerDto.getSellerNick() %></p></div>
		
		             <!-- 카테고리 -->
		             <div class="row m30 mlr10">
		                  <p class="link-purple"><%=projectDto.getProjectCategory() %></p></div>
		             </div>
				<%} %>
 					</div>
			   </div>
<!-- 여기까지 진행 중인 프로젝트 -->


<!-- 마감된 프로젝트 -->                        
				<hr style="border: solid lightgray 0.5px"/>
                <div class="row left mt50 mlr10">
                    <h2><a href="<%=request.getContextPath()%>/project/closingList.jsp" class="link">마감된 프로젝트</a></h2>
                <hr>
                </div>
                
                <div class="container">
            		<div class="flex-container3">
                
                <%for (ProjectDto projectDto : list3) {
					int projectNo = projectDto.getProjectNo();
					
					projectDto = projectDao.selectOne(projectNo);
					sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
					
					ProjectAttachDto projectAttachDto = projectAttachDao.selectOne(projectNo);
					boolean isExistFile = projectAttachDto != null;
					%> 
					
				<div class="list-card mlr30 m15">
		        	<!-- 이미지 자리 -->
		        	<%if(isExistFile) {%>
		            <div class="row center">
		                <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
		            <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img card-image-wrapper" width="150px" height="112px">
					</a></div>
					<%} else { %>
		            <div class="row center">
		                <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
		                     <img src="https://dummyimage.com/150x112" alt="" class="card-image-wrapper" width="150px" height="112px"></a></div>
		            <%} %>
		                    
		             <!-- 제목 -->
		             <div class="row flex-title m10 mlr10 txt-overflow">
		                 <a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>"class="link">
		                     <h2><%=projectDto.getProjectName() %></h2></a></div>
		
		             <!-- 판매자 -->
		             <div class="row m10 mlr10">
		                  <p><%=sellerDto.getSellerNick() %></p></div>
		
		             <!-- 카테고리 -->
		             <div class="row m30 mlr10">
		                  <p class="link-purple"><%=projectDto.getProjectCategory() %></p></div>
		             </div>
				<%} %>
 					</div>
			   </div>
<!-- 여기까지 마감된 프로젝트 -->
				
      
 

             <%} %>
             </div>
             </div>
		
<jsp:include page="/template/footer.jsp"></jsp:include>