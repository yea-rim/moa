<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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