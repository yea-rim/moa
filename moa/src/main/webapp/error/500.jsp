<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="row m30">
<h1>500 Server Error</h1><br>
<img src="<%=request.getContextPath()%>/image/500.gif">
<br><br>
<h2>서비스 사용에 불편을 드려 죄송합니다.</h2>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>