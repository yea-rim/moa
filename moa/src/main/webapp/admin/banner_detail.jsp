<%@page import="java.sql.Date"%>
<%@page import="moa.beans.BannerDto"%>
<%@page import="moa.beans.BannerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int attachNo = Integer.parseInt(request.getParameter("attachNo"));
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	BannerDao bannerDao = new BannerDao();
	BannerDto bannerDto = bannerDao.selectOne(projectNo);
	Date BannerFinishDate = bannerDao.getBannerFinishDate(projectNo);
	
%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<div class="container w700">
	<div class="row center mb40">
		<h1 class="m5">배너 이미지 관리</h1>
	</div>
	<div class="row right">
	<a href="<%=request.getContextPath()%>/project/project_detail.jsp?projectNo=<%=projectNo%>" class="link" style="font-weight: bold;">
		이 프로젝트 보러가기 >
	</a>
	</div>
	<div class="row center mb40">
		<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=attachNo %>" width="660px" height="400px" onerror="javascript:this.src='https://dummyimage.com/200x200'">
	</div>
	<div class="row center m20">
			<%if(bannerDto.getBannerPermission()==0){ %>
			<a href="<%=request.getContextPath()%>/admin/banner_permit.do?projectNo=<%=projectNo%>">
				<button class="btn w100p"> 배너 승인</button>
			</a>	
			<%}else if(bannerDto.getBannerStartDate() == null){ %>
			<a href="<%=request.getContextPath()%>/admin/banner_regist.do?projectNo=<%=projectNo%>">
				<button class="btn w100p"> 배너 등록</button>
			</a>		
			<%}else{ %>
				<h2 style="color:#B899CD; "> [ 배너 등록 중 ] </h2><br>
				<h2>기간 : <%=bannerDto.getBannerStartDate() %> ~ <%=BannerFinishDate%></h2>
			<%} %>			
	</div>
</div>
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>