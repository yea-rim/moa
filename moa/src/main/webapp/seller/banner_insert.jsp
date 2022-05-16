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
	
	boolean isExist = list.size() > 0;
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
        $('input[name="bannerTerm"]').click(function(){
            var price = 30000;
            var bannerTerm = $('input[name="bannerTerm"]:checked').val();
            var total = bannerTerm * price;
            total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            $("#display").text(total+" 원");
        });
        
        $(".insert-form").on("submit", function(){
        	if($('.checkValue:checked').length < 2){
        		alert("선택을 전부 완료해주세요");
        		return false;
        	}
        	else{
        		return true;
        	}
        })
	});
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_insert.js"></script>

	<!--프로젝트 입력 페이지-->
	<form action="banner_insert.do" method="post" class="insert-form">
		<input type="hidden" name="projectNo" value="<%=projectNo %>">
		<div class="container w800 m30 page">
			<div class="row center m60">
				<h1>배너 신청</h1>
			</div>
			<div class="row m30">
				<h3>* 게시기간 선택</h3>
			</div>
			<div class="row m20">
			
				<div class="m10">
					<input type="radio" name="bannerTerm" value="7" class="select-item checkValue"> <label>1주</label>
					<input type="radio" name="bannerTerm" value="14" class="select-item checkValue"> <label>2주</label>
					<input type="radio" name="bannerTerm" value="21" class="select-item checkValue"> <label>3주</label>
					<input type="radio" name="bannerTerm" value="28" class="select-item checkValue"> <label>4주</label>
				</div>
				
				<div class="mt50" style="font-weight:bold">
					가격 : &nbsp;
					<span id="display"></span>
					<span class="f12 gray">
					<br><br>
					※ 게시순서는 최근 신청분 순서이나 상황에 따라 유동적 변경 게시<br>
					※ 동시게시 배너수 제한으로 승인이 안될 수 있음 <br>
					※ 4주 이상 연속게시불가<br>
					※ 부가세 별도
					</span>
				</div>
			</div>
				<hr style="border: 0.5px solid #f1f2f6">
			
			
			<div class="row m30">
				<h3 class="m5">* 배너 이미지 선택</h3>
				<span class="f12 gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기존 프로필 중 1장 등록 가능</span>
			</div>
			<div class="row m10">
				
				
				<%if(isExist){ %>
				<div class="flex-container mt20">
				<%for(ProjectAttachDto projectAttachDto : list){ %>
				<div class="flex-container2 center">
					<div class="flex-items">
						 <img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="250" height="200" onerror="javascript:this.src='https://dummyimage.com/200x200'">
					</div>
					<div class="m10" style="width:90%">
						<input type="radio" name="projectAttach" class="checkValue" value="<%=projectAttachDto.getAttachNo() %>">
					</div>
				</div>
				<%} %>
				<%} else{ %>
					<h3 style="color:red">등록된 프로필이 없습니다.</h3>
				<%} %>
				</div>
				<hr style="border: 0.5px solid #f1f2f6">
				<h3>* 입금안내</h3>
					
				<span style="color:#AE4A00">
					<br>
					※ 납입기한: 배너게시 시작일기준으로 3일전까지 입금하신 후 반드시 담당자에게 확인 <br>
					※ 예외사항 발생시 납입기한 관련 사항을 반드시 담당자에게 문의하시기 바랍니다.<br>
					※ 입금 및 승인절차에 따라 배너게시가 가능하며 납입기한까지 미 입금시에는 승인이 취소됩니다.<br> 
				</span>
					<br><hr>
			<div class="flex-container1">
				<div class="row center m30 mlr10 flex-items">
					<button type="submit" class=" btn btn-next">신청</button>
				</div>
				<div class="row center m30 mlr10 flex-items">
				<% 
				%>
					<a href="my_coming_project.jsp" class="link btn-reverse btn-next">취소</a>
				</div>
			</div>
		</div>
		</div>
	</form>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>
