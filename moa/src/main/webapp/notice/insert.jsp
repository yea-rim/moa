<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 준비 --%>
<title>moa 공지작성</title>
<style>
textarea[name=noticeContent] {
	width: 100%;
	height: 500px;
	resize: none;
	padding: 1em;
}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<hr style="border:solid 0.5px lightgray">
	<div class="container w800 m50">
		
		<div class="row">
			<h2>공지 작성</h2>
		</div>
		
		<form action="insert.do" method="post" enctype="multipart/form-data">
			
			<div class="row fill m10">
				<input type="text" name="noticeTitle" required placeholder="제목을 입력해주세요"  class="form-input fill" autocomplete="off">
			</div>
			
			<div class="row fill m10">
				<input type="file" name="attach">
			</div>
			
			<div class="row fill center m10">
				<textarea name="noticeContent" required placeholder="본문을 입력해주세요"></textarea>
			</div>
			
			<div class="row center fill">
				<button type="submit" class="btn fill">작성</button>
			</div>
		</form>
		
	</div>


<jsp:include page="/template/footer.jsp"></jsp:include>