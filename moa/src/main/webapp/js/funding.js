$(function () {
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


    //다음단계버튼 클릭 시 체크된 항목 리스트에 나타내기 총배송비 최종결제금액 계산해서 나타내기

    $("#nextstep").click(function () {

        var deliveryTotal = 0;
        var fundingTotal = 0;
        var count = 0;
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
                var semiTotal = amount * price;
                fundingTotal += semiTotal;

                $(div).find(".reward-checklist-name").html("<br>" + title);
                $(div).find(".reward-checklist-content").html("<br>" + content + "<br>");
                $(div).find(".reward-checklist-pirce").html("수량 : " + amount + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가격 : " + semiTotal + "<hr>");
                $(div).find(".reward-checklist-pirce").children("hr").css("background-color", "rgb(214, 202, 202)");
                $(div).find(".reward-checklist-pirce").children("hr").css("border", "none");
                $(div).find(".reward-checklist-pirce").children("hr").css("height", "0.5px");
                // console.log(div);

                var delivery = $(this).parent("div").parent("div").find(".delivery");
                console.log(delivery)
                console.log(delivery.data("value"));
                if (delivery.data("value") == 1) {
                    deliveryTotal += parseInt(delivery.text()) * amount;
                } else if (delivery.data("value") == 0 && count < 1) {
                    deliveryTotal += parseInt(delivery.text());
                    count++;
                }
            }
        });
        $("#funding-total").text(fundingTotal + "원");
        $("#delivery-total").text(deliveryTotal + "원");

        $("#final").text(deliveryTotal + fundingTotal + "원");

        $('html').scrollTop(0);
    });

    //이전단계 버튼 누르면 넘어왔던 리워드 리스트 초기화
    $("#prevstep").click(function () {
        $("#reward-checklist").children("div").each(function () {
            $(this).empty();
        });
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
            var count = $(this).prev("input");
            $(this).prev("input").val(parseInt(count.val()) + 1);
            total();
        });
    });

    // 주문수량에 맞춰서 총가격을 구하는 함수
    function total() {
        var total = 0;
        $(".reward-checkbox").each(function () {

            var price = $(this).parent(".check-reward").parent(".reward-select").find(".reward-price").text();
            // console.log(price);
            var amount = $(this).parent(".check-reward").parent(".reward-select").find("input[name=selectionRewardAmount]").val();
            // console.log(amount);

            if ($(this).is(":checked")) {
                total += parseInt(price) * parseInt(amount);
                // console.log(total);
            }
        });
        $("#total-price").text(total);
    }


});