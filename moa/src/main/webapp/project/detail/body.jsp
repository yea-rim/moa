<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectAttachDao"%>
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
%>
<!-- 첨부파일관련 -->
<%

	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
	List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);
	
	boolean isDetail = detailList.size() > 0;
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
            <a href="<%=request.getContextPath() %>/project/detail/body.jsp?projectNo=<%=projectNo%>" class="link"><span style="font-weight:bold;">펀딩소개</span></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=request.getContextPath() %>/project/detail/notice.jsp?projectNo=<%=projectNo%>" class="link"><span>공지</span></a>
        </div>
		<hr>

        <div class="float-container center">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container mt30">
<div>
	<%if(isDetail){ %>
		<%for(ProjectAttachDto projectAttachDto : detailList){ %>
			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>">
		<%} %>
	<%}else{ %>
    	<img src="https://via.placeholder.com/720x2000" width="100%">
    <%} %>
</div>

<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>