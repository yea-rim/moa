<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String keyword = request.getParameter("keyword");
%>

<%
	boolean isSearch = (keyword != null && !keyword.equals(""));

	SellerDao sellerDao = new SellerDao();
	List<SellerDto> list;
	if(isSearch){
		list = sellerDao.selectSeller(keyword);
	} else {
		list = sellerDao.selectSeller();
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container w800">
	
		<div class="row m30 center">
			<h1>판매자 목록(승인 완료)</h1>
		</div>
		
	<!-- 검색창 -->
<!-- 	<form action="seller_join_list.jsp" method="get" class="row m30 center"> -->
<%-- 		<%if(isSearch){ %> --%>
<%-- 		<input type="text" name="keyword" placeholder="검색어 입력" value="<%=keyword%>"> --%>
<%-- 		<%} else { %> --%>
<!-- 		<input type="text" name="keyword" placeholder="검색어 입력"> -->
<%-- 		<%} %> --%>
<!-- 		<input type="submit" value="검색"> -->
<!-- 	</form> -->
	
	<div class="row m30 center">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>회원 번호</th>
					<th>판매자 닉네임</th>
					<th>은행</th>
					<th>계좌</th>
					<th>유형</th>
					<th>판매자 정보</th>
					<th>승인 날짜</th>
				</tr>
			</thead>
			<tbody>
				<%for(SellerDto sellerDto : list){ %>
				<tr>
					<td><%=sellerDto.getSellerNo()%></td>
					<td><%=sellerDto.getSellerNick()%></td>
					<td><%=sellerDto.getSellerAccountBank()%></td>
					<td><%=sellerDto.getSellerAccountNo()%></td>
					<td><%=sellerDto.getSellerType()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/seller/seller_page.jsp?sellerNo=<%=sellerDto.getSellerNo()%>" class="link">ℹ️</a>
					</td>
					<td><%=sellerDto.getSellerRegistDate() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>