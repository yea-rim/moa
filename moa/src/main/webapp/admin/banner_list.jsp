<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.BannerDto"%>
<%@page import="moa.beans.BannerDao"%>
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
%>
<%
	BannerDao bannerDao = new BannerDao();
	List<BannerDto> list = bannerDao.selectList(p, s);
	
	SimpleDateFormat f = new SimpleDateFormat("MM/dd");
%>

<div class="container w950"> 
	<div class="row mt30">
		<h2>배너 신청 리스트</h2>
	</div>
	<hr>
	<div class="row mt20">
		<table class="table table-admin table-stripe">
			<thead>
				<tr>
					<th>판매자</th>
					<th>프로젝트명</th>
					<th>신청일수</th>
					<th>승인여부</th>
					<th>등록여부</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (BannerDto bannerDto : list) {
					//프로젝트명
					ProjectDao projectDao = new ProjectDao();
					ProjectDto projectDto = projectDao.selectOne(bannerDto.getProjectNo());
					
					//판매자
					SellerDao sellerDao = new SellerDao();
					SellerDto sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());	
					
					//배너 마감일
					Date bannerFinishDate = bannerDao.getBannerFinishDate(projectDto.getProjectNo());
				%>
				<tr onclick="location.href='<%=request.getContextPath()%>/admin/banner_detail.jsp?attachNo=<%=bannerDto.getAttachNo() %>&projectNo=<%=bannerDto.getProjectNo() %>';" style="width:100%;cursor:pointer;">
					<td><%=sellerDto.getSellerNick()%></td>
					<td class="left"><%=projectDto.getProjectName() %></td>
					<td><%=bannerDto.getBannerTerm() %>일</td>
					<td>
						<%if(bannerDto.getBannerPermission() ==0){ %>
							<span style="color: red">승인대기</span>
						<%}else{ %>
							<span style="color: blue">승인완료</span>
						<%} %>
					</td>
					<td>
						<%if(bannerDto.getBannerPermission()==1 && bannerDto.getBannerStartDate() == null){ %>
							<span >대기중</span>
						<%}else{ %>
							<span>등록중</span><br>
							<span>(<%=f.format(bannerDto.getBannerStartDate()) %>~<%=f.format(bannerFinishDate )%>)</span>
						<%} %>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
<!--페이지네이션 -->
<%
int count = bannerDao.CountByPaging();
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
<div class="pagination center m40">
		<!-- 이전 버튼 영역 -->
		<%if (p > 1) { // 첫페이지가 아니라면 %>
		<a href="question_list.jsp?p=1&s=<%=s%>">&laquo;</a>
		<%}%>

		<%
		if (startBlock > 1) { // 이전 블록이 있으면
		%>
		<a href="question_list.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
		<%}%>


		<!-- 숫자 링크 영역 -->
		<%for (int i = startBlock; i <= endBlock; i++) {%>
		<%if (i == p) {%>
		<a class="active"
			href="question_list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
		<%} else {%>
		<a href="question_list.jsp?p=<%=i%>&s=<%=s%>"><%=i%></a>
		<%}%>
		<%}%>

		<!-- 다음 버튼 영역 -->
		<%if (endBlock < lastPage) {%>
		<a href="question_list.jsp?p=<%=endBlock + 1%>&s=<%=s%>">&gt;</a>
		<%}%>

		<%
		if (p < lastPage) { // 마지막 페이지가 아니라면
		%>
		<a href="question_list.jsp?p=<%=lastPage%>&s=<%=s%>">&raquo;</a>
		<%}%>
</div>
</div>
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>