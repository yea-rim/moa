<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.ProjectAttachDto"%>
<%@page import="moa.beans.ProjectAttachDao"%>
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
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	boolean isLogin = memberNo != null;
	
	// 세션에서 admin 정보 꺼내기
	Integer admin = (Integer) session.getAttribute("admin");
	// adminId 데이터 여부 판단 -> 관리자 권한 판단
	boolean isAdmin = admin !=null;
	
	// 판매자 세션 가져오기
	Integer seller = (Integer) session.getAttribute("seller");
	boolean isSeller = seller !=null;

%>
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
	
	JoaDao joaDao = new JoaDao();
	
	int rewardCount = 1;
	
	/* 조회수 증가 메서드 */
	projectDao.readCountUp(projectNo);
%>
<!-- 첨부파일 관련 -->
<%

	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
	List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
	List<ProjectAttachDto> detailList = projectAttachDao.selectDetailList(projectNo);
	
	boolean isProfile = profileList.size() > 0;
	boolean isDetail = detailList.size() > 0;
%>
<!-- 판매자 정보조회 -->
<%
	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(projectDto.getProjectSellerNo());
%>

<%
	//회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(projectDto.getProjectSellerNo());
		
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재
%>

    
    <!-- 스와이퍼 -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/projectHeader.css">
    

<style>
	.sold-out{
		position:absolute; 
		top:0; 
		left:0; 
		width:100%; 
		height:100%;
		opacity:0.4;
		background-color: rgb(231, 231, 231);
		display: flex;
    	align-items: center;
    	justify-content: center;
    	border-radius: 0.3em;
		z-index: -1;
		
    	transition: 0.2s ease-in-out;
	}
	
	.sold-out:hover{
		opacity: 0.8;
	}
	
</style>
<!-- 스와이퍼 -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- 좋아요 비동기통신 js파일 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/joa.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/swiper.js"></script>
	
	
<script type="text/javascript">
/* 숫자 콤마 찍기 */
$(function(){
	
	$(".number").each(function(){
		$(this).text(withCommas(parseInt(($(this).text()))));
	})
	
	function withCommas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		  
	}

	function withoutCommas(num) {
	return num.toString().replace(",", '');
	}
	
	$(".reward-stock").each(function(){
		var stock = parseInt($(this).text());
		console.log(stock);
		if(stock == 0){
			$(this).parent("span").parent("button").parent("a").next(".sold-out").css("z-index", "999");
		}
		
	});
	
});

</script>

	<div class="container w1000 center mt50">
        <div class="row w700 margin-auto m40">
        	<div class="project-title">
            <%=projectDto.getProjectName() %>
        	</div>
        	<div class="m50 project-seller center">
	        	<a href="<%=request.getContextPath()%>/seller/seller_page.jsp?sellerNo=<%=projectDto.getProjectSellerNo()%>" class="link">
        		<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                         <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="30px"  height="30px" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
                <%} else { // 존재하지 않는다면 %>
                         <img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="30px" height="30px" class="img img-circle">
                <%} %>
        		<%=sellerDto.getSellerNick()%>
	        	</a>
        	</div>
        </div>

        <div class="float-container center m30 h450px">
            <!-- 상세페이지 프로필 부분 -->

            <div class="float-left left-container">
                <!-- 프로필부분의 왼쪽 플로트-->
						<div class="swiper">
							<div class="swiper-wrapper">
								  <%if(isProfile){ %>
				            		<%for(ProjectAttachDto projectAttachDto : profileList){ %>
					            		<div class="swiper-slide">
					            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="600px">
					            		</div>
				            		<%} %>
				            		<%}else{ %>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				            			<div class="swiper-slide">
				                    		<img src="https://via.placeholder.com/500x300" width="100%" height="100%">
				            			</div>
				                	<%} %>
							</div>
							<div class="swiper-pagination"></div>
							
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
						
						</div>
						
                <%-- <%if(isProfile){ %>
            		<%for(ProjectAttachDto projectAttachDto : profileList){ %>
            		<div class="swiper-slide">
            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>">
            		</div>
            		<%} %>
            	<%}else{ %>
                    <img src="https://via.placeholder.com/500x300" width="600px" height="450px">
                <%} %> --%>
            </div>



            <div class="float-left left p80px-left right-container h450px">
                <!-- 프로필부분의 오른쪽 플로트 -->
 				<div class="row fill mb10">
                	<span class="small">
                	남은 기간
                	</span>
                </div>
                
                <div class="row fill mb20">
                <span class="big">
                        <%=projectVo.getDaycount() %>
                </span>
                <span class="small">
                        일
                </span>
                    
                </div>
                
                <div class="row fill mb10">
                	<span class="small">
                	모인금액
                	</span>
                </div>
                
                <div class="row fill mb20">
                    <span class="big number">
                        <%=projectVo.getPresentMoney() %>
	                </span>
                    <span class="small">
                        원
    	            </span>
    	            <span class="small" style="color: #b899cd; font-size: 13px;">
                        &nbsp;&nbsp;&nbsp;&nbsp;<%=projectVo.getPercent() %>%
    	            </span>
                    <span class="small">
                        달성
    	            </span>
                </div>
                
                <div class="row fill mb10">
                	<span class="small">
                        후원자
                	</span>
                </div>
                
                <div class="row fill m-b10">
                    <span class="big">
                        <%=projectVo.getSponsor() %>
               		 </span>
               		 <span class="small">명</span>
                </div>
                
                <hr>
                <div class="row fill h20">
                    <span class="small">
                    	펀딩기간&nbsp;&nbsp;
                	</span>
	                 <span class="small">
                     	 <%=projectDto.getProjectStartDate() %> ~ <%=projectDto.getProjectSemiFinish() %>
	                </span>
                </div>
                
                <div class="row fill h20">
  		            <span class="small">
        	            목표금액&nbsp;&nbsp;
            	    </span>
                    <span class="small number">
            	        <%=projectDto.getProjectTargetMoney() %>
	                </span>
                </div>
                
                <div class="row fill h30 mb20">
  		            <span class="small">
        	            결제날짜&nbsp;&nbsp;
            	    </span>
                    <span class="small">
            	        <%=projectDao.paymentDate(projectNo) %>
	                </span>
                </div>
        
                <div class="row fill h60 m10 m-t40">
                    <a href="<%=request.getContextPath()%>/project/funding.jsp?projectNo=<%=projectNo%>"><button class="btn btn-reverse fill h40">후원하기</button></a>
                </div>
                <div class="row fill h40 m-t30">
                    <div class="float-container h40">
                        <div class="float-left left layer-3 h100p">
                        <%if(isLogin && joaDao.isSearch(projectNo, memberNo)){ %>
                            <button class="btn w90p wrap h100p" id="joa-btn" style="font-size: 12px;">
                            <%}else{ %>
                            <button class="btn btn-reverse w90p wrap h100p" id="joa-btn" style="font-size: 12px;">
                            <%} %>
                            	<span id="joa">
                            		좋아요
                            	</span>
                            	<br>
                            	<span id="joa-count" style="font-size: 12px;">
                            	<%=projectVo.getJoacount() %>
                            	</span>
                            </button>
                        </div>
                        <div class="float-left center layer-3 h100p" style="font-size: 14px;">
                            <a href="<%=request.getContextPath() %>/project/detail/qna.jsp?projectNo=<%=projectNo%>"><button class="btn btn-reverse w90p h100p">문의</button></a>
                        </div>
                        <div class="float-left right layer-3 h100p" style="font-size: 14px;">
                        	<a href="<%=request.getContextPath() %>/community/insert.jsp?projectNo=<%=projectDto.getProjectNo() %>">
                            <button class="btn btn-reverse w90p h100p">홍보</button>
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        


<!-- 상세페이지 / 커뮤니티 메뉴바 -->
        <div class="row left h20 mt40">
            <a href="<%=request.getContextPath() %>/project/detail/body.jsp?projectNo=<%=projectNo%>" class="link"><span>펀딩소개</span></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=request.getContextPath() %>/project/detail/notice.jsp?projectNo=<%=projectNo%>" class="link"><span>공지</span></a>
        </div>
		<hr>

        <div class="float-container center">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container mt30">
            	<%if(isDetail){ %>
            		<%for(ProjectAttachDto projectAttachDto : detailList){ %>
            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="600px">
            		<%} %>
            	<%}else{ %>
                	<img src="https://via.placeholder.com/720x2000" width="100%">
                <%} %>
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
	                	<div class="fill m-b10" style="position:relative;">
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
			                        	재고 : <span class="reward-stock"><%=rewardDto.getRewardStock() %></span>
			                        </span>
	                    		</button>
                    		</a>
                    		<div class="sold-out">
                    			<span style="font-size: 18px; color:#520088; opacity:1;">재고 없음</span>
                    		</div>
                		</div>
                	<%} %>
            	</div>
            
        </div>
    </div>

<jsp:include page="/template/footer.jsp"></jsp:include>