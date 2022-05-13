<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@page import="moa.beans.ProjectVo"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	ProjectDao projectDao = new ProjectDao();
	/* 나중에 파라미터로 바꿔주기 */
	ProjectDto projectDto = projectDao.selectOne(projectNo); /* 프로젝트불러오기 */
	/* 나중에 파라미터로 바꿔주기 */
	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	RewardDao rewardDao = new RewardDao();
	
	/* 나중에 파라미터로 바꿔주기 */
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo); /* 해당 리워드목록 리스트 불러오기 */
	//리워드 선택용 카운트
	int rewardCount = 1;
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/projectHeader.css">

<script type="text/javascript">
/* 숫자 콤마 찍기 */
/* $(function(){
	
	$(".number").each(function(){
		$(this).text(withCommas(parseInt(($(this).text()))));
	})
	
	function withCommas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		  
	}

	function withoutCommas(num) {
	return num.toString().replace(",", '');
	}
	
}); */
</script>

            </div>
            
            <!-- 본문 오른쪽 리워드 부분 -->
               <div class="float-left right-container p80px-left mt30">
               				<!-- 펀딩 요약 -->
			        <div class="row center shadow summary-box">
			        	<div class="m-b10 left" style="text-align: left;">
			        		<span style="color: gray; font-size: 15px;">펀딩 요약</span>
			        		<hr style="background-color: white; border-bottom: 1px dotted rgb(231, 231, 231);">
			        	</div>
			        	<div style="text-align: left; font-size: 13px;">
				        	<%=projectDto.getProjectSummary() %>
			        	</div>
			        </div>
			        
			        <div class="row left m10">
			        	<span style="color: gray; font-size: 13px; font-weight: bold;">리워드 선택</span>
			        </div>
               		<%for(RewardDto rewardDto : rewardList){ %>	
	                	<div class="fill m-b10">
                    		<a href="<%=request.getContextPath() %>/project/funding.jsp?projectNo=<%=projectNo%>&rewardCount=<%=rewardCount++ %>" class="link">
                    		<button class="fill reward shadow" style="text-align: left;">
		                        <div style="color: black;">
		                        	<h3><span class="number"><%=rewardDto.getRewardPrice() %></span>원 + </h3>
		                        </div>
		                        <br>
		                        <span>
			                        <%=rewardDto.getRewardName() %>
		                        </span>
		                        <br>
		                        <span style="font-size: 13px;">
			                        · <%=rewardDto.getRewardContent() %>
		                        </span>
		                        <br>
		                        <span style="font-size: 13px;">
		                        	재고 : <%=rewardDto.getRewardStock() %>
		                        </span>
                    		</button></a>
                		</div>
                	<%} %>
            	</div>
            
        </div>
    </div>
<jsp:include page="/template/footer.jsp"></jsp:include>