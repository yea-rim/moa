<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	//회원번호 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberNo);
	
	int sellerNo = sellerDto.getSellerNo();
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
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
	
	ProjectDao projectDao = new ProjectDao();
	
	List<ProjectDto> list = projectDao.getFailList(p, s, sellerNo);
%>

<jsp:include page = "/template/header.jsp"></jsp:include>

	<div class="flex-container mt40">
		 <!-- 마이페이지 메인으로 이동 -->
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/seller/my_page.jsp">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="<%=request.getContextPath() %>/seller/my_page.jsp" class="link mlr5">
                     <h2>미달성한 프로젝트</h2>
              </a>
	</div>
	
	<div class="row m30"><hr></div>
                
                
					<%for(ProjectDto projectDto : list) { 
						
						ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo()); 
						
						boolean isExistProjectAttach = projectAttachDto != null;
					%>
						<div class="container mt20 p10">
	
	                    <div class="float-container b-purple">
	            
	                        <!-- 프로젝트 대표 이미지 -->
	                        <div class="float-left m20 mlr20">
	                        	<%if(isExistProjectAttach) { // 사진이 존재하면 %>
										 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="130px">
								<%} else { // 사진이 없으면 %>
										 <img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="130px">
								<%} %>	                        
	                        </div>
	            
	                        <div class="float-left m20 mlr20 h150">
	                            
	                            <!-- 프로젝트 제목 -->
	                            <div class="row w800">
	                                <h3>
	                                    <%=projectDto.getProjectName() %>
	                                </h3>
	                            </div>
	                            
	                            <!-- 프로젝트 요약 -->
	                            <div class="row w800 mt30">
	                                <p class="link-gray">
	                                    <%=projectDto.getProjectSummary() %>
	                                </p>
	                            </div>
	                            
	                        </div>
	                        
	                        <!-- 상세보기 -->
					        <div class="float-right m70 mlr20">
					          	<div class="row mt5">
					          		<a href="fail_project_detail.jsp?projectNo=<%=projectDto.getProjectNo() %>" class="link link-reverse w100 center">상세보기</a>
					          	</div>
					        </div>
	                        
	                    </div>
	                </div>
				<%} %>
                
	<div class="container">
		<!-- 페이지네이션 -->
		<%
		int count = projectDao.countFailByPaging(sellerNo);

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
					<a href="my_fail_project.jsp?p=1&s=<%=s%>">&laquo;</a>
				<%}%>

				<%
				if (startBlock > 1) { // 이전 블록이 있으면
				%>
					<a href="my_fail_project.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
				<%}%>


				<!-- 숫자 링크 영역 -->
				<%for (int i = startBlock; i <= endBlock; i++) {%>
					<%if (i == p) {%>
						<a class="active" href="my_fail_project.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} else {%>
						<a href="my_fail_project.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} %>
				<%}%>

				<!-- 다음 버튼 영역 -->
				<%if (endBlock < lastPage) {%>
					<a href="my_fail_project.jsp?p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
				<%}%>

				<%
				if (p < lastPage) { // 마지막 페이지가 아니라면
				%>
					<a href="my_fail_project.jsp?p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
				<%}%>
			</div>
			
		</h4>
	</div>
	
<jsp:include page = "/template/footer.jsp"></jsp:include>