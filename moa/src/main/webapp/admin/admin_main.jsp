<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script >
$(function () {
    //차트는 시작하자마자 화면에 표시되어야 한다.
    //->시작하자마자 서버에 비동기통신 요청을 보내서 데이터를 가져와야 한다.
    //->가져온 데이터에서 제목과 내용을 분리해서 설정한다.
    //->(중요) 통신이 끝나야 차트가 나올 수 있다.
    $.ajax({
        url: "http://localhost:8080/study/ajax/chart.do",
        type: "post",
        //data: {},
        success: function (resp) {
            //차트 생성
            //console.log(resp);


            //label: x축에 표시될 항목들
            var labels = [];
            for (var i = 0; i < resp.length; i++) {
                labels.push(resp[i].year);
            }

            var cnt = [];
            for (var i = 0; i < resp.length; i++) {
                cnt.push(resp[i].year);
            }

            //data : 차트에 표시될 데이터
            var data = {
                labels: labels,
                datasets: [{
                    label: '가입 인원수', //범례
                    backgroundColor: 'rgb(255, 99, 132)', //배경색
                    borderColor: 'rgb(255, 99, 132)', //테두리색
                    data: cnt, //데이터
                }]
            };

            //차트의 형태 등을 설정(옵션,환경설정)
            var config = {
                type: 'bar', //차트의모양
                data: data, //차트데이터
                options: {}
            };

            //차트 생성 구문
            var myChart = new Chart(
                document.querySelector('#myChart'), //차트 적용 대상
                config //차트 옵션
            );
        }
    });
});
</script>
    <div class="container w500 m30">
        <div class="row center m30">
            <h1>상반기 판매 현황</h1>
        </div>
        <div class="row">
            <canvas id="myChart"></canvas>
        </div>
    </div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>
