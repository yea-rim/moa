<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Integer memberNo = (Integer) session.getAttribute("login");

MemberDao memberDao = new MemberDao();
MemberDto memberDto = memberDao.selectOne(memberNo);
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		// 파일명 input에 출력하는 JS
		// 근데 왜 안 될까?
		$("#file").on('change', function() {
			var fileFullName = $(this).val();
			var fileName = fileFullName.substring(12,fileFullName.length);
			$(".upload-name").val(fileName);
		});
	});
</script>

<form action="join.do" method="post" enctype="multipart/form-data">

	<div class="container w450 m30">

		<div class="row center m30">
			<h1>판매자 신청</h1>
		</div>

		<input type="hidden" name="sellerNo"
			value="<%=memberDto.getMemberNo()%>">

		<div class="row m30">
			<label>판매자 닉네임</label> <input type="text" name="sellerNick" required
				class="form-input fill input-round" autocomplete="off">
		</div>

		<div class="row m30">
			<label>입금 은행</label> <input type="text" name="sellerAccountBank"
				required class="form-input fill input-round" autocomplete="off">
		</div>

		<div class="row m30">
			<label>계좌 번호</label> <input type="text" name="sellerAccountNo"
				required class="form-input fill input-round" autocomplete="off">
		</div>

		<div class="row m30">
			<label>판매자 타입</label> <select name="sellerType"
				class="form-input input-round">
				<option selected disabled>선택</option>
				<option value="개인 사업자">개인 사업자</option>
				<option value="법인 사업자">법인 사업자</option>
				<option value="개인 판매자">개인 판매자</option>
			</select>
		</div>

		<!-- 인증 사진 등록 (attach table)-->
		<div class="row m20">
			<div class="filebox">
				<input class="upload-name" value="첨부파일" placeholder="첨부파일">
				<label for="file">파일찾기</label> <input class="m20" type="file"
					id="file" name="attach" accept="image/*">
			</div>
		</div>

		<div class="row m30">
			<button type="submit" class="btn btn-primary fill">판매자 신청</button>
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>