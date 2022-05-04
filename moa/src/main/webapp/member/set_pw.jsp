<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberEmail = request.getParameter("memberEmail");
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<form action="set_pw.do" method="post">
	<input type="hidden" name="memberEmail" value="<%=memberEmail%>">
	<div class="container w400 m30">
	    <div class="row center">
	        <h1>비밀번호 재설정</h1>
	    </div>
	    <div class="row">
	        <input type="password" name="memberPw" required placeholder="재설정할 비밀번호 입력" class="form-input fill input-round">
	    </div>
	    <div class="row">
	        <button type="submit" class="btn btn-primary fill">비밀번호 재설정</button>
	    </div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>