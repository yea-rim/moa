<%@page import="moa.beans.BannerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int attachNo = Integer.parseInt(request.getParameter("attachNo"));
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<div class="container w900">
	<div class="row center mb40">
		<h1 class="m5">배너 이미지 관리</h1>
	</div>
	<div class="row center m40">
		<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=attachNo %>" width="660px" height="400px" onerror="javascript:this.src='https://dummyimage.com/200x200'">
	</div>
	<div class="row center m20">
			<a href="<%=request.getContextPath()%>/admin/banner_permit.jsp?projectNo=<%=projectNo%>">
				<button class="btn w70p"> 배너 승인</button>
			</a>		
	</div>
</div>
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>