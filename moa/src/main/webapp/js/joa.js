$(function(){
	
	
    function joa() {
        var projectNo = new URL(window.location.href).searchParams.get("projectNo");
        $.ajax({
            url:  context + "/ajax/joa.do?projectNo=" + projectNo,
            type: "get",
            success: function (resp) {
                if (resp == "insert") {
                    var count = parseInt($("#joa-count").text().trim());
                    $("#joa-count").text(count + 1);
                    $("#joa-btn").removeClass("btn-reverse");
                    console.log(resp);
                } else if (resp == "delete") {
                    var count = parseInt($("#joa-count").text().trim());
                    $("#joa-count").text(count - 1);
                    $("#joa-btn").addClass("btn-reverse");
                   	console.log(resp);
                } else if (resp == "login") {
                    alert("로그인 해주세요");
                }
            },
            error: function () {
                alert("오류");
            }
        });
    };


    $("#joa-btn").click(function () {
        joa();
    });
});