<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<form action="find_email.do" method="post">
	<div class="container w400 m30">
	    <div class="row center">
	        <h1>아이디 찾기</h1>
	    </div>
	    <div class="row m20">
	        <label>전화번호</label>
	        <input type="tel" name="memberPhone" autocomplete="off" required class="form-input fill input-round">
	    </div>
	    <div class="row m20">
	        <label>닉네임</label>
	        <input type="text" name="memberNick" autocomplete="off" required class="form-input fill input-round">
	    </div>
	    <div class="row m20">
	        <button type="submit" class="btn btn-primary fill">아이디 찾기</button>
	    </div>
		<%if(request.getParameter("error") != null){ %>
		<div class="row center m20">
			<h3 style="color:red;">정보가 일치하는 아이디가 존재하지 않습니다</h3>
		</div>
		<%} %>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>