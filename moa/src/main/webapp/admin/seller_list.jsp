<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//페이징 관련 파라미터들을 수신
	int p;
	try {//정상적인 숫자가 들어온 경우 - 0이하인 경우 --> Plan A
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0)	throw new Exception();
	}
	catch(Exception e){//p가 없거나 숫자가 아닌 경우 + 0이하인 경우 --> Plan B
		p = 1;
	}
	
	int s;
	try {
		s = Integer.parseInt(request.getParameter("s"));
		if(s <= 0) throw new Exception();
	}
	catch(Exception e){
		s = 20;
	}
%>

<%
	SellerDao sellerDao = new SellerDao();
	List<SellerDto> list = sellerDao.selectSellerAll(p,s);
%>

<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

	<div class="container w900">
	
		<div class="row mt30">
			<h2>판매자 목록</h2>
		</div>
		<hr>
	<div class="row mb30 center">
		<table class="table table-admin table-stripe table-hover">
			<thead>
				<tr>
					<th>판매자 닉네임</th>
					<th>은행</th>
					<th>계좌</th>
					<th>유형</th>
					<th>판매자 정보</th>
					<th>승인 날짜</th>
					<th>승인 여부</th>
				</tr>
			</thead>
			<tbody>
				<%for(SellerDto sellerDto : list){ %>
				<tr onclick="location.href='<%=request.getContextPath()%>/admin/member_detail.jsp?memberNo=<%=sellerDto.getSellerNo() %>';" style="width:100%; cursor:pointer;">
					<td><%=sellerDto.getSellerNick()%></td>
					<td><%=sellerDto.getSellerAccountBank()%></td>
					<td><%=sellerDto.getSellerAccountNo()%></td>
					<td><%=sellerDto.getSellerType()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/project/seller_page.jsp?sellerNo=<%=sellerDto.getSellerNo()%>" class="link">ℹ️</a>
					</td>
					<td>
					<%if(sellerDto.getSellerRegistDate()==null){ %>
						대기중
					<%}else{ %>
						<%=sellerDto.getSellerRegistDate() %>
					<%} %>
					</td>
					<td>
							<%if(sellerDto.getSellerPermission()==0){ %>
								<span style="color: red">승인필요</span>
							<%}else if(sellerDto.getSellerPermission()==1){%>
								<span style="color: blue">승인완료</span>
	 						<%}else{ %>
								반려 
							<%} %>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
		<!--페이지네이션 -->
<%
int count = sellerDao.adminCountByPaging();
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