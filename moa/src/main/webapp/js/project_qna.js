$(function () {
    // 문의글 리스트 누르면 내용 나옴
    // 문의글 리스트 눌렀는데 비밀글이면 경고 표시
    $(".table-title").each(function () {
        var secret = $(this).children(".secret");
        if (secret.attr("value") == "1") {
            $(this).click(function () {
                var content = $(this).parent("tr").next(".qna-content");
                if (content.is(":visible")) {
                    content.hide();
                } else {
                    content.show();
                }
            });
        }else {
            $(this).click(function () {
                alert("작성자만 볼 수 있습니다.");
            });
        }
    });
    
    // 삭제하기 확인버튼 숨김처리 클릭시 보이게
    
	
	$(".delete-confirm").hide();
		$(".delete-btn").each(function(){
			var confirm = $(this).parent("div").parent("td").children(".delete-confirm");
			$(this).click(function(){
				confirm.show();
			});
		});
		
		$(".cancel-delete").each(function(){
			$(this).click(function(){
				$(this).parent(".delete-confirm").hide();
			});
		});
		
		$(".no-auth").click(function(){
			alert("권한이 없습니다.");
		});

    // 문의하기 답글 숨김 처리
    $(".qna").hide();
    $(".btn-qna").click(function(){
        $(".qna").show();
    });
    $(".hide-qna").click(function(){
        $(".qna").hide();
    });
	
    $(".answer").hide();
    $(".btn-answer").each(function(){
        var answer = $(this).parent("div").parent("td").children(".answer");
        

        $(this).click(function(){
            answer.show();
        });
    });
    
    $(".hide-answer").each(function(){
        var answer = $(this).parent("div").parent("form").parent(".answer");
        $(this).click(function(){
            answer.hide();
        });
    });


    // 작성자 이메일 마스킹
    $(".writer").each(function(){
        var regex = /./g;
        var text = $(this).text().trim();
        var index = text.indexOf("@");
        var one = text.substring(0,index);
        var two = text.substring(index);
        var three = one.substring(3).replace(regex,"*");
        one = one.substring(0, 3);
        
        // var one = $(this).text().substring  

		//console.log("one", one, "two", two, "three", three);

        var result = one + three + two;
        $(this).text(result);
    });

    // 비밀글 숨기기
    /*if($("#hide-secret").is(":checked")){
        $(".secret").each(function(){
            if($(this).text() == 1){
                $(this).parent("td").parent("tr").hide();
            }
        });
    }*/
    $("#hide-secret").on("input", function(){
		var projectNo = new URL(window.location.href).searchParams.get("projectNo");
        if($(this).is(":checked")){
                location.replace("/moa/project/detail/qna.jsp?secret=1&projectNo=" + projectNo);
        }else{
                location.replace("/moa/project/detail/qna.jsp?projectNo=" + projectNo);
		}
    })
    
    //페이지네이션 링크 클릭시 비밀글 숨김처리 상태면 유지
    $(".pagination").children("a").each(function(){
        
        $(this).click(function(){
            console.log($(this).attr("href"));
            if($("#hide-secret").is(":checked")){
                $(this).attr("href", $(this).attr("href") + "&secret=1");             
            }
        });
    });
    
});