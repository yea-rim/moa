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
		
		var status = {
				sellerNick : false,
				sellerAccountBank : false,
				sellerAccountNo : false,
				sellerTypeCheck : false,
				sellerAttach : false
		}
		
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
				return;
			} else {
				span.text("사용 가능한 판매자 닉네임입니다.");
				status.sellerNick = true;
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
						status.sellerNick = true;
					} else if (resp === "NN") {
						span.text("이미 사용 중인 판매자 닉네임입니다.");
						status.sellerNick = false;
					}
				}
			});
		});
		
		$("input[name=sellerAccountBank]").blur(function(){
			if($(this).val() == ""){
				$(this).next("span").text("은행 정보를 입력해주세요.");
				status.sellerAccountBank = false;
			}else{
				status.sellerAccountBank = true;
			}
		})
		
		$("input[name=sellerAccountNo").blur(function(){
			
			if($(this).val() == ""){
				$(this).next("span").text("계좌 정보를 입력해주세요.");
				status.sellerAccountNo = false;
			}else{
				status.sellerAccountNo = true;
			}
		});
		
		$("select[name=sellerType]").blur(function(){
			
			if($(this).val() == ""){
				$(this).next("span").text("타입을 선택해주세요.");
				status.sellerTypeCheck = false;
			}else{
				status.sellerTypeCheck = true;
			}
		});
		
		$("input[name=attach]").on("input", function(){
			
			if($(this).val() == ""){
				$(this).next("span").text("파일을 선택해주세요.");
				status.sellerAttach = false;
			}else{
				status.sellerAttach = true;
			}
		});
		
		$(".seller-join-formcheck").submit(function(){
			if(status.sellerNick && status.sellerAccountBank && status.sellerAccountNo && status.sellerTypeCheck && status.sellerAttach){
				return true;
			}else{
				alert("필수 정보를 모두 입력해주세요.");
				return false;
			}
		});
		
		
		
	});
</script>

<form action="<%=request.getContextPath() %>/member/seller_join.do" method="post" enctype="multipart/form-data" class="seller-join-formcheck">

	<div class="container w450 m30">

		<div class="row center m30">
			<h1>판매자 신청</h1>
		</div>

		<input type="hidden" name="sellerNo"
			value="<%=memberDto.getMemberNo()%>">

		<div class="row m30">
			<label class="m10">(*) 판매자 닉네임</label> <input type="text" name="sellerNick"
				class="form-input fill input-round" autocomplete="off">
				<span></span>
		</div>

		<div class="row m30">
			<label class="m10">(*) 입금 은행</label> <input type="text" name="sellerAccountBank"
				 class="form-input fill input-round" autocomplete="off">
				 <span></span>
		</div>

		<div class="row m30">
			<label class="m10">(*) 계좌 번호</label> <input type="text" name="sellerAccountNo"
				 class="form-input fill input-round" autocomplete="off">
				 <span></span>
		</div>

		<div class="row m30">
			<label class="m10">(*) 판매자 타입</label> <select name="sellerType"
				class="form-input input-round">
				<option selected value="">선택</option>
				<option value="개인 사업자">개인 사업자</option>
				<option value="법인 사업자">법인 사업자</option>
				<option value="개인 판매자">개인 판매자</option>
			</select>
			<span></span>
		</div>

		<!-- 인증 사진 등록 (attach table)-->
		<div class="row m20">
					<label class="m10">(*) 본인인증 자료</label>
			<div class="filebox">
				<input class="upload-name" placeholder="첨부파일" disabled>
<<<<<<< HEAD
				<label for="file">파일 찾기</label> 
				<input class="m20" type="file" id="file" name="attach" accept="image/*">
				<span></span>
=======
				<label for="file">파일 찾기</label> <input class="m20" type="file"
					id="file" name="attach" accept="image/*" required>
>>>>>>> refs/remotes/origin/main
			</div>
		</div>

		<div class="row m40">
			<button type="submit" name="submit" class="btn btn-primary fill">판매자 신청</button>
		</div>
	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>