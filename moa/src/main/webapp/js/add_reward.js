$(function() {	
	
	//리워드추가 함수
	function addReaward(rewardNum) {
		var div = $("<div>").attr('class', 'reward'+rewardNum+" row m30");
		var h3 = $("<h3>* 리워드 추가</h3>");
		var content = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="addRewardName" class="form-input fill"></div>\
                <div class="row m20"><label>리워드 내용</label> <textarea name="addRewardContent" rows="5" class="form-input fill"></textarea></div>\
                <div class="row m20"><label>리워드 가격</label> <input type="number" name="addRewardPrice" class="form-input fill"></div>\
                <div class="row m20"><label>리워드 재고</label> <input type="number" name="addRewardStock" class="form-input fill"></div>');

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
	
	
	
	
	
	
});