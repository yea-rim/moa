<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.FundingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	// 세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	boolean isLogin = memberNo != null;
	
	// 세션에서 admin 정보 꺼내기
	Integer admin = (Integer) session.getAttribute("admin");
	// adminId 데이터 여부 판단 -> 관리자 권한 판단
	boolean isAdmin = admin !=null;
	
	// 판매자 세션 가져오기
	Integer seller = (Integer) session.getAttribute("seller");
	boolean isSeller = seller !=null;

%>

<%
	FundingDao fundingDao = new FundingDao();
	ProjectDao projectDao = new ProjectDao();
	
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
	
	List<FundingDto> list = fundingDao.selectCancelList(p, s, memberNo);
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
%>

<jsp:include page="/template/header.jsp"></jsp:include>


	<div class="container fill m40">
					<div class="flex-container m20">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="my_page.jsp" class="link mlr5">
                                <h2>후원 프로젝트</h2>
                            </a>
                   	</div>
				
					<div class="row m30"><hr></div>
	</div>

	<div class="container mt30">
                    <div class="float-container">
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_wait_list.jsp" class="link link-reverse fill center">후원 대기</a>
                        </div>
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_finish_list.jsp" class="link link-reverse fill center">후원 완료</a>
                        </div>
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_cancel_list.jsp" class="link link-btn fill center">후원 취소</a>
                        </div>
                </div>


    <%for(FundingDto fundingDto : list){ %>
    <%
    	System.out.println(fundingDto.getFundingNo());
    	
    	ProjectDto projectDto = projectDao.selectSuccessMyFunding(fundingDto.getFundingNo(), memberNo); 
		
	    ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectDto.getProjectNo());
		
		boolean isExistProjectAttach = projectAttachDto != null;
    %>
    <div class="container mt20">
		
        <div class="float-container b-purple">

            <div class="float-left layer-5 m20 mlr20">
            					<%if(isExistProjectAttach) { // 사진이 존재하면 %>
										 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="img img-round" width="150px" height="130px">
								<%} else { // 사진이 없으면 %>
										 <img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="img img-round" width="150px" height="130px">
								<%} %>
            </div>

            <div class="float-left layer-2 m20 mlr50">
                <div class="row">
                    <h2 class="mt10">
                        <a href="funding_cancel_info.jsp?projectNo=<%=projectDto.getProjectNo() %>&fundingNo=<%=fundingDto.getFundingNo() %>" class="link"><%=projectDto.getProjectName() %></a>
                    </h2>
                </div>
	            <div class="row w800 mt30">
	                 <p class="link-gray">
	                       <%=projectDto.getProjectCategory()%>
	                 </p>
	             </div>
            </div>
            

        
    </div>
    <%} %>
    
    <div class="container">
		<!-- 페이지네이션 -->
		<%
		int count = fundingDao.countWaitList(memberNo);

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
			<div class="pagination center mt20">
				<%
				if (p > 1) { // 첫페이지가 아니라면
				%>
					<a href="funding_cancel_list.jsp?p=1&s=<%=s%>">&laquo;</a>
				<%}%>

				<%
				if (startBlock > 1) { // 이전 블록이 있으면
				%>
					<a href="funding_cancel_list.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
				<%}%>


				<!-- 숫자 링크 영역 -->
				<%for (int i = startBlock; i <= endBlock; i++) {%>
					<%if (i == p) {%>
						<a class="active" href="funding_cancel_list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} else {%>
						<a href="funding_cancel_list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
					<%} %>
				<%}%>

				<!-- 다음 버튼 영역 -->
				<%if (endBlock < lastPage) {%>
					<a href="funding_cancel_list.jsp?p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
				<%}%>

				<%
				if (p < lastPage) { // 마지막 페이지가 아니라면
				%>
					<a href="funding_cancel_list.jsp?p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
				<%}%>
			</div>
			
		</h4>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>