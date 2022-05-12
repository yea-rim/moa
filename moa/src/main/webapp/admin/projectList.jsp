<%@page import="java.text.DecimalFormat"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//페이징 관련 파라미터들을 수신
	String sort = request.getParameter("sort");
	if (sort == null) {
		sort = "최신순";
	}
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
%>


<%
	ProjectDao projectDao = new ProjectDao();
	List<ProjectDto> list = projectDao.allSelectList(p, s, sort);
	DecimalFormat f = new DecimalFormat("#,###.#");
%>

<style>
.table.table-a > thead > tr ,
.table.table-a > tbody > tr
{
    border-bottom: 1px solid black;
}
</style>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<script type="text/javascript">
    $(function () {
      $(".sort").change(function () {
    	  this.form.submit();
      });
	});
</script>



	<div class="row center m20 ">
		<h1>프로젝트 리스트</h1>
	</div>
	<div class="row right m20">
		<form action="projectList.jsp" method="get">
			<select name="sort" class="sort">
				<option>선택</option>
				<option>승인여부</option>
				<option>최신순</option>
				<option>시작일임박순</option>
				<option>펀딩액순</option>
			</select> 
		</form>
	</div>
	<div class="row">
		<table class="table table-a table-stripe table-hover">
			<thead>
				<tr>
					<th width="17%">판매자</th>
					<th width="10%">카테고리</th>
					<th >프로젝트명</th>
					<th>목표금액</th>
					<th width="11%">시작일</th>
					<th width="9%">승인여부</th>
				</tr>
			</thead>
			<tbody>
				<%
				SellerDao sellerDao = new SellerDao();
				for (ProjectDto projectDto : list) {
				SellerDto sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
				%>
				<tr onclick="location.href='<%=request.getContextPath()%>/admin/project_detail.jsp?projectNo=<%=projectDto.getProjectNo() %>';" style="width:100%;cursor:pointer;">
					<td><%=sellerDto.getSellerNick() %></td>
					<td><%=projectDto.getProjectCategory() %></td>
					<td class="left" ><%=projectDto.getProjectName() %></td>
					<td><%=f.format(projectDto.getProjectTargetMoney()) %></td>
					<td><%=projectDto.getProjectStartDate() %></td>
					<td>
						<%if(projectDto.getProjectPermission()==0){ %>
							<span style="color: red">승인필요</span>
						<%}else if(projectDto.getProjectPermission()==1){ %>
							<span style="color: blue">승인완료</span>
 						<%}else{ %>
							거절 
						<%} %>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>


<!--페이지네이션 -->
<%
int count = projectDao.adminCountByPaging();
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

<div class="pagination cente m40">
		<!-- 이전 버튼 영역 -->
		<%if (p > 1) { // 첫페이지가 아니라면 %>
		<a href="projectList.jsp?p=1&s=<%=s%>&sort=<%=sort%>">&laquo;</a>
		<%}%>

		<%
		if (startBlock > 1) { // 이전 블록이 있으면
		%>
		<a href="projectList.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
		<%}%>


		<!-- 숫자 링크 영역 -->
		<%for (int i = startBlock; i <= endBlock; i++) {%>
		<%if (i == p) {%>
		<a class="active"
			href="projectList.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>
		<%} else {%>
		<a href="projectList.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>
		<%}%>
		<%}%>

		<!-- 다음 버튼 영역 -->
		<%if (endBlock < lastPage) {%>
		<a href="projectList.jsp?p=<%=endBlock + 1%>&s=<%=s%>&sort=<%=sort%>">&gt;</a>
		<%}%>

		<%
		if (p < lastPage) { // 마지막 페이지가 아니라면
		%>
		<a href="projectList.jsp?p=<%=lastPage%>&s=<%=s%>&sort=<%=sort%>">&raquo;</a>
		<%}%>
</div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include> 