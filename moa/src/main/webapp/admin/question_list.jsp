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
<style>
		textarea {
		    width: 100%;
		    height: 6.25em;
		    border: none;
		    resize: none;
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
		
		//$(".btn-replyEdit").each(function() {
		//	$(this).click(function(){
		//		$(this).prevAll('.replyEdit').hide();
		//
		//	});
		//});

		
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
					<th>작성자</th>
					<th>문의유형</th>
					<th>제목</th>
					<th>작성일</th>
					<th>처리상태</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (MoaQuestionDto questionDto : list) {
					//회원 닉네임
					MemberDao memberDao = new MemberDao();
					MemberDto memberDto = memberDao.selectOne(questionDto.getQuestionWriter());
					
					//문의 댓글
					MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
					MoaQuestionReplyDto questionReplyDto = moaQuestionReplyDao.selectOne(questionDto.getQuestionNo());
					
					//문의 첨부파일
					MoaQuestionAttachDao moaQuestionAttachDao = new MoaQuestionAttachDao();
					int questionAttachNo = moaQuestionAttachDao.selectOne(questionDto.getQuestionNo());
					
					
				%>
				<tr style="width:100%;cursor:pointer;" class="btn-detail">
					<td><%=memberDto.getMemberNick()%></td>
					<td><%=questionDto.getQuestionType() %></td>
					<td class="left"><%=questionDto.getQuestionTitle()%></td>
					<td><%=questionDto.getQuestionTime() %></td>
					<td>
						<%if(questionDto.getAnswerStatus() ==0){ %>
							<span style="color: red">답변필요</span>
						<%}else{ %>
							<span style="color: blue">답변완료</span>
						<%} %>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/question/delete.do?questionNo=<%=questionDto.getQuestionNo() %>&admin=1" class="btn-replyDelete">
						<img src="<%=request.getContextPath()%>/image/delete.png" width="20">
						</a>
					</td>
				</tr>
				<tr style="display: none;" class="show-detail">
<!-- 				<th style="vertical-align: top;" class="b-left">문의내용</th> -->
				<td colspan="3" class="left b-right b-left" style="vertical-align: top; text-overflow: ellipsis;">
					<%if(questionAttachNo != 0) {%>
					<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=questionAttachNo%>" width="400"  height="300px" class="img" onerror="javascript:this.src='https://dummyimage.com/400x400'"><br>
					<%} %>
					<span style="font-weight: bold;">문의 내용</span> <textarea disabled><%=questionDto.getQuestionContent() %></textarea>		
				</td>
				<td colspan="3" class="w200 left b-right">
				<%if(questionDto.getAnswerStatus() ==0){ %>
					<form action="questionReplyInsert.do" method="post">
						<input type="hidden" name="questionTargetNo" value="<%=questionDto.getQuestionNo() %>">
						<textarea name="questionReplyContent" rows="5" class="fill form-input mt5" placeholder="답변내용입력" autocomplete="off"></textarea>
						<div class="row center">
							<button class="btn btn-reverse fill">답변하기</button>
						</div>
					</form>
					<%}else{ %>
						<span>답변내용</span>
						<form action="questionReplyEdit.do" method="post">
						<input type="hidden" name="questionTargetNo" value="<%=questionDto.getQuestionNo() %>">
						<textarea rows="5" class="fill form-input mt5 replyEdit" name="questionReplyContent" placeholder="<%=questionReplyDto.getQuestionReplyContent() %>" autocomplete="off"></textarea>
            		<div class="flex-container m5">
		                <div class="left-wrapper">
		                    <button type="submit" class="link link-btn btn-replyEdit fill">수정</button>
		                </div>
		                </form>
		                <div class="right-wrapper">
		                    <a href="<%=request.getContextPath()%>/admin/questionReplyDelete.do?questionNo=<%=questionDto.getQuestionNo() %>" class="btn-replyDelete">
		                    	<input type="button" value="삭제" class="link link-reverse fill">
		                    </a>
		                 </div>
             		</div> 
					<%}%>
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