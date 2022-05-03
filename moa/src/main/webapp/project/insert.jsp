<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 신청</title>
</head>
<body>
	<form action="insert.do" method="post">
		<div>
		 	<div>
		 		<h1>프로젝트 신청</h1>
		 	</div>
			<div>
				<label>카테고리</label>
				<select name="projectCategory">
					<option>패션/잡화</option>
					<option>뷰티</option>
					<option>푸드</option>
					<option>홈/리빙</option>
					<option>테크/가전</option>
					<option>기타</option>
				</select>
			</div>
			<div>
				<label>프로젝트명</label> <input type="text" name="projectName">
			</div>
			<div>
				<label>프로젝트 요약글</label>
				<textarea name="projectSummary" rows="13"></textarea>
			</div>
			<div>
				<label>펀딩 목표 금액</label> <input type="number"
					name="projectTargetMoney">
			</div>
			<div>
				<label>펀딩 시작일</label> 
				<input type="date" name="projectStartDate">
			</div>
			<div>
				<label>펀딩 마감일</label> 
				<input type="date" name="projectSemiFinish">
			</div>
			<div>
				<label>프로젝트 최종 마감일</label> 
				<input type="date" name="projectFinishDate">
			</div>
			<div>
				<input type="submit" value="신청">
			</div>
		</div>
	</form>

</body>
</html>