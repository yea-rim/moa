<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String sort = request.getParameter("sort");
	if (sort == null){
		sort = "최신순";
	}
	
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
		s = 10;
	}
%>

<%
	MemberDao memberDao = new MemberDao();
	List<MemberDto> list = memberDao.allSelectList(p, s, sort);
%>
    
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

<script type="text/javascript">
    $(function () {
      $(".sort").change(function () {
    	  this.form.submit();
      });
	});
</script>

<div class="container w950 m30">

	<div class="row center">
		<h1>회원 목록</h1>
	</div>
	
	<div class="row right">
		<form action="member_list.jsp" method="get">
			<select name="sort" class="sort">
				<option>선택</option>
				<option>최신순</option>
				<option>판매자신청중</option>
				<option>판매자승인</option>
				<option>판매자거절</option>
			</select>
		</form>
	</div>		
	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>회원 번호</th>
					<th>이메일</th>
					<th>닉네임</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>가입 경로</th>
				</tr>
			</thead>
			<tbody align="center">
				<%for(MemberDto memberDto : list){ %>
				<tr onclick="location.href='<%=request.getContextPath()%>/member/detail.jsp?memberNo=<%=memberDto.getMemberNo() %>';" style="width:100%; cursor:pointer;">
					<td><%=memberDto.getMemberNo()%></td>
					<td><%=memberDto.getMemberEmail()%></td>
					<td><%=memberDto.getMemberNick()%></td>
					<td><%=memberDto.getMemberPhone()%></td>
					<td><%=memberDto.getMemberJoinDate()%></td>
					<td><%=memberDto.getMemberPost()%></td>
					<td><%=memberDto.getMemberBasicAddress()%></td>
					<td><%=memberDto.getMemberDetailAddress()%></td>
					<td><%=memberDto.getMemberRoute()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<!-- 숫자(페이지네이션) 링크 -->
<%
	int count = memberDao.countByPaging();
	
	//마지막 페이지 번호 계산
	int lastPage = (count + s - 1) / s;
	
	//블록 크기
	int blockSize = 10;
	
	//시작블록 혹은 종료 블록 중 하나만 계산하면 반대편은 계산이 가능하다.
	//종료블록에 영향을 미치는 데이터는 현재 페이지(p) 이다.
	//하단 블록에는 반드시 현재페이지 번호가 포함되어야 하므로 이 번호를 기준으로 시작과 종료를 계산한다!
	int endBlock = (p + blockSize - 1) / blockSize * blockSize;
	int startBlock = endBlock - (blockSize - 1);
	
	//범위를 초과하는 문제를 해결(endBlock > lastPage)
	if(endBlock > lastPage){
		endBlock = lastPage;
	}
%>
	
	<div class="row center pagination">
		<%--
			목록과 검색은 링크가 다르다. 이유는 유지시켜야 하는 파라미터의 개수가 다르기 때문이다.
			- 목록 = p, s
			- 검색 = p, s, type, keyword
		 --%>
		
		<!-- 이전 버튼 영역 -->
		
		<%--
			p > 1 : 첫 번째 페이지가 아닌 경우
			startBlock > 1 : 첫 번째 블록 구간이 아닌 경우
			p < lastPage : 마지막 페이지가 아닌 경우
			endBlock < lastPage : 마지막 블록 구간이 아닌 경우
		 --%>
		
		<%if(p > 1){ %>
			<a href="member_list.jsp?p=1&s=<%=s%>&type=<%=sort%>">&laquo;</a>
		<%} %>
		
		<%if(startBlock > 1){ %>
			<a href="member_list.jsp?p=<%=startBlock-1%>&s=<%=s%>">&lt;</a>
		<%} %>
		
		<!-- 숫자 링크 영역 -->
		<%for(int i=startBlock; i <= endBlock; i++){ %>
				<%if(i == p){ %>
				<a class="active" href="member_list.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>	
				<%} else { %>
				<a href="member_list.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>
			<%} %>
		<%} %>
		
		<!-- 다음 버튼 영역 -->
		<%if(endBlock < lastPage){ %>
			<a href="member_list.jsp?p=<%=endBlock+1%>&s=<%=s%>&sort=<%=sort%>">&gt;</a>
		<%} %>
		
		<%if(p < lastPage){ %>
			<a href="member_list.jsp?p=<%=lastPage%>&s=<%=s%>&sort=<%=sort%>">&raquo;</a>
		<%} %>
		
	</div>
	
</div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include> 