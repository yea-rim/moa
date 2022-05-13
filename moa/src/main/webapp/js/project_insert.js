$(function() {	
		fundingDays();		
	
	
		//멀티페이지 구현
		var index = 0;
		move(index);

		//다음페이지 이동 시 빈칸 검사 & 다음 페이지로 이동
		$(".btn-next").each(function(){
			$(this).click(function(){
			var count = 0;
			var target = $(this).parent("div").parent(".page").find(".checkValue");
				target.each(function(){
					target
					if($(this).val()==""){
						count++;
					}
				});
				if(count>0){
					alert("필수 사항을 모두 입력해주세요");
					return false;			
				}else if($("input[name=projectTargetMoney]").val()<500000){
					alert("목표 금액을 50만원 이상으로 설정해주세요.")
					return false;
				}else{
					move(++index);
					
				}
			});
		});

		//이전 버튼을 누르면 이전 페이지가 나오도록 구현
		$(".btn-prev").click(function() {
			move(--index);
		});

		function move(index) {
			$(".page").hide();
			$(".page").eq(index).show();
			var percent = (index + 1) * 100 / 2;
			$(".percent").css("width", percent + "%");
		}

		//필수 입력사항 메세지 보여주기
		$(document).on("blur",".checkValue",checkValue);
		$("input[name=projectTargetMoney]").blur(checkProjectTargetMoney);
		
			
		//입력한 값이 있는지
		function checkValue(){
			if($(this).val()==""){
				$(this).next('span').text("필수 입력 사항입니다.");
			}else{
				$(this).next('span').text("");				
			}				
		}
		
	
		
		//펀딩 금액 체크 		
		function checkProjectTargetMoney() {
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
					minDate : '+3D'
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
					minDate : '+4D' //내일부터 선택가능, 지정형식 예(+1D +1M +1Y)
				}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this)); //시작일의 maxDate 지정
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
				if (element.id == 'start') {
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


		
		//리워드 추가 함수
		function addReaward(rewardNum) {
			var div = $("<div>").attr('class', 'reward'+rewardNum+" row m30");
			var h3 = $("<h3>* 리워드" + rewardNum + "</h3>");
	var content = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="rewardName" class="form-input fill checkValue"><span class="f12 red"></span></div>\
                    <div class="row m20"><label>리워드 내용</label> <textarea name="rewardContent" rows="5" class="form-input fill checkValue"></textarea><span class="f12 red"></span></div>\
                    <div class="row m20"><label>리워드 가격</label> <input type="number" name="rewardPrice" class="form-input fill checkValue"><span class="f12 red"></span></div>\
                    <div class="row m20"><label><div class="row"><label>리워드 재고</label></div></label> <input type="number" name="rewardStock" class="form-input w80p checkValue"><span class="f12 red"></span>\
					<input type="checkbox" class="form-input ckbox" id="optionck"><input type="hidden" name="rewardIsOption" value="0"><label class="f12 gray" for="optionck">상세 옵션 여부</label></div>\
					<div class="row m20"><div class="row"><label>배송비</label></div><input type="number" name="rewardDelivery" class="form-input w80p checkValue">\
					<input type="checkbox" class="form-input ckbox"><input type="hidden" name="rewardEach" value="0"><label class="f12 gray">개별 배송 여부</label></div>');
	
			div.append(h3).append(content);
			$("#add-reward").append(div);
			$(".btn-delReward").show(); //리워드 추가시 빼기버튼 보여주기
		}
	
		rewardNum = 2;
		//리워드 추가버튼 클릭 시 내용 추가
		$(".btn-addReward").click(function() {
			addReaward(rewardNum);
			rewardNum++;
			console.log(rewardNum)
		});
		
		//추가한 리워드 삭제
		$(".btn-delReward").click(function(){
			rewardNum--;
			$("#add-reward").children(".reward"+rewardNum).remove();			
		if(rewardNum==2){
			$(".btn-delReward").hide();
		}
		});
		
		//리워드 빼기 버튼 숨기기
		$(".btn-delReward").hide();
		
		

		//개별 배송 여부 체크 시 
		$("input[name=rewardEach]").on("input",function(){
			if($(this).prop("checked")){
				$(this).attr("value","1");
				console.log("ok");
			}else{
				$(this).attr("value","0");
			}
		});
		
		//파일 숨김
		$(".btn-del").parent("div").hide();

		//파일추가
		$(".btn-add").click(function(){
			var target =$(this).next().next('div');
			if(target.css('display')=='none'){
				target.show();
				target.children('input').removeAttr('disabled');
				target.children('input').attr("class","checkValue");
			}
			else{
				target.next('div').show();
				target.next('div').children('input').removeAttr('disabled');
				target.next('div').children('input').attr("class","checkValue");
			}
		});


		//파일삭제
		$(".btn-del").each(function(){
			$(this).click(function(){
				$(this).parent("div").hide();
				$(this).parent("div").children("input").attr("disabled","disabled");
				$(this).parent("div").children("input").removeAttr("class","checkValue");
			});
		});
		

		
			
			
	//프로젝트명 글자수 자르기
	$('input[name=projectName]').on("input",
	function(){
		var count = $(this).val().length; 
			if(count>50){
				$(this).val($(this).val().substring(0,50));
			}
	});

	//프로젝트 요약글 글자수 자르기
	$('textarea[name=projectSummary]').on("input",
	function(){
		var count = $(this).val().length; 
			if(count>200){
				$(this).val($(this).val().substring(0,200));
			}
	});
	
	//리워드 이름 글자수 자르기
	$('input[name=rewardName]').on("input",
	function(){
		var count = $(this).val().length; 
			if(count>30){
				$(this).val($(this).val().substring(0,30));
			}
	});

	//리워드 내용 글자수 자르기
	$('textarea[name=rewardContent]').on("input",
	function(){
		var count = $(this).val().length; 
			if(count>100){
				$(this).val($(this).val().substring(0,100));
			}
	});
	
	//체크박스 체크 시  값 설정
	$(document).on("input",".ckbox",function(){
			if ($(this).is(":checked")) {
				console.log(1);
			    $(this).next().attr("value","1");
			} else {
			     $(this).next().attr("value","0");
			}
		});
		
	//전송 시 확인
	$(".insert-form").submit(function(){
			var count = 0;
			var target = $(this).find(".checkValue");
				target.each(function(){
					if($(this).val()==""){
						count++;
					}
				});
				if(count>0){
					alert("필수 사항을 모두 입력해주세요");
					return false;			
				}else if($("input[name=projectTargetMoney]").val()<500000){
					alert("목표 금액을 50만원 이상으로 설정해주세요.")
					return false;
				}else{
					return true;		
				}
	});
		
			
	});