<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {	
		
		var index = 0;
		move(index);
		//다음 버튼을 누르면 다음 페이지가 나오도록 구현
		$(".btn-next").not(":last").click(function() {
			//index++;
			move(++index);
		});

		//이전 버튼을 누르면 다음 페이지가 나오도록 구현
		$(".btn-prev").not(":first").click(function() {
			//index--;
			move(--index);
		});

		function move(index) {
			$(".page").hide();
			$(".page").eq(index).show();
			var percent = (index + 1) * 100 / 2;
			$(".percent").css("width", percent + "%");
		}

		//날짜 선택 (datepicker) 설정
		var dateFormat = "yy-mm-dd", from = $("#start").datepicker(
				{
					showMonthAfterYear : true, //연도,달 순서로 지정
					changeMonth : true, //달 변경 지정
					dateFormat : "yy-mm-dd", //날짜 포맷
					dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ], //요일 이름 지정
					monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8",
							"9", "10", "11", "12" ], //월 이름 지정
					minDate : 0
				//오늘 이전 날짜를 선택할 수 없음
				}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this)); //종료일의 minDate 지정
		}), to = $("#end").datepicker(
				{
					showMonthAfterYear : true,
					changeMonth : true,
					dateFormat : "yy-mm-dd",
					dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
					monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8",
							"9", "10", "11", "12" ],
					minDate : '+1D' //내일부터 선택가능, 지정형식 예(+1D +1M +1Y)
				}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this)); //시작일의 maxDate 지정
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
				if (element.id == 'from') {
					date.setDate(date.getDate() + 1); //종료일은 시작보다 하루 이후부터 지정할 수 있도록 설정
				} else {
					date.setDate(date.getDate() - 1); //시작일은 종료일보다 하루 전부터 지정할 수 있도록 설정
				}
			} catch (error) {
				date = null;
			}
			return date;
		}
		
		
		//펀딩 일수 계산 함수
		function fundingDays(){
						
			var stDate = new Date($("#start").val()) ; 
			var endDate = new Date($("#end").val()) ; 
			var btMs = endDate.getTime() - stDate.getTime() ; 
			var btDay = btMs / (1000*60*60*24) ;	

			console.log(btDay);
			if(isNaN(btDay)){
				$(".days").text("");
			}
			else{
				$(".days").text(btDay+"일");
			}
				
		}

		//펀딩 일수 띄우기
		$("#end").on("change",fundingDays);
		$("#start").on("change",fundingDays);

		
		//리워드추가 함수
		function addReaward(rewardNum) {
			var div = $("<div>").attr('class', 'row');
			var btn = $('<div class="row m20 right"><input type="button" class="btn btn-removeReward" value="리워드 삭제 -"></div>');
			var h3 = $("<h3>리워드" + rewardNum + "</h3>");
			var content = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="rewardName" class="form-input fill"></div>\
                    <div class="row m20"><label>리워드 내용</label> <textarea name="rewardContent" rows="5" class="form-input fill"></textarea></div>\
                    <div class="row m20"><label>리워드 가격</label> <input type="number" name="rewardPrice" class="form-input fill"></div>\
                    <div class="row m20"><label>리워드 재고</label> <input type="number" name="rewardStock" class="form-input fill"></div>');

			div.append(btn).append(h3).append(content);
			$("#add-reaward").append(div);

		}

		rewardNum = 2;
		//리워드 추가버튼 클릭 시 내용 추가
		$(".btn-addReward").click(function() {

			addReaward(rewardNum);
			rewardNum++;
		});

		//파일 추가,삭제
		var maxAppend = 1;
		$(".btn-addFile").click(function() {
			if (maxAppend >= 3)
				return;
			$(".buttons")
					.append(
							'<input type="file" name="profileAttach" accept="image/*">\
							<button type="button" class="addbtn btn-removeFile"> - </button><br>'
							);
			maxAppend++;
			$(".btn-removeFile").click(function() {
				$(this).prev().remove(); // remove the file
				$(this).next().remove(); // remove the <br>
				$(this).remove(); // remove the button
				maxAppend--;
			});
		});

		//펀딩 금액 확인 메세지
		$("input[name=projectTargetMoney]").blur(function() {
			var inVal = $(this).val();
			var regexVal = /^[0-9]{6,20}$/;

			if (regexVal.test(inVal)) {
				if (inVal >= 500000) {
					$(".font-on").text("");
				} else {
					$(".font-on").text("50만원 이상의 금액을 입력해주세요.");
				}
			} else {
				$(".font-on").text("50만원 이상의 금액을 입력해주세요.");
			}
		});
			
	});
</script>

<body>

	<!--프로젝트 입력 페이지-->
	<form action="insert.do" method="post" enctype="multipart/form-data" class="insert-form">
		<div class="container w600 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1_ck.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3.png" width="80">
			</div>
			<div class="row center m50">
				<h1>프로젝트 기본 입력</h1>
			</div>
			<div class="row m20">
				<label>카테고리</label> <select name="projectCategory"
					class="form-input fill">
					<option value="">선택</option>
					<option>패션/잡화</option>
					<option>뷰티</option>
					<option>푸드</option>
					<option>홈/리빙</option>
					<option>테크/가전</option>
					<option>기타</option>
				</select>
			</div>
			<div class="row m20">
				<label>프로젝트명</label> <input type="text" name="projectName" class="form-input fill">
			</div>
			<div class="row m20">
				<label>프로젝트 요약글</label>
				<textarea name="projectSummary" rows="10" class="form-input fill"></textarea>
			</div>
			<div class="row m20">
				<label>펀딩 목표 금액</label> 
				<input type="number" name="projectTargetMoney" class="form-input fill"> 
				<span class="font-on" style="color: red; font-size: 12px"></span><br>
				<span style="color: gray; font-size: 12px"> 
					※목표 금액 설정 시 꼭알아두세요!<br> 
					종료일까지 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.<br> 
					종료 전 후원 취소를 대비해 10% 이상 초과 달성을 목표로 해주세요.<br> 
					제작비, 선물 배송비, 인건비, 예비 비용 등을 함께 고려해주세요.<br>
				</span>
			</div>
			<div class="row center">
				<button type="button" class="btn btn-prev">이전 단계</button>
				<button type="button" class="btn btn-next">다음 단계</button>
			</div>
		</div>

		<!--프로젝트 날짜, 파일 선택-->
		<div class="container w600 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2_ck.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3.png" width="80">
			</div>
			<div class="row center m50">
				<h1>프로젝트 상세 선택</h1>
			</div>
			<div class="row">
				<h3>펀딩 일정</h3>
			</div>
			<div class="row m20">
				<label>펀딩 시작일</label> 
				<input type="text" name="projectStartDate" id="start" autocomplete="off" placeholder="연도-월-일" class="form-date">
			</div>
			<div class="row m10">
				펀딩기간<span class="days"></span>
			</div>
			<div class="row m10">
				<label>펀딩 마감일</label> 
				<input type="text" name="projectSemiFinish" id="end" autocomplete="off" placeholder="연도-월-일" class="form-date">
			</div>
			<div class="row m20">
				<label>최종 마감일</label> 
				<input type="date" name="projectFinishDate" class="form-date">
			</div>
			<div class="row">
				<h4>프로젝트 대표이미지</h4>
			</div>
			<div class="row m10">
				<input type="file" name="profileAttach" accept="image/*">
				<button type="button" class="addbtn btn-addFile">+</button>
				<br> <span class="buttons"></span>
			</div>
			<div class="row m20">
				<h4>프로젝트 상세이미지</h4>
				<input type="file" class="filebox" name="detailAttach" accept="image/*">
			</div>
			<div class="row center">
				<button type="button" class="btn btn-prev">이전 단계</button>
				<button type="button" class="btn btn-next">다음 단계</button>
			</div>
		</div>


		<!--리워드 추가 페이지-->
		<div class="container w600 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3_ck.png" width="80">
			</div>
			<div class="row center m50">
				<h1>리워드 추가하기</h1>
			</div>
			<div class="row right">
				<button type="button" class="btn btn-addReward">
					리워드 추가 <span>+</span>
				</button>
			</div>
			<h3>리워드1</h3>
			<div class="row m20">
				<label>리워드 이름</label> <input type="text" name="rewardName"
					class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="5" class="form-input fill"></textarea>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> <input type="number" name="rewardPrice"
					class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 재고</label> <input type="number" name="rewardStock"
					class="form-input fill">
			</div>
			<h3 class="reward-num"></h3>
			<div id="add-reaward"></div>
			<div class="row center m20">
				<button type="button" class="btn btn-prev">이전 단계</button>
				<button type="button" class="btn btn-next">다음 단계</button>
			</div>
			<hr>
			<div class="row">
				<input type="submit" value="프로젝트 신청하기" class="btn fill">
			</div>
		</div>
	</form>
	<jsp:include page="/template/footer.jsp"></jsp:include>