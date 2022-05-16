$(function() {
	
	// 작성중 페이지 이탈 방지
    var checkUnload = true;
    $(".board-submit").on("click", function () {
      checkUnload = false;
    });
    
    $(window).on("beforeunload", function () {
      if (checkUnload) {
        return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
      }
    });
      
    // null 검사 
    $(".form-all").on("submit", function () {
        if (vali($(".board-title").val())) {
          alert("제목을 입력해주세요");
           return false;
      } 
       else {
           return true;
         }
    });
	
	 $(".form-all").on("submit", function () {
          if (vali($(".board-content").val())) {
            alert("내용을 입력해주세요");
            return false;
          } 
          else {
            return true;
          }
        });
	 
	 function vali(val) {
          if (val === null) return true;
          if (val === "") return true;
          if (typeof val === "undefined") return true;

          return false;
        }
	
	// 글자수 제한 
	$(".board-title").on("input", function() {
		var content = $(this).val();
		var length = content.length;

		while (length > 30) {
			$(this).val($(this).val().substring(0, length - 1));
			length--;
		}
	});

	$(".board-content").on("input", function() {
		var content = $(this).val();
		
		/* var text = content.replace("\r\n", "<br>");
		$(this).val(text); */
		
		var length = content.length;
		
		while (length > 1300) {
			$(this).val($(this).val().substring(0, length - 1));
			length--;
		}
	});

	// 파일명 input에 출력하는 JS
	$("#file1").on('change', function() {
		var fileFullName = $("#file1").val();
		var fileName = fileFullName.substring(12, fileFullName.length);
		$(".upload-name1").val(fileName);
	});
	
	$("#file2").on('change', function() {
		var fileFullName = $("#file2").val();
		var fileName = fileFullName.substring(12, fileFullName.length);
		$(".upload-name2").val(fileName);
	});
});