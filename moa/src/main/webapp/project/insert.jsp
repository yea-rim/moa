<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

		.insert-li{
			padding: 0px 0px 35px 20px;
			border-left: 1px solid #dcdcdc;
			list-style-type: disc;
		}
</style>	
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_insert.js"></script>

	<!--프로젝트 입력 페이지-->
	<form action="insert.do" method="post" enctype="multipart/form-data" class="insert-form">
		<div class="container w600 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1_ck.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3.png" width="80">
			</div>
			<div class="row center m60">
				<h1>프로젝트 정보 입력</h1>
			</div>
			<div class="row m30"><h3>* 프로젝트 기본 정보</h3></div>
			<div class="row m20">
				<label>카테고리</label> <select name="projectCategory"
					class="form-input fill">
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
				<input type="text" name="projectName" class="form-input fill text-length" data-len="30" 
				data-success-msg="" data-fail-msg="30자 이내로 입력해주세요." required>
				<div class="flex-container length">
					<div class="left-wrapper msg f12 red"></div>
					<div class="right-wrapper right count f12 gray">0</div><span class="f12 gray">/30</span>
				</div>

			</div>
			<div class="row m20">
				<label>프로젝트 요약글</label>
				<textarea name="projectSummary" rows="5" class="form-input fill text-length" data-len="100"
				data-success-msg="" data-fail-msg="100자 이내로 입력해주세요."></textarea>
				<div class="flex-container length">
					<div class="left-wrapper msg f12 red"></div>
					<div class="right-wrapper right count f12 gray">0</div><span class="f12 gray">/100</span>
				</div>
			</div>
			<div class="row m20">
				<label>펀딩 목표 금액</label> 
				<input type="number" name="projectTargetMoney" class="form-input fill"> 
				<span class="font-on f12 red"></span><br>
				<span class="f12 gray" > 
					※목표 금액 설정 시 꼭알아두세요!<br> 
					종료일까지 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.<br> 
					종료 전 후원 취소를 대비해 10% 이상 초과 달성을 목표로 해주세요.<br> 
					제작비, 선물 배송비, 인건비, 예비 비용 등을 함께 고려해주세요.<br>
				</span>
			</div>
			<br><hr><br>
			
			<div class="row m30">
				<h3 class="m5">* 프로젝트 이미지 선택</h3>
				<span class="f12 gray">　각각 최대 3장 까지 설정 가능합니다.</span>
			</div>
			<div class="row m10">
				<h4>대표이미지</h4>
			</div>
			<div class="row m5">
				<input type="file" name="profileAttach" accept="image/*">
				<button type="button" class="addbtn btn-addProfile">+</button>
				<br> <div class="buttons1"></div>
			</div>
			<br>
			<div class="row m10">
				<h4 class="m5">상세이미지</h4>
			</div>
			<div class="row">
				<input type="file" name="detailAttach" accept="image/*">
				<button type="button" class="addbtn btn-addDetail">+</button>
				<br> <span class="buttons2"></span>
			</div>
			<br><br><hr>
			<div class="row center m30">
				<button type="button" class="btn btn-prev">이전 단계</button>
				<button type="button" class="btn btn-next">다음 단계</button>
			</div>
		</div>

		<!--펀딩 일정 선택-->
		<div class="container w500 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2_ck.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3.png" width="80">
			</div>
			<div class="row center m60">
				<h1>펀딩 일정 선택</h1>
			</div>

						<div class="row m30">
					<ul>
						<li class="insert-li">
							<div class="row">펀딩 시작일</div>
							<div class="row m5">
								<input type="text" name="projectStartDate" id="start" autocomplete="off" placeholder="연도-월-일" class="form-date w40p">
							</div>
						</li>
						<li class="insert-li">
							<div class="row">
								<span>펀딩기간</span>
								<span class="days gray"></span>
							</div>
						</li>
						<li class="insert-li">
							<div class="row">펀딩 마감일</div>
							<div class="row m5">
								<input type="text" name="projectSemiFinish" id="end" autocomplete="off" placeholder="연도-월-일" class="form-date w40p">
							</div>
						</li>
						<li class="insert-li">
							<div class="row">정산일</div>
							<div class="row m5">
								<span class="f13 gray">펀딩 마감과 동시에 정산이 진행됩니다.</span>
							</div>
						</li>
						<li class="insert-li">
							<div class="row">배송 마감일</div>
							<div class="row m5">
								<span class="f13 gray">배송 마감일은 펀딩 마감일로 부터 30일 이후 입니다.</span><br>
								<span class="f13 gray">한달 이내에 배송을 모두 완료 해야합니다.</span>
							</div>
						</li>
					</ul>
			<div class="row center m50">
				<button type="button" class="btn btn-prev">이전 단계</button>
				<button type="button" class="btn btn-next">다음 단계</button>
			</div>
		</div>
</div>

		<!--리워드 추가 페이지-->
		<div class="container w500 m30 page">
			<div class="row center">
				<img src="<%=request.getContextPath()%>/image/pj_insert1.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert2.png" width="80">
				<img src="<%=request.getContextPath()%>/image/arrow3.png" width="80">
				<img src="<%=request.getContextPath()%>/image/pj_insert3_ck.png" width="80">
			</div>
			<div class="row center m50">
				<h1>리워드 추가</h1>
			</div>
			<h3>* 리워드1</h3>
			<div class="row m20">
				<label>리워드 이름</label> <input type="text" name="rewardName"
					class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 내용</label>
				<textarea name="rewardContent" rows="5" class="form-input fill"></textarea>
			</div>
			<div class="row m20">
				<label>리워드 가격</label> <input type="number" name="rewardPrice"
					class="form-input fill">
			</div>
			<div class="row m20">
				<label>리워드 재고</label> <input type="number" name="rewardStock"
					class="form-input fill">
			</div>
			<h3 class="reward-num"></h3>
			<div id="add-reward"></div>
			<div class="row right">
				<a class="btn-delReward"><img src="<%=request.getContextPath()%>/image/del-icon.png" width="20"></a>
				<a class="btn-addReward"><img src="<%=request.getContextPath()%>/image/add-icon.png" width="20"></a>
			</div>
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
