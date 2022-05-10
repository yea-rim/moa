$(function() {	
		fundingDays();
		$(".btn-delReward").hide();
	
		var index = 0;
		move(index);
		//다음 버튼을 누르면 다음 페이지가 나오도록 구현
		$(".btn-next").not(":last").click(function() {
			move(++index);
		});

		//이전 버튼을 누르면 다음 페이지가 나오도록 구현
		$(".btn-prev").not(":first").click(function() {
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
			var div = $("<div>").attr('class', 'reward'+rewardNum+" row m30");
			var h3 = $("<h3>* 리워드" + rewardNum + "</h3>");
			var content = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="rewardName" class="form-input fill"></div>\
	                <div class="row m20"><label>리워드 내용</label> <textarea name="rewardContent" rows="5" class="form-input fill"></textarea></div>\
	                <div class="row m20"><label>리워드 가격</label> <input type="number" name="rewardPrice" class="form-input fill"></div>\
	                <div class="row m20"><label>리워드 재고</label> <input type="number" name="rewardStock" class="form-input fill"></div>\
	                <div class="row m20"><div class="row"><label>배송비</label></div><input type="number" name="rewardDelivery" class="form-input w80p">\
					<input type="checkbox" class="form-input each-ckbox"><input type="hidden" name="rewardEach" value="0"><label class="f12 gray">개별 배송 여부</label></div>');
	
			div.append(h3).append(content);
			$("#add-reward").append(div);
			$(".btn-delReward").show();
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
			console.log(rewardNum)
		});


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
			}
			else{
				target.next('div').show();
				target.next('div').children('input').removeAttr('disabled');
			}
		});


		//파일삭제
		$(".btn-del").each(function(){
			$(this).click(function(){
				$(this).parent("div").hide();
				$(this).parent("div").children("input").attr("disabled","disabled");
			});
		});
		
		
		//펀딩 금액 체크 메세지
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
		
			
		//글자수 표시
		$(".text-length").on("input",textLen);
		function textLen(){			
			var size = $(this).val().length;
			var target=$(this).next(".length").children(".count")
			target.text(size);

			var len = $(this).data("len");
			if(size>len){
					target.css("color","red");
					target.next().css("color","red");
                }
                else{
                    target.css("color","gray");
					target.next().css("color","gray");
                }
		}	
		

		//글자수 체크 메세지
		$(".text-length").blur(function(){
			var len = $(this).data("len");
			var val = $(this).val().length;
			var judge = val <= len;

			if(judge){
				$(this).next(".length").children(".msg").text($(this).data("success-msg"));
			}
			else {
				$(this).next(".length").children(".msg").text($(this).data("fail-msg"));
			}
        });
        
        	//개별 배송여부 체크 시 value값 수정
	$(".each-ckbox").on("input",function(){
			if ($(this).is(":checked")) {
			    $(this).next().attr("value","1");
			} else {
			     $(this).next().attr("value","0");
			}
	});
	
	//추가한 리워드 체크박스 값 설정
	$(document).on("input",".each-ckbox",function(){
			if ($(this).is(":checked")) {
			    $(this).next().attr("value","1");
			} else {ㄴ
			     $(this).next().attr("value","0");
			}
		});
			
	});