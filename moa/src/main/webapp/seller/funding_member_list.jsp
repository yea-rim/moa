<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.FundingDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);

	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo()); 
	
	boolean isExistProjectAttach = projectAttachDto != null;
	
	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	
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

	 
		// 해당 프로젝트와 관련된 정보들 가져오기 
		FundingDao fundingDao = new FundingDao();
		List<FundingDto> list = fundingDao.selectFundingNo(p, s, projectNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>


			<div class="flex-container mt40">
		             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
		             <a href="<%=request.getContextPath() %>/seller/my_ongoing_project.jsp">
		                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		             </a>
		             <a href="<%=request.getContextPath() %>/seller/my_ongoing_project.jsp" class="link mlr5">
		                     <h2>돌아가기</h2>
		              </a>
			</div>

			<div class="flex-container m50">
                    <div class="left-wrapper layer-5">
                       			<%if(isExistProjectAttach) { // 사진이 존재하면 %>
										 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="130px">
								<%} else { // 사진이 없으면 %>
										 <img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="130px">
								<%} %>
                    </div>
                    <div class="left-wrapper layer-3">
                        <div class="row">
                            <h2 class="m10 left"><%=projectDto.getProjectName()%></h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left"><%=projectDto.getProjectCategory() %></h4>
                        </div>
                    </div>
                    <div class="right-wrapper layer-4 left  mlr40 ">
                        <div class="row mt10 m10">
                            <h3>모인 금액</h3>
                        </div>
                        <div class="row m10">
                            <p><%=projectVo.getPresentMoney() %>원</p>
                        </div>
                        <div class="row mt20 m10">
                            <h3>남은 기간</h3>
                        </div>
                        <div class="row m10">
                            <p><%=projectVo.getDaycount() %>일</p>
                        </div>
                        <div class="row mt20 m10">
                            <h3>후원자 수</h3>
                        </div>
                        <div class="row m10">
                            <p><%=projectVo.getSponsor() %>명</p>
                        </div>
                    </div>
                </div>

                <hr>


                <div class="container m50">

                    <table class="table table-admin table-stripe table-hover">
                        <thead>
                            <tr>
                                <th>펀딩 번호</th>
                                <th>후원자 닉네임</th>
                                <th>펀딩 날짜</th>
                                <th>기타</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for(FundingDto fundingDto : list) { 
                            	
                            		
                            		MemberDao memberDao = new MemberDao();
                            		MemberDto memberDto = memberDao.selectOne(fundingDto.getFundingMemberNo());
                            		
                            		FundingDto nowFundingDto = fundingDao.selectOne(fundingDto.getFundingNo(), memberDto.getMemberNo());
                            %>
                            	<tr>
	                                <td><%=nowFundingDto.getFundingNo() %></td>
	                                <td><%=memberDto.getMemberNick() %></td>
	                                <td><%=nowFundingDto.getFundingDate() %></td>
	                                <td><a href="funding_member_detail.jsp?memberNo=<%=memberDto.getMemberNo() %>&projectNo=<%=projectNo %>&fundingNo=<%=fundingDto.getFundingNo()%>" class="link link-purple">상세보기</a></td>
                            	</tr>
                            <%} %>
                        </tbody>
                    </table>

                </div>
                
                <%
				int count = fundingDao.countByPaging(projectNo);
				
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
			<div class="pagination center">
				<%
				if (p > 1) { // 첫페이지가 아니라면
				%>
					<a href="funding_member_list.jsp?projectNo=<%=projectNo %>&p=1&s=<%=s%>">&laquo;</a>
				<%}%>

				<%
				if (startBlock > 1) { // 이전 블록이 있으면
				%>
					<a href="funding_member_list.jsp?projectNo=<%=projectNo %>&p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
				<%}%>


				<!-- 숫자 링크 영역 -->
				<%for (int i = startBlock; i <= endBlock; i++) {%>
					<%if (i == p) {%>
						<a class="active" href="funding_member_list.jsp?projectNo=<%=projectNo %>&p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} else {%>
						<a href="funding_member_list.jsp?projectNo=<%=projectNo %>&p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} %>
				<%}%>

				<!-- 다음 버튼 영역 -->
				<%if (endBlock < lastPage) {%>
					<a href="funding_member_list.jsp?projectNo=<%=projectNo %>&p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
				<%}%>

				<%
				if (p < lastPage) { // 마지막 페이지가 아니라면
				%>
					<a href= "funding_member_list.jsp?projectNo=<%=projectNo %>&p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
				<%}%>
			</div>
			
		</h4>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>