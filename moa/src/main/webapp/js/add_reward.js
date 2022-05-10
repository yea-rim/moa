$(function() {	
	//거절 메세지 숨기기
	$(".refuse-msg").hide();
	
	//거절 메세지 토글처리
	$(".btn-refuse").click(function() {
		$(".refuse-msg").toggle();
	});
	
	//개별 배송 여부 체크
	$(".rewardEach-cb").each(function(){
		if($(this).attr("value")==1){
		$(this).attr("checked","checked");
	}
	});
			
	//리워드추가 함수
	function addReaward(rewardNum) {
		var div = $("<div>").attr('class', 'reward'+rewardNum+" row m30");
		var h3 = $("<h3>* 리워드 추가</h3>");
			var content = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="addRewardName" class="form-input fill"></div>\
	                <div class="row m20"><label>리워드 내용</label> <textarea name="addRewardContent" rows="5" class="form-input fill"></textarea></div>\
	                <div class="row m20"><label>리워드 가격</label> <input type="number" name="addRewardPrice" class="form-input fill"></div>\
	                <div class="row m20"><label>리워드 재고</label> <input type="number" name="addRewardStock" class="form-input fill"></div>\
	                <div class="row m20"><div class="row"><label>배송비</label></div><input type="number" name="addRewardDelivery" class="form-input w80p" value="0">\
					<input type="checkbox" class="form-input each-ckbox" value="1"><input type="hidden" name="addRewardEach" value="0"><label class="f12 gray">개별 배송 여부</label></div>');
					
		div.append(h3).append(content);
		$("#add-reward").append(div);
		$(".btn-delReward").show();
	}

	rewardNum = 2;
	//리워드 추가버튼 클릭 시 내용 추가
	$(".btn-addReward").click(function() {
		addReaward(rewardNum);
		rewardNum++;
		console.log(rewardNum);
		
	});
	
	//추가한 리워드 삭제
	$(".btn-delReward").click(function(){
		rewardNum--;
		$("#add-reward").children(".reward"+rewardNum).remove();
		console.log(rewardNum)
	});	
	
	
	//개별 배송여부 체크 시 value값 수정
	$(".each-ckbox").on("input",function(){
			if ($(this).is(":checked")) {
			    $(this).next().attr("value","1");
			} else {
			     $(this).next().attr("value","0");
			}
	});
	
	//체크박스 값 설정
	$(".each-ckbox").each(function(){
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
	
	//삭제 기본 이벤트 차단
	$(".del").click(function() {
		return confirm("정말 삭제 하시겠습니까?");
	});
});