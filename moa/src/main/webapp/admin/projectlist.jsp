<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
//페이징 관련 파라미터들을 수신
int p;
try { //정상적인 숫자가 들어온 경우 - 0이하인 경우 --> Plan A
	p = Integer.parseInt(request.getParameter("p"));
	if (p <= 0) {
		throw new Exception();
	}
} catch (Exception e) {//p가 없거나 숫자가 아닌 경우+0이하인 경우 --> plan B
	p = 1;
}

int s;
try {
	s = Integer.parseInt(request.getParameter("s"));
	if (s <= 0) {
		throw new Exception();
	}
} catch (Exception e) {
	s = 20;
}

ProjectDao projectDao = new ProjectDao();
List<ProjectDto> list = projectDao.approveSelectList(p, s);
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container w800">
	<div class="row center m40">
		<h1>프로젝트 승인 리스트</h1>
	</div>
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>판매자</th>
					<th>카테고리</th>
					<th >프로젝트명</th>
					<th>목표금액</th>
					<th>승인여부</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (ProjectDto projectDto : list) {
					
				%>
				<tr>
					<td><%=projectDto.getProjectSellerNo() %></td>
					<td><%=projectDto.getProjectCategory() %></td>
					<td class="left"><%=projectDto.getProjectName() %></td>
					<td><%=projectDto.getProjectTargetMoney() %></td>
<%-- 					<%if(projectDto.getProjectPermission().equals(0)){ %>
					<td>승인필요</td>
					<%} %> --%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>