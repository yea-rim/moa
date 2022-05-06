<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

    <script type="text/javascript">
        $(function(){
            $(".del").click(function(){
                return confirm("정말 삭제 하시겠습니까?");
            });

        });
    </script>
<%
	 int ProjectNo = Integer.parseInt(request.getParameter("projectNo"));

	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(ProjectNo); /* 프로젝트불러오기 */
	
	RewardDao rewardDao = new RewardDao();
	List<RewardDto> rewardList = rewardDao.selectProject(ProjectNo); /* 해당 리워드목록 리스트 불러오기 */	
%>
<div class="row margin-auto m-b10">
        	<h1 class="m30">
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

                <div class="row fill m20">
                    <h2>
                        [카테고리]  <%=projectDto.getProjectCategory()%>
                    </h2>
                </div>
                <div class="row fill m20">
                    <h2>
                    	[목표금액]  <%=projectDto.getProjectTargetMoney() %>원
                    </h2>
                </div>
                <div class="row fill m20 h150">
                	<h2>[설명]</h2>
                    <span ><%=projectDto.getProjectSummary() %></span>
                </div>
                <div class="row fill h20 m20">
                    <h3>
                        [펀딩기간] <%=projectDto.getProjectStartDate() %> ~ <%=projectDto.getProjectSemiFinish() %>
                    </h3>
                </div>
                  <div class="row fill" style="margin-top: 50px">
                    <div class="float-container ">
                        <div class="float-left center layer-2 h40 " style="font-size: 14px;">
                        <a href="<%=request.getContextPath()%>/admin/projectPermit.do?projectNo=<%=projectDto.getProjectNo()%>">
                            <button class="btn w90p h100p">승인</button>
                        </a>
                        </div>
                        <div class="float-left center layer-2 h40" style="font-size: 14px;">
                        <a href="<%=request.getContextPath()%>/admin/projectRefuse.do?projectNo=<%=projectDto.getProjectNo()%>">
                            <button class="btn w90p h100p">거절</button>
                            </a>
                        </div>
                    </div>
                </div>
                  <div class="row fill m10">
                    <div class="float-container ">
                        <div class="float-left center layer-2 h40 " style="font-size: 14px;">
                        <a href="<%=request.getContextPath()%>/admin/projectEdit.jsp?projectNo=<%=projectDto.getProjectNo()%>">
                            <button class="btn w90p h100p">수정</button>
                        </a>
                        </div>
                        <div class="float-left center layer-2 h40" style="font-size: 14px;">
                        <a href="<%=request.getContextPath()%>/project/delete.do?projectNo=<%=projectDto.getProjectNo()%>" class="del">
                            <button class="btn w90p h100p">삭제</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        


        <div class="float-container center m30">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left w70p">
            	<h3 class="left m10">펀딩소개</h3>
                <img src="https://via.placeholder.com/500x2000" width="100%">
            </div>
            
            <!-- 본문 오른쪽 리워드 부분 -->
               <div class="float-left w30p p10px-left">
               <h3 class="left m10">리워드</h3>
               		<%for(RewardDto rewardDto : rewardList){ %>	
	                	<div class="fill m-b10">
                    		<a href="#" class="link"><button class="btn fill reward" style="text-align: left;">
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
<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>