<%@page import="moa.beans.MoaQuestionAttachDao"%>
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
<style>
  textarea {
    width: 100%;
    min-height: 6em;
    border: none;
    resize: none;
    font-size: 15px;
  }
</style>
<script type="text/javascript">
	$(function() {
		$(".btn-detail").each(function(){
			$(this).click(function() {
				$(this).next().toggle();
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
					<th width="20%">문의유형</th>
					<th width="30%">제목</th>
					<th width="25%">작성일</th>
					<th width="25%">처리상태</th>
				</tr>
			</thead>
			<tbody>
				<%if(list.isEmpty()){ %>
					<tr>
						<td colspan="4">							
							<br>작성하신 1:1 문의가 없습니다.<br>
							주문, 배송 및 사이트 이용과 관련한 문의를 하시려면 1:1 문의를 이용해주세요.
							<br><br>
						</td>
					</tr>
				<% }%>
				<%
				for (MoaQuestionDto questionDto : list) {	
					//문의 답변 불러오기
					MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
					MoaQuestionReplyDto questionReplyDto = moaQuestionReplyDao.selectOne(questionDto.getQuestionNo());
					
					//문의 첨부파일 불러오기
					MoaQuestionAttachDao moaQuestionAttachDao = new MoaQuestionAttachDao();
					int questionAttachNo = moaQuestionAttachDao.selectOne(questionDto.getQuestionNo());
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
					<%if(questionDto.getAnswerStatus() == 0){ %>
				<tr style="display: none;" class="show-detail">
					<td colspan="3" class="left" style="vertical-align: top;">
						<%if(questionAttachNo != 0) {%>
						<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=questionAttachNo%>" width="400"  height="400" class="img" onerror="javascript:this.src='https://dummyimage.com/400x400'"><br>
						<%} %>
						<span style="font-weight: bold;">문의내용</span><br>
					 	<%=questionDto.getQuestionContent() %>				
					</td>
					<td>
							<a href="<%=request.getContextPath()%>/member/questionDelete.do?questionNo=<%=questionDto.getQuestionNo() %>" class="link link-small btn-replyDelete">삭제</a>
					</td>
				</tr>
					<%}else{%>
					<tr style="display: none;" class="show-detail b-purple">
					<td colspan="2" class=" b-right left" style="vertical-align: top;">
					 	<span style="font-weight: bold;">문의내용</span><br>
					 	<%if(questionAttachNo != 0) {%>
					 	<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=questionAttachNo%>" width="400"  height="400" class="img" onerror="javascript:this.src='https://dummyimage.com/400x400'"><br>
					 	<%} %>
					 	<textarea disabled><%=questionDto.getQuestionContent() %></textarea>
					</td>
					<td colspan="2" style="vertical-align: top;" class="left">
						<span style="font-weight: bold;">답변</span><br>
						<textarea disabled><%=questionReplyDto.getQuestionReplyContent() %></textarea>		
					</td>
				</tr>		
					<%} %>
				<%}%>
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>