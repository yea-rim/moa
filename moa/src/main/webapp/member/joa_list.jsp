<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.JoaDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.JoaDao"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션에 저장된 로그인 정보 가져오기
	Integer memberNo = (Integer) session.getAttribute("login");

	
	// 관심 프로젝트 조회
	JoaDao joaDao = new JoaDao();
	List<JoaDto> list = joaDao.selectList(memberNo);
	
	// 프로젝트 Dao 준비 
	ProjectDao projectDao = new ProjectDao();
	
	
	// 프로젝트 Attach Dao 준비 
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
                                <h2>관심 프로젝트</h2>
                            </a>
                   	</div>
				
					<div class="row m30"><hr></div>
	</div>
	
	
		<%for(JoaDto joaDto : list) {
            		int projectNo = joaDto.getProjectNo();
            					
					ProjectDto projectDto = projectDao.selectOne(projectNo);
					// int profileNo = projectAttachDao.getAttachNo(projectNo); 
								
					// projectAttach로 대표 이미지 가져오기 실패 %> 
		<div class="container mt20">

        <div class="float-container b-purple">

			<!-- 프로젝트 대표 이미지 -->
            <div class="float-left m20 mlr20">
                <img src="https://dummyimage.com/150x150" alt="">
            </div>

            <div class="float-left m20 mlr20 h150">
            	
            	<!-- 프로젝트 제목 -->
                <div class="row w300 txt-overflow2">
                    <h3>
                        <a href="" class="link"><%=projectDto.getProjectName() %></a>
                    </h3>
                </div>
                
                <!-- 프로젝트 요약 -->
                <div class="row w300 txt-overflow3 mt30">
                    <p>
                        <a href="" class="link link-gray"><%=projectDto.getProjectSummary() %></a>
                    </p>
                </div>
            </div>
            
            <!-- 관심 프로젝트 취소 -->
            <div class="float-right m70 mlr20">
            	<form action="<%=request.getContextPath()%>/project/joa_delete.do" method="post">
            		<input type="hidden" name="memberNo" value="<%=memberNo%>">
            		<input type="hidden" name="projectNo" value="<%=projectDto.getProjectNo()%>">
            		<button class="btn-reverse link-purple">
            			좋아요 취소
            		</button>
            	</form>
            </div>
        </div>
        
        <%} %>

    </div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>