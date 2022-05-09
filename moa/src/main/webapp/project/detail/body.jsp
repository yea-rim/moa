<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
%>
<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>

<div>
	<img src="https://via.placeholder.com/500x2000" width="100%">
</div>

<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>