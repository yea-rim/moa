<%@page import="moa.beans.MoaQuestionReplyDto"%>
<%@page import="moa.beans.MoaQuestionReplyDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.MoaQuestionDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.MoaQuestionDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int memberNo = (int)session.getAttribute("login");

	MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
	List<MoaQuestionDto> list = moaQuestionDao.selecMyQuestion(memberNo);
%>    
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$(".btn-detail").each(function(){
			$(this).click(function() {
				$(this).attr("style","border-bottom: none;");
				$(this).next().toggle();
				$(this).next().next().toggle();
			});
		});
		
		$(".btn-replyDelete").each(function(){
			$(this).click(function() {
				return confirm("정말 삭제 하시겠습니까?");
			});
		});	
	});
</script>
<div class="container w900"> 
	<div class="row mt30">
		<h2>1:1 문의</h2>
	</div>
	<hr>
	<div class="row mt20">
		<table class="table table-admin table-stripe">
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
					MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
					MoaQuestionReplyDto questionReplyDto = moaQuestionReplyDao.selectOne(questionDto.getQuestionNo());
					
				%>
				<tr style="width:100%;cursor:pointer;" class="btn-detail">
					<td><%=questionDto.getQuestionType() %></td>
					<td class="left"><%=questionDto.getQuestionTitle()%></td>
					<td><%=questionDto.getQuestionTime() %></td>
					<td>
						<%if(questionDto.getAnswerStatus() ==0){ %>
							<span>답변대기</span>
						<%}else{ %>
							<span style="color: blue">답변완료</span>
						<%} %>
					</td>
				</tr>
				<tr style="display: none;" class="show-detail">
				<th style="vertical-align: top; font-weight: bold;">문의내용 : </th>
					<td colspan="2" class="left" style="vertical-align: top;">
					 	<%=questionDto.getQuestionContent() %>				
					</td>
					<td>
							<a href="<%=request.getContextPath()%>/member/questionDelete.do?questionNo=<%=questionDto.getQuestionNo() %>" class="link link-small btn-replyDelete">삭제</a>
					</td>
					<%if(questionDto.getAnswerStatus() == 1){ %>
					</tr>
					<tr style="display: none;">
						<th style="vertical-align: top; font-weight: bold; color: blue;">답변 : </th>
						<td colspan="3" class="left" style="vertical-align: top;">
						 	<%=questionReplyDto.getQuestionReplyContent() %>				
						</td>				
					<%} %>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>