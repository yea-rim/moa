<%@page import="moa.beans.JoaDao"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/template/header.jsp"></jsp:include>

<% 

	// 세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
	memberNo = 23; // 나중에 지우기
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	boolean isLogin = memberNo != null; 
	
	// 세션에서 admin 정보 꺼내기
	String adminId = (String) session.getAttribute("admin");
	// adminId 데이터 여부 판단 -> 관리자 권한 판단
	boolean isAdmin = adminId != null;
	
	Integer sellerNo = (Integer) session.getAttribute("sellerNo");
	Integer sellerRegistDate = (Integer) session.getAttribute("sellerRegistDate");
	boolean isApprove = sellerRegistDate != null;

%>
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	ProjectDao projectDao = new ProjectDao();

	ProjectDto projectDto = projectDao.selectOne(projectNo); /* 프로젝트불러오기 */

	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	RewardDao rewardDao = new RewardDao();
	
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo); /* 해당 리워드목록 리스트 불러오기 */
	
	JoaDao joaDao = new JoaDao();//좋아요 Dao
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/commons.css"> --%>
    <%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/test.css"> --%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/projectHeader.css">
</head>

<style>
    
</style>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/joa.js"></script>

<script type="text/javascript">
	//시작하면 바로 이동
	$(function(){
    	var offset = $("#start-anc").offset(); //해당 위치 반환
    	$("html, body").animate({scrollTop: offset.top},0);
	});

</script>

<body>
	<div class="container w1000 center">
        <div class="row w700 margin-auto m-b10">
        	<h1>
            <%=projectDto.getProjectName() %>
        	</h1>
        </div>

        <div class="float-container center m30 h450px">
            <!-- 상세페이지 프로필 부분 -->

            <div class="float-left left-container">
                <!-- 프로필부분의 왼쪽 플로트-->
                <div class="row layer-1">
                    <div class="img block">
                        <img src="https://via.placeholder.com/500x300" width="600px" height="450px">
                    </div>
					
                </div>
            </div>



            <div class="float-left left p80px-left right-container h100p">
                <!-- 프로필부분의 오른쪽 플로트 -->

                <div class="row fill h40">
                    <h2>
                        <%=projectVo.getDaycount() %>일 남음
                    </h2>
                </div>
                <div class="row fill h40 m20">
                    <h2>
                        <%=projectVo.getPercent() %> % 달성
                    </h2>
                </div>
                <div class="row fill h40 m20">
                    <h2>
                        <%=projectDto.getProjectPresentMoney() %>원 달성
                    </h2>
                </div>
                <div class="row fill h40 m-b10">
                    <h4 class="m10">
                        후원자수
                    </h4>
                    <h3>
                        <%=projectDto.getProjectSponsorNo() %>명
                    </h3>
                </div>
                <hr>
                <div class="row fill h20">
                    <h5>
                        펀딩기간 <%=projectDto.getProjectStartDate() %> ~ <%=projectDto.getProjectSemiFinish() %>
                    </h5>
                </div>
                <div class="row fill h20 m-b10">
                    <h5>
                        목표금액 <%=projectDto.getProjectTargetMoney() %>
                    </h5>
                </div>
                <div class="row fill h60 m10 m-t40">
                    <button class="btn btn-reverse fill h40">후원하기</button>
                </div>
                <div class="row fill h40 m-t30">
                    <div class="float-container h40">
                        <div class="float-left left layer-3 h100p">
                            <button class="btn btn-reverse w90p wrap h100p" id="joa-btn" style="font-size: 12px;">
                            	<span id="joa">
                            		<%if(joaDao.isSearch(projectNo, memberNo)){ %>
                            		좋아요취소
                            		<%} else{ %>
                            		좋아요
                            		<%} %>
                            	</span>
                            	<br>
                            	<span id="joa-count" style="font-size: 12px;">
                            	<%=projectVo.getJoacount() %>
                            	</span>
                            </button>
                        </div>
                        <div class="float-left center layer-3 h100p" style="font-size: 14px;">
                            <a href="./qna.jsp?projectNo=<%=projectNo%>"><button class="btn btn-reverse w90p h100p">문의</button></a>
                        </div>
                        <div class="float-left right layer-3 h100p" style="font-size: 14px;">
                            <button class="btn btn-reverse w90p h100p">홍보</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>

		
<!-- 상세페이지 / 커뮤니티 메뉴바 -->
		<hr>
        <div class="row left h20 m10" id="start-anc">
            <a href="./body.jsp?projectNo=<%=projectNo%>" class="link"><h2>펀딩소개</h2></a>
            &ensp;&ensp;
            <a href="./notice.jsp?projectNo=<%=projectNo%>" class="link"><h2>공지</h2></a>
            <!-- <a href="./detail/ask.jsp" class="link">문의</a> -->
        </div>
        <hr>

        <div class="float-container center m30">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container m-b10">