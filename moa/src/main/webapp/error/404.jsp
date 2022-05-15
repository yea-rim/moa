<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="row m40">
<h2>요청하신 페이지를 찾을 수 없습니다.</h2>
<br>
<img src="<%=request.getContextPath()%>/image/404.gif">
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>