<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.ProgressAttachDto"%>
<%@page import="moa.beans.ProgressAttachDao"%>
<%@page import="moa.beans.PjProgressDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.PjProgressDao"%>
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
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);
%>    
<%	
	int progressNo = Integer.parseInt(request.getParameter("progressNo"));
	PjProgressDao pjProgressDao = new PjProgressDao();
	
	/* 파라미터 나중에 바꿔주기!!!!!!!!!!!!!!!!!!!!!!!! */
	
	PjProgressDto pjProgressDto = pjProgressDao.selectOne(progressNo);
	
	ProgressAttachDao progressAttachDao = new ProgressAttachDao();
	ProgressAttachDto progressAttachDto = progressAttachDao.selectOne(progressNo);
	
	boolean isProgressAttach = progressAttachDto != null;
%>
    
<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>

<script type="text/javascript">
	//시작하면 바로 이동
	$(function(){
    	var offset = $("#start-anc").offset(); //해당 위치 반환
    	$("html, body").animate({scrollTop: offset.top},0);
	});

</script>

<!-- 상세페이지 / 커뮤니티 메뉴바 -->
        <div class="row left h20 mt40" id="start-anc">
            <a href="<%=request.getContextPath() %>/project/detail/body.jsp?projectNo=<%=projectNo%>" class="link"><span>펀딩소개</span></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=request.getContextPath() %>/project/detail/notice.jsp?projectNo=<%=projectNo%>" class="link"><span style="font-weight:bold;">공지</span></a>
        </div>
		<hr>

        <div class="float-container center">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container mt30">
<!-- 공지 부분 -->
<div>
                    <div class="row left m-b10">
                        <div class="row">
                            작성자
                        </div>
                        <div class="row m10 font12"">
                            <%=pjProgressDto.getProgressTime() %> 공지사항
                        </div>
                    </div>
                    <div class="row left m10">
                        <h1>
                        	<%=pjProgressDto.getProgressTitle() %>
                        </h1>
                    </div>
                    <%if(isProgressAttach) {%>
                    <div>
                    	<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=progressAttachDao.selectAttachNo(progressNo)%>" width="100%" height="100%">
                    </div>
                    <%}%>
                    <div class="row">
<pre class="pre"><%=pjProgressDto.getProgressContent() %></pre>
                    </div>
                    <%if(isSeller && memberNo == projectDto.getProjectSellerNo()) {%>
                    <div class="row right mt100">
                    	<a href="<%=request.getContextPath()%>/seller/pj_progress_edit.jsp?progressNo=" + <%=progressNo %>><button class="btn">수정</button></a>
                    	<a href="<%=request.getContextPath()%>/seller/pj_progress_delete.do?progressNo=" + <%=progressNo %>><button class="btn btn-reverse">삭제</button></a>
                    </div>
                    <%} %>
                    
                </div>
<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>