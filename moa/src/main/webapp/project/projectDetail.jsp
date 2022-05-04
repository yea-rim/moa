<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* int ProjectNo = Integer.parseInt(request.getParameter("projectNo")); */
	ProjectDao projectDao = new ProjectDao();
	/* 나중에 파라미터로 바꿔주기 */
	ProjectDto projectDto = projectDao.selectOne(10); /* 프로젝트불러오기 */
	/* 나중에 파라미터로 바꿔주기 */
	ProjectVo projectVo = projectDao.selectVo(10);
	
	RewardDao rewardDao = new RewardDao();
	
	/* 나중에 파라미터로 바꿔주기 */
	List<RewardDto> rewardList = rewardDao.selectProject(10); /* 해당 리워드목록 리스트 불러오기 */
	
	
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/commons.css">
    <%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/test.css"> --%>
</head>

<style>
    .reward {
      display: inline-flex;
      flex-direction: column;
      align-items: left; /* 가로 - 중앙으로 */
      justify-content: flex-start; /* 세로 - 상단으로 */
    }
</style>

<script type="text/javascript">

</script>

<body>
	<div class="container w1000 center">
        <div class="row w700 margin-auto">
        	<h1>
            <%=projectDto.getProjectName() %>
        	</h1>
        </div>

        <div class="float-container center m30">
            <!-- 상세페이지 프로필 부분 -->

            <div class="float-left w70p">
                <!-- 프로필부분의 왼쪽 플로트-->
                <div class="row layer-1">
                    <div class="img block">
                        <img src="https://via.placeholder.com/500x300" width="100%">
                    </div>

                </div>
            </div>



            <div class="float-left w30p left p10px">
                <!-- 프로필부분의 오른쪽 플로트 -->

                <div class="row fill h40">
                    <h2>
                        <%=projectVo.getDaycount() %>일 남음
                    </h2>
                </div>
                <div class="row fill h40">
                    <h2>
                        <%=projectVo.getPercent() %> % 달성
                    </h2>
                </div>
                <div class="row fill h40">
                    <h2>
                        <%=projectDto.getProjectPresentMoney() %>원 달성
                    </h2>
                </div>
                <div class="row fill h40">
                    <h4>
                        후원자수
                    </h4>
                    <h3>
                        <%=projectDto.getProjectSponsorNo() %>명
                    </h3>
                </div>
                <hr>
                <div class="row fill h40">
                    <h5>
                        펀딩기간 <%=projectDto.getProjectStartDate() %> ~ <%=projectDto.getProjectSemiFinish() %>
                    </h5>
                </div>
                <div class="row fill h40 m-b10">
                    <h5>
                        목표금액 <%=projectDto.getProjectTargetMoney() %>
                    </h5>
                </div>
                <div class="row fill h80">
                    <button class="btn fill h40 m-b10">후원하기</button>
                </div>
                <div class="row fill h40">
                    <div class="float-container">
                        <div class="float-left center layer-3 h40">
                            <button class="btn fill">
                            	좋아요
                            	<br>
                            	<%=projectVo.getJoacount() %>
                            </button>
                        </div>
                        <div class="float-left center layer-3 h40">
                            <button class="btn w90p">문의</button>
                        </div>
                        <div class="float-left center layer-3 h40">
                            <button class="btn fill">홍보</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <div class="float-container center m30">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left w70p">
                <img src="https://via.placeholder.com/500x2000" width="100%">
            </div>
               <div class="float-left w30p">
               		<%for(RewardDto rewardDto : rewardList){ %>	
	                	<div class="fill m-b10">
                    		<a href="#" class="link"><button class="btn fill reward">
		                        리워드 이름
		                        <%=rewardDto.getRewardName() %>
		                        <br>
		                        리워드 내용
		                        <%=rewardDto.getRewardContent() %>
		                        <br>
		                        리워드 가격
		                        <%=rewardDto.getRewardPrice() %>
		                        <br>
		                        리워드 재고
		                        <%=rewardDto.getRewardStock() %>
                    		</button></a>
                		</div>
                	<%} %>
            	</div>
            
        </div>
    </div>

</body>
</html>