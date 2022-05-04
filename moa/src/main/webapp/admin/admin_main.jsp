<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container w800">
		<div class="row">
			<h1> 관리자 페이지 </h1>
		</div>
		<div class="row">
			<a href="<%=request.getContextPath()%>/member/logout.do">로그아웃</a>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>