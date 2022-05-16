<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String memberEmail = request.getParameter("memberEmail");
%>

<jsp:include page="/template/header.jsp"></jsp:include>

 
<div class="container w800">
	<div class="row mt100 center">
		<h1>찾으시는 아이디는 <%=memberEmail%> 입니다</h1>
	</div>
	<div class="row m30 center">
		<h3><a href="login.jsp" class="link"> >> 로그인 하러가기</a></h3>
	</div>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>