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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(function() {
		
		// 파일명 input에 출력하는 JS
		$("#file").on('change', function() {
			var fileFullName = $(this).val();
			var fileName = fileFullName.substring(12,fileFullName.length);
			$(".upload-name").val(fileName);
		});
		
		// 판매자 닉네임 형식 검사 --> 중복 검사
		$("input[name=sellerNick]").blur(function() {
			var regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
			var sellerNick = $(this).val();
			var span = $(this).next("span");

			var judge = regex.test(sellerNick);
			if (!judge) {
				span.text("형식에 맞는 판매자 닉네임을 사용하세요.");
				status.sellerNick = false;
				$("button[name=submit]").prop("disabled");
				return;
			} else {
				span.text("사용 가능한 판매자 닉네임입니다.");
				status.sellerNick = true;
				$("button[name=submit]").attr("disabled", false);
			}

			var that = this;

			$.ajax({
				url : "http://localhost:8080/moa/ajax/sellerNick.do",
				type : "post",
				data : {
					sellerNick : sellerNick
				},
				success : function(resp) {
					if (resp === "YY") {
						span.text("사용 가능한 판매자 닉네임입니다.");
						$("button[name=submit]").attr("disabled", false);
						status.sellerNick = true;
					} else if (resp === "NN") {
						span.text("이미 사용 중인 판매자 닉네임입니다.");
						status.sellerNick = false;
						$("button[name=submit]").attr("disabled", true);
					}
				}
			});
		});
		
	});
</script>

<form action="seller_join.do" method="post" enctype="multipart/form-data">

	<div class="container w450 m30">

		<div class="row center m30">
			<h1>판매자 신청</h1>
		</div>

		<input type="hidden" name="sellerNo"
			value="<%=memberDto.getMemberNo()%>">

		<div class="row m30">
			<label class="m10">(*) 판매자 닉네임</label> <input type="text" name="sellerNick" required
				class="form-input fill input-round" autocomplete="off">
				<span></span>
		</div>

		<div class="row m30">
			<label class="m10">(*) 입금 은행</label> <input type="text" name="sellerAccountBank"
				required class="form-input fill input-round" autocomplete="off">
		</div>

		<div class="row m30">
			<label class="m10">(*) 계좌 번호</label> <input type="text" name="sellerAccountNo"
				required class="form-input fill input-round" autocomplete="off">
		</div>

		<div class="row m30">
			<label class="m10">(*) 판매자 타입</label> <select name="sellerType"
				class="form-input input-round" required>
				<option selected disabled>선택</option>
				<option value="개인 사업자">개인 사업자</option>
				<option value="법인 사업자">법인 사업자</option>
				<option value="개인 판매자">개인 판매자</option>
			</select>
		</div>

		<!-- 인증 사진 등록 (attach table)-->
		<div class="row m20">
					<label class="m10">(*) 본인인증 자료</label>
			<div class="filebox">
				<input class="upload-name" placeholder="첨부파일" disabled>
				<label for="file">파일 찾기</label> <input class="m20" type="file"
					id="file" name="attach" accept="image/*" required>
			</div>
		</div>

		<div class="row m40">
			<button type="submit" name="submit" class="btn btn-primary fill" disabled>판매자 신청</button>
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>