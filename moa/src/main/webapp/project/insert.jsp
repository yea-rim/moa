<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
    <script type="text/javascript"> 
         $(function(){
            var index = 0;
            move(index);

            //다음 버튼을 누르면 다음 페이지가 나오도록 구현
            $(".btn-next").not(":last").click(function(){
                //index++;
                move(++index);
            });

            //이전 버튼을 누르면 다음 페이지가 나오도록 구현
            $(".btn-prev").not(":first").click(function(){
                //index--;
                move(--index);
            });

            function move(index) {
                $(".page").hide();
                $(".page").eq(index).show();
                var percent = (index+1) * 100 /2;
                $(".percent").css("width",percent+"%");
            }

			function addReaward(){
				var div =  $("<div>").attr('class','row');
				
				
				var btn =$('<div class="row m20"><button type="button" class="btn btn-minus"><span>-</span>리워드 삭제</button></div>')
				var name = $('<div class="row m20"><label>리워드 이름</label> <input type="text" name="rewardName" class="form-input fill"></div>'); 
				var content = $('<div class="row m20"><label>리워드 내용</label> <textarea name="rewardContent" rows="13" class="form-input fill"></textarea></div>'); 
				var price = $('<div class="row m20"><label>리워드 가격</label> <input type="number" name="rewardPrice" class="form-input fill"></div>'); 
				var stock = $('<div class="row m20"><label>리워드 재고</label> <input type="number" name="rewardStock" class="form-input fill"></div><hr>'); 

				div.append(name);
				div.append(content);
				div.append(price);
				div.append(stock);
				$("#add-reaward").append(div);
				
			}


			//리워드 추가버튼 클릭 시 내용 추가
			$(".btn-add").click( function() {
				rewardNum = 2;

				$(".reward-num").text("리워드"+rewardNum);
				addReaward();
				
			});
        });
    </script>
</head>
<body>
	<div class="container w600">
		<div class="row float-container">
			<div class="float-left layer-3">
				<a href="">
					프로젝트 정보 입력
				</a>
			</div>
			<div class="float-left layer-3">
				<a href="">
					프로젝트 상세 파일
				</a>
			</div>
			<div class="float-left layer-3">
				<a href="">
					리워드 추가
				</a>
			</div>
		</div>
	</div>
	



<!--프로젝트 입력 페이지-->
	<form action="insert.do" method="post" enctype="multipart/form-data">
		<div class="container w600 m30 page">
		 	<div class="row center m50">
		 		<h1>프로젝트 기본 입력</h1>
		 	</div>
			<div class="row m20">
				<label>카테고리</label>
				<select name="projectCategory" class="form-input fill">
					<option value="">선택</option>
					<option>패션/잡화</option>
					<option>뷰티</option>
					<option>푸드</option>
					<option>홈/리빙</option>
					<option>테크/가전</option>
					<option>기타</option>
				</select>
			</div>
			<div class="row m20">
				<label>프로젝트명</label> 
				<input type="text" name="projectName" class="form-input fill">
			</div>
			<div class="row m20">
				<label>프로젝트 요약글</label>
				<textarea name="projectSummary" rows="13" class="form-input fill"></textarea>
			</div>
			<div class="row m20">
				<label>펀딩 목표 금액</label> 
				<input type="number" name="projectTargetMoney" class="form-input fill">
			</div>
            <div class="row center">
                <button type="button" class="btn btn-prev">이전 단계</button>
                <button type="button" class="btn btn-next">다음 단계</button>
            </div>
		</div>

		<!--프로젝트 날짜, 파일 선택-->
			<div class="container w600 m30 page">
				 <div class="row center m50">
					 <h1>프로젝트 상세 선택</h1>
				 </div>
				<div class="row m20">
					<label>펀딩 시작일</label> 
					<input type="date" name="projectStartDate">
				</div>
				<div class="row m20">
					<label>펀딩 마감일</label> 
					<input type="date" name="projectSemiFinish">
				</div>
				<div class="row m20">
					<label>프로젝트 최종 마감일</label> 
					<input type="date" name="projectFinishDate">
				</div>
				<div class="row m20">
					<label>프로젝트 대표이미지</label> 
					<input type="file" name="profileAttach">
				</div>			<div class="row m20">
					<label>프로젝트 상세이미지</label> 
					<input type="file" name="detailAttach">
				</div>
				<div class="row center">
					<button type="button" class="btn btn-prev">이전 단계</button>
					<button type="button" class="btn btn-next">다음 단계</button>
				</div>
			</div>


		<!--리워드 추가 페이지-->
		<div class="container w600 m30 page">
		 	<div class="row center m50">
		 		<h1>리워드 추가하기</h1>
		 	</div>
		 	<div class="row right">
				<button type="button" class="btn btn-add">리워드 추가 <span>+</span></button>
		 	</div>
			 <h3>리워드1</h3>
			<div class="row m20">
				<label>리워드 이름</label> 
				<input type="text" name="rewardName" class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="13" class="form-input fill"></textarea>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> 
				<input type="number" name="rewardPrice" class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 재고</label> 
				<input type="number" name="rewardStock" class="form-input fill">
			</div>
			<h3 class="reward-num"></h3>
			<div id="add-reaward"></div>
            <div class="row center m20">
                <button type="button" class="btn btn-prev">이전 단계</button>
                <button type="button" class="btn btn-next">다음 단계</button>
            </div>
			<hr>
			<div class="row">
				<input type="submit" value="프로젝트 신청하기" class="btn fill">
			</div>
		</div>
	</form>
<jsp:include page="/template/footer.jsp"></jsp:include>