<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container mt50 center">
		<div class="row">
			<h1 class="link link-purple">회원 가입이 완료되었습니다.</h1>
		</div>
		<div class="row mt30">
			<h3>
				<a href="<%=request.getContextPath()%>" class="link">메인페이지로 이동</a>
			</h3>
		</div>
		<div class="row mt5">
			<h3>
				<%-- 주소 오류나서 수정 --%>
				<a href="<%=request.getContextPath() %>/member/login.jsp" class="link">로그인 하러가기</a>
			</h3>
		</div>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>