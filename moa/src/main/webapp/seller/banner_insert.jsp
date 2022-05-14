<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
%>
<%
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);
	
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	List<ProjectAttachDto> list = projectAttachDao.selectProfileList(projectNo);
%>
<style>

		.insert-li{
			padding: 0px 0px 35px 20px;
			border-left: 1px solid #dcdcdc;
			list-style-type: disc;
		}
		.flex-items{
			margin-right:20px;
			display: flex;
			flex-direction: column;
			flex-wrap: wrap;
			justify-content: center;
		}
		.flex-container1{
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: center;
		}
		.flex-container2{
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
		}
</style>	

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function(){
        $('input[name="banner-term"]').click(function(){
            var price = 100000;
            var bannerTerm = $('input[name="banner-term"]:checked').val();
            var total = bannerTerm * price;
            total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            $("#display").text(total+" 원");
        });
	});
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_insert.js"></script>

	<!--프로젝트 입력 페이지-->
	<form action="banner_insert.do" method="post" enctype="multipart/form-data" class="insert-form">
	
		<div class="container w800 m30 page">
			<div class="row center m60">
				<h1>배너 신청 정보</h1>
			</div>
			<div class="row m30"><h3>* 배너 이용기간</h3></div>
			<div class="row m20">
			
			<!--  	<select name="projectCategory" class="form-input fill checkValue">
					<option value="">선택</option>
					<option value="7">7일</option>
					<option value="15">15일</option>
					<option value="30">30일</option>
				</select> -->
				<div class="m10">
					<input type="radio" name="banner-term" value="7" class="select-item"> <label>7일</label>
					<input type="radio" name="banner-term" value="15" class="select-item"> <label>15일</label>
					<input type="radio" name="banner-term" value="30" class="select-item"> <label>30일</label>
					<input type="radio" name="banner-term" value="60" class="select-item"> <label>60일</label>
				</div>
				<div class="mt20">
					가격: <span id="display"></span>
				</div>
			</div>
			
			<hr>
			
			<div class="row m30">
				<h3 class="m5">* 배너 이미지 선택</h3>
				<span class="f12 gray">기존 프로필 중 1장 등록 가능</span>
			</div>
			<div class="row m10">
				
				
				<div class="flex-container mt20">
				<%for(ProjectAttachDto projectAttachDto : list){ %>
				<div class="flex-container2 center">
					<div class="flex-items">
						 <img src="<%=request.getContextPath() %>/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="250" height="200">
					</div>
					
					<div class="fill m10">
						<input type="radio" name="project-attach" value="<%=projectAttachDto.getAttachNo() %>">
					</div>
				</div>
				<%} %>
				</div>
				
			<br><hr>
			<div class="flex-container1">
				<div class="row center m30 flex-items">
					<button type="submit" class=" btn btn-next">신청</button>
				</div>
				<div class="row center m30 flex-items">
					<a href="my_coming_project.jsp" class="link btn-reverse btn-next">취소</a>
				</div>
			</div>
		</div>
	</form>
	<jsp:include page="/template/footer.jsp"></jsp:include>
