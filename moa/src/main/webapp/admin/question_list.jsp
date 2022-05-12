<%@page import="moa.beans.MoaQuestionDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.MoaQuestionDao"%>
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
%>

<%
	MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
	List<MoaQuestionDto> list = moaQuestionDao.selectList(p, s);
%>    
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<div class="container w800"> 
	<div class="row mt30">
		<h2>1:1 문의</h2>
	</div>
	<hr>
	<div class="row mt20">
		<table class="table table-admin table-stripe table-hover">
			<thead>
				<tr>
					<th>문의유형</th>
					<th>제목</th>
					<th>작성일</th>
					<th>처리상태</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (MoaQuestionDto questionDto : list) {
				%>
				<tr onclick="location.href='<%=request.getContextPath()%>/admin/question_detail.jsp?questionNo=<%=questionDto.getQuestionNo() %>';" style="width:100%;cursor:pointer;">
					<td><%=questionDto.getQuestionType() %></td>
					<td><%=questionDto.getQuestionTitle()%></td>
					<td><%=questionDto.getQuestionTime() %></td>
					<td>
						<%if(questionDto.getAnswerStatus() ==0){ %>
							<span style="color: red">답변필요</span>
						<%}else{ %>
							<span style="color: blue">답변완료</span>
						<%} %>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
	
	<!--페이지네이션 -->
<%
int count = moaQuestionDao.adminCountByPaging();
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