$(function () {
	var index = 0;
    move(index);
        
	function move(index){
         $(".page").hide();
         $(".page").eq(index).show();
     };
	
	$(".number").each(function(){
		$(this).text(withCommas(parseInt(($(this).text()))));
	})
	
	function withCommas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	function withoutCommas(num) {
	return num.toString().replace(",", '');
	}
	
    $(".detail").hide();
    $(".reward-select").find("input[type=text]").attr("disabled", true);
	
	// 넘어올 때 누른 리워드의 파라미터 번호를 받아서 넘어오면 체크가 돼있게 설정
	var rewardCount = new URL(window.location.href).searchParams.get("rewardCount");
	$(".reward-checkbox").each(function(){
		if($(this).parent("div").parent("div").children(".rewardCount").text() == rewardCount){
			$(this).attr("checked", true);
			
			
			check.call(this);
		}
	});
	
	
	
    //체크박스를 체크하면 수량과 상세옵션창이 등장 // 수량 상세옵션창 disabled 전환
    $(".reward-checkbox").each(function () {
        $(this).on("input", check);
    });
    
    
    //체크박스 체크시 가격정보등 계산함수
    function check() {
            var detail = $(this).parent("div").parent("div").find(".detail");
            var rewardNo = $(this).val();
            var createDiv = $("<div>").attr("class", "reward" + rewardNo);
            var div = $("div[class=" + "reward" + rewardNo + "]");

            if ($(this).is(":checked")) {
                $(this).parent("div").parent(".reward-select").find("input[type=text]").attr("disabled", false);
                $(this).parent("div").parent(".reward-select").addClass("is-check");
                $("#reward-checklist").append(createDiv);
                detail.show();
            } else {
                $(this).parent("div").parent(".reward-select").find("input[type=text]").attr("disabled", true);
                $(this).parent("div").parent(".reward-select").removeClass("is-check");
                detail.find("input[name=selectionRewardAmount]").val(1);
                detail.find("input[name=selectionOption]").val("");
                $(div).remove();
                detail.hide();
            }

            total();
        };


    //다음단계버튼 클릭 시 체크된 항목 리스트에 나타내기 총배송비 최종결제금액 계산해서 나타내기 체크안됐을때 못넘어가게 막음

    $("#nextstep").click(function () {

        var deliveryTotal = 0;
        var fundingTotal = 0;
        var count = 0;
        var checkCount = 0;
        var optionCount = 0;
        $(".reward-checkbox").each(function () {
            if ($(this).is(":checked")) {
                var rewardNo = $(this).val();
                var div = $("div[class=" + "reward" + rewardNo + "]");
                var rewardChecklistName = $("<div>").attr("class", "reward-checklist-name");
                var rewardChecklistContent = $("<div>").attr("class", "reward-checklist-content");
                var rewardChecklistPrice = $("<div>").attr("class", "reward-checklist-pirce right");
                $(div).append(rewardChecklistName).append(rewardChecklistContent).append(rewardChecklistPrice);


                // console.log(this);
                var title = $(this).parent("div").parent("div").find(".reward-title").html();
                var content = $(this).parent("div").parent("div").find(".reward-content").html();
                var amount = $(this).parent("div").parent("div").find("input[name=selectionRewardAmount]").val();
                var price = $(this).parent("div").parent("div").find(".reward-price").html();
                var semiTotal = amount * parseInt(withoutCommas(price));
                fundingTotal += semiTotal;

                $(div).find(".reward-checklist-name").html("<br>" + title);
                $(div).find(".reward-checklist-content").html("<br>" + content + "<br>");
                $(div).find(".reward-checklist-pirce").html("수량 : " + amount + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가격 : " + withCommas(semiTotal) + "<hr>");
                $(div).find(".reward-checklist-pirce").children("hr").css("background-color", "rgb(214, 202, 202)");
                $(div).find(".reward-checklist-pirce").children("hr").css("border", "none");
                $(div).find(".reward-checklist-pirce").children("hr").css("height", "0.5px");
                // console.log(div);

                var delivery = $(this).parent("div").parent("div").find(".delivery");
                /*console.log(delivery)
                console.log(delivery.data("value"));*/
                checkCount++;
                if (delivery.data("value") == 1) {
                    deliveryTotal += parseInt(withoutCommas(delivery.text())) * amount;
                } else if (delivery.data("value") == 0 && count < 1) {
                    deliveryTotal += parseInt(withoutCommas(delivery.text()));
                    count++;
                }
                var selectionOption = $(this).parent("div").parent(".reward-select").find("input[name=selectionOption]").val();
                console.log(selectionOption);
                if(selectionOption != ""){
					optionCount++;
				}
            }
        });
        if(checkCount == 0){
			alert("최소 한개 이상을 후원하여야 진행할 수 있습니다.");
		}else if(optionCount < checkCount){
			alert("상세 옵션을 입력해주세요.");
		}else{        
        $("#funding-total").text(withCommas(fundingTotal) + "원");
        $("#delivery-total").text(withCommas(deliveryTotal) + "원");

        $("#final").text(withCommas(deliveryTotal + fundingTotal) + "원");

        move(++index);
        $('html').scrollTop(0);
		}
    });

    //이전단계 버튼 누르면 넘어왔던 리워드 리스트 초기화
    $("#prevstep").click(function () {
        $("#reward-checklist").children("div").each(function () {
            $(this).empty();
        });
        move(--index);
        $('html').scrollTop(0);
    });



    //수량 감소버튼
    $(".minus-btn").each(function () {
        $(this).click(function () {
            var count = $(this).next("input");
            if (count.val() > 1) {
                count.val(parseInt(count.val()) - 1);
            } else {
                alert("최소 수량은 1개 입니다.");
            }
            total();
        });

    });

    //수량증가버튼
    $(".plus-btn").each(function () {
        $(this).click(function () {
			var stock = parseInt($(this).parents(".reward-select").find(".reward-stock").text());
			console.log(stock);
            var count = $(this).prev("input");
            count.val(parseInt(count.val()) + 1);
			if(count.val() > stock){
				alert("재고가 부족합니다");
				count.val(stock);
			}
            total();
        });
    });
    
    //수량 입력 재고 체크
    $("input[name=selectionRewardAmount]").each(function(){
		var count = $(this);
		var stock = parseInt($(this).parents(".reward-select").find(".reward-stock").text());
		$(this).blur(function(){
		console.log(count.val());
		console.log(stock);
			if(count.val() > stock){
				alert("재고 수량을 초과 했습니다.");
				count.val(stock);
			}
			total();
		});
	});
    

    // 주문수량에 맞춰서 총가격을 구하는 함수
    function total() {
        var total = 0;
        $(".reward-checkbox").each(function () {

            var price = withoutCommas($(this).parent(".check-reward").parent(".reward-select").find(".reward-price").text());
             /*console.log(price);*/
            var amount = $(this).parent(".check-reward").parent(".reward-select").find("input[name=selectionRewardAmount]").val();
             /*console.log(amount);*/

            if ($(this).is(":checked")) {
                total += parseInt(price) * parseInt(amount);
                /*console.log(total);*/
            }
        });
        
        $("#total-price").text(withCommas(total));
    }
    
    //입력될 정보가 모두 입력됐는지 체크
	/*$(".check").each(checkInfo);*/
	/*function checkInfo2(){
		$(this).blur(function(){
			if($(this).val()==""){
				$(this).parent("div").prev("div").children(".check-empty").show();
				return false;
			}else{
				$(this).parent("div").prev("div").children(".check-empty").hide();
				return true;
			}
		});
	};*/
	
	
	// 상태관리용 객체
	var status = {
                getter : false,
                phone : false,
                address : false,
                checkBox : false
            }
	
	//주소 입력 체크
	$(".check-address").each(checkAddress);
	function checkAddress(){
		$(this).blur(function(){
			var count = 0;
				$(".check-address").each(function(){
					if($(this).val()==""){
						count++;
					}
				});
			if(count > 0){
				$(this).parent("div").parent("div").prev("div").children(".check-empty").show();
				status.address = false;
			}else{
				$(this).parent("div").parent("div").prev("div").children(".check-empty").hide();
				status.address = true;
			}
		});		
	};
	
	
	
	//수령인 이름 정규식 검사
	$("input[name=fundingGetter]").blur(checkGetter);
	
	function checkGetter(){
		var regex = /^[가-힣a-zA-z]{2,10}$/;
		var text = $(this).val();
		
		var judge = regex.test(text);
		
		if(!judge){
			$(this).parent("div").prev("div").children(".check-regex").show();
			status.getter = false;
		}else{
			$(this).parent("div").prev("div").children(".check-regex").hide();
			status.getter = true;
		}
	};
    
    //전화번호 정규식 검사
    $("input[name=fundingPhone]").blur(checkPhone);
    function checkPhone(){
		var regex = /^010[1-9][0-9]{3}[0-9]{4}$/;
		var text = $(this).val();
		
		var judge = regex.test(text);
		
		if(!judge){
			$(this).parent("div").prev("div").children(".check-regex").show();
			status.phone = false;
		}else{
			$(this).parent("div").prev("div").children(".check-regex").hide();
			status.phone = true;
		}
	};
	
	//후원 목록 한개 이상 체크했는지 검사
	function checkInfo(){
		var count = 0;
			if($(this).is(":checked")){
				count++;
			}
		return count;
	};
    
    
    // 들어와야할 정보가 전부 입력됐는지 최종 검사
   	$(".reserve-formcheck").submit(function(){
		var count = 0;
		$(".reward-checkbox").each(function(){
			count += checkInfo.call(this);
		});
		var judge = count > 0;
		/*console.log(status.getter);
		console.log(status.phone);
		console.log(status.address);
		console.log(judge);*/
		if(judge && status.getter && status.phone && status.address){
			return true;
		}else{
			alert("정보를 올바르게 입력해주시기 바랍니다.");
			return false;
		}
	});
	
	
	

});