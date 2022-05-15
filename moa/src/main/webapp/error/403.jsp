<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="row m30">
<h1>403 ERROR</h1>
<img src="<%=request.getContextPath()%>/image/error.png">
<h2>요청하신 페이지에 접근 권한이 없습니다.</h2>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>