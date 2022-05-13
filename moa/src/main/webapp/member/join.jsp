<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(function() {
		$(".check-pw").click(function() {
			var checkList = $(".check-pw").prop("checked");

			if (checkList) {
				// 체크되었으면
				$("input[name=memberPw]").prop("type", "text");
			} else {
				// 체크 해제되면
				$("input[name=memberPw]").prop("type", "password");
			}
		});

		var status = {
			//이름 : 값
			memberEmail : false,
			memberPw : false,
			memberNick : false,
			memberPhone : false,
			memberRoute : false
		};

		$("input[name=memberEmail]")
				.blur(
						function() {

							// 형식 검사
							var regex = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
							var memberEmail = $(this).val();

							var judge = regex.test(memberEmail);
							if (!judge) {
								$(this).next("span").text(
										"이메일을 형식에 맞게 작성해 주세요.");
								$("button[name=submit]").attr("disabled", true);
								status.memberEmail = false;
								return;
							} else {
								$(this).next("span").text("사용 가능한 이메일입니다.");
								$("button[name=submit]")
										.attr("disabled", false);
								status.memberEmail = false;
							}

							var that = this;

							// 중복 검사
							$
									.ajax({
										url : "http://localhost:8080/moa/ajax/email.do?memberEmail="
												+ memberEmail,
										type : "get",
										success : function(resp) {
											// resp는 "NNNNN" 또는 "NNNNY"
											if (resp == "NNNNN") {
												$(that).next("span").text(
														"이미 사용 중인 이메일입니다.");
												$("button[name=submit]").attr(
														"disabled", true);
												status.memberEmail = false;
											} else if (resp == "NNNNY") {
												$(that).next("span").text(
														"사용 가능한 이메일입니다.");
												$("button[name=submit]").attr(
														"disabled", false);
												status.memberEmail = true;
											}
										}
									});
						});

		$("input[name=memberPw]")
				.blur(
						function() {

							var regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%#&])[A-Za-z\d$@$!%#&]{8,16}$/;
							var memberPw = $(this).val();

							var judge = regex.test(memberPw);
							if (!judge) {
								$(this).next("span").text(
										"형식에 맞는 비밀번호를 작성해 주세요.");
								status.password = false;
								$("button[name=submit]").attr("disabled", true);
								return;
							} else {
								$(this).next("span").text("사용 가능한 비밀번호입니다.");
								status.password = false;
								$("button[name=submit]")
										.attr("disabled", false);
							}

						});

		$("input[name=memberNick]").blur(function() {
			var regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
			var memberNick = $(this).val();
			var span = $(this).next("span");

			var judge = regex.test(memberNick);
			if (!judge) {
				span.text("형식에 맞는 닉네임을 사용하세요.");
				status.memberNick = false;
				$("button[name=submit]").prop("disabled");
				return;
			} else {
				span.text("사용 가능한 닉네임입니다.");
				status.memberNick = true;
				$("button[name=submit]").attr("disabled", false);
			}

			var that = this;

			$.ajax({
				url : "http://localhost:8080/moa/ajax/nick.do",
				type : "post",
				data : {
					memberNick : memberNick
				},
				success : function(resp) {
					if (resp === "Y") {
						span.text("사용 가능한 닉네임입니다.");
						$("button[name=submit]").attr("disabled", false);
						status.memberNick = true;
					} else if (resp === "N") {
						span.text("이미 사용 중인 닉네임입니다.");
						status.memberNick = false;
						$("button[name=submit]").attr("disabled", true);
					}
				}
			});
		});

		$("input[name=memberPhone]").blur(function() {
			var regex = /^010([1-9][0-9]{3})([0-9]{4})$/;
			var memberPhone = $(this).val();
			var span = $(this).next("span");

			var judge = regex.test(memberPhone);
			if (!judge) {
				span.text("형식에 맞는 전화번호를 입력해 주세요.");
				status.memberPhone = false;
				$("button[name=submit]").attr("disabled", true);
				return;
			} else {
				span.text("사용 가능한 전화번호입니다.");
				status.memberPhone = true;
				$("button[name=submit]").attr("disabled", false);
			}

			// 휴대폰 중복 검사가 안 됩니다

			$.ajax({
				url : "http://localhost:8080/moa/ajax/phone.do",
				type : "post",
				data : {
					memberPhone : memberPhone
				},
				success : function(resp) {
					if (resp === "Yes") {
						span.text("가입 가능한 전화번호입니다.");
						status.memberPhone = true;
						$("button[name=submit]").attr("disabled", false);
					} else if (resp === "No") {
						span.text("이미 가입된 전화번호입니다.");
						status.memberPhone = false;
						$("button[name=submit]").attr("disabled", true);
					}
				}
			});
		});

	});
</script>

<form action="join.do" method="post">

	<div class="container w450 m20">

		<div class="row center">
			<h1>회원가입</h1>
		</div>

		<div class="row m20">
			<label>* 이메일</label> <input type="email" name="memberEmail" required
				class="form-input fill input-round" autocomplete="off"> <span></span>
		</div>

		<div class="row">
			<label>* 비밀번호</label> <input type="password" name="memberPw" required
				placeholder="영어, 숫자, 특수문자 8~16자" class="form-input fill input-round">
			<span></span>
		</div>

		<!-- 비밀번호 확인하기 -->
		<div class="float-left">
			<label> <input type="checkbox" class="form-input check-pw">
				<span class="link-gray">비밀번호 보기</span>
			</label>
		</div>
		<br>

		<div class="row">
			<label>* 닉네임</label> <input type="text" name="memberNick" required
				placeholder="한글, 숫자 10자 이내" autocomplete="off"
				class="form-input fill input-round"> <span></span>
		</div>

		<div class="row m20">
			<label>* 전화번호</label> <input type="tel" name="memberPhone" required
				placeholder="- 제외하고 입력" class="form-input fill input-round"
				autocomplete="off"> <span></span>
		</div>

		<div class="row m20">
			<label>가입 경로</label> <select name="memberRoute"
				class="form-input input-round">
				<option selected disabled>선택</option>
				<option value="친구 추천">친구 추천</option>
				<option value="인터넷 검색">인터넷 검색</option>
				<option value="광고">광고</option>
				<option value="sns">sns</option>
				<option value="기타">기타</option>
			</select> <span></span>
		</div>

		<div class="row m20">
			<button type="submit" name="submit" class="btn btn-primary fill"
				disabled>회원가입</button>
		</div>

	</div>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>