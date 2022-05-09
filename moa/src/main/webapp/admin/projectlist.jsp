<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

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
List<ProjectDto> list = projectDao.allSelectList(p, s);
%>



	<div class="row center m40 ">
		<h1>프로젝트 리스트</h1>
	</div>
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>판매자</th>
					<th>카테고리</th>
					<th >프로젝트명</th>
					<th>목표금액</th>
					<th>시작일</th>
					<th>승인여부</th>
				</tr>
			</thead>
			<tbody>
				<%
				SellerDao sellerDao = new SellerDao();
				for (ProjectDto projectDto : list) {
				SellerDto sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
				%>
				<tr>
					<td><%=sellerDto.getSellerNick() %></td>
					<td><%=projectDto.getProjectCategory() %></td>
					<td class="left">
					<a href="<%=request.getContextPath()%>/admin/project_detail.jsp?projectNo=<%=projectDto.getProjectNo() %>" class="link">
						<%=projectDto.getProjectName() %>
					</a></td>
					<td><%=projectDto.getProjectTargetMoney() %></td>
					<td><%=projectDto.getProjectStartDate() %></td>
					<td>
						<%if(projectDto.getProjectPermission() == 0){ %>
							<span style="color: red">승인필요</span>
						<%}else if(projectDto.getProjectPermission() == 1){ %>
							<span style="color: blue">승인완료</span>
<%-- 						<%}else{ %>
							거절 --%>
						<%} %>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>