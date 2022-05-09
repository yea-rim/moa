<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page = "/template/header.jsp"></jsp:include>

	<div class="container w300 m50">
		<div class="row m10 center">
			<h2>탈퇴가 완료되었습니다.</h2>
		</div>
		<div class="row m20 center">
			<a href="<%=request.getContextPath()%>" class="link link-purple">메인 페이지로 돌아가기</a>
		</div>
	</div>

<jsp:include page = "/template/footer.jsp"></jsp:include>