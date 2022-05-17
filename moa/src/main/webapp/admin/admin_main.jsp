<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	$(function() {
		//후원금 현황 차트
		$.ajax({
			url : "<%=request.getContextPath()%>/ajax/funding_chart.do",
			type : "post",
			success : function(resp) {
				//label: x축에 표시될 항목들
				var labels = [];
				for (var i = 0; i < resp.length; i++) {
					labels.push(resp[i].fundingDate);
				}

				var cnt = [];
				for (var i = 0; i < resp.length; i++) {
					cnt.push(resp[i].total);
				}

				//data : 차트에 표시될 데이터
				var data = {
					labels : labels,
					datasets : [ {
						label : '일별 후원 총 금액', //범례
						backgroundColor : '#B899CD', //배경색
						data : cnt, //데이터
					} ]
				};
				//차트의 형태 등을 설정(옵션,환경설정)
				var config = {
					type : 'bar', //차트의모양
					data : data, //차트데이터
					options : {}
				};

				//차트 생성 구문
				var myChart = new Chart(
						document.querySelector('#fundingChart'), //차트 적용 대상
						config //차트 옵션
				);
			}
		});
		//가입경로 차트
		$.ajax({
			url : "<%=request.getContextPath()%>/ajax/join_chart.do",
			type : "post",
			success : function(resp) {
				//label: x축에 표시될 항목들
				var labels = [];
				for (var i = 0; i < resp.length; i++) {
					labels.push(resp[i].memberRoute);
				}

				var cnt = [];
				for (var i = 0; i < resp.length; i++) {
					cnt.push(resp[i].cnt);
				}

				//data : 차트에 표시될 데이터
				var data = {
					labels : labels,
					datasets : [ {
						label : '친구추천', //범례
						backgroundColor : [ "#a29bfe", "#ffeaa7", "#fab1a0",
								"#74b9ff", "#b8e994" ], //배경색
						data : cnt, //데이터
					} ]
				};
				//차트의 형태 등을 설정(옵션,환경설정)
				var config = {
					type : 'doughnut', //차트의모양
					data : data, //차트데이터
					options : {}
				};

				//차트 생성 구문
				var myChart = new Chart(document.querySelector('#joinChart'), //차트 적용 대상
				config //차트 옵션
				);
			}
		});
	});
</script>
<div class="container w700 m30">
	<div class="row center m50 mb30">
		<h1>일별 후원금 현황</h1>
	</div>
	<div class="row">
		<canvas id="fundingChart"></canvas>
	</div>
	<br><hr><br>

	<div class="container w500 m30">
		<div class="row center m50">
			<h1>회원 가입 경로</h1>
		</div>
		<div class="row">
			<canvas id="joinChart"></canvas>
		</div>
	</div>
</div>

<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>
