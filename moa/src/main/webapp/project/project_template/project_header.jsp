<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
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

	ProjectDto projectDto = projectDao.selectOne(projectNo); /* 프로젝트불러오기 */

	ProjectVo projectVo = projectDao.selectVo(projectNo);
	
	RewardDao rewardDao = new RewardDao();
	
	List<RewardDto> rewardList = rewardDao.selectProject(projectNo); /* 해당 리워드목록 리스트 불러오기 */
	
	JoaDao joaDao = new JoaDao();//좋아요 Dao
	
%>

<!-- 첨부파일 관련 -->
<%

	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
	List<ProjectAttachDto> profileList = projectAttachDao.selectProfileList(projectNo);
	
	boolean isProfile = profileList.size() > 0;
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


</style>

<!-- 스와이퍼 -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	var context = "<%=request.getContextPath()%>";
</script>
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
	
});
</script>

	<div class="container w1000 center mt50">
        <div class="row w700 margin-auto m40">
        	<div class="project-title">
            <%=projectDto.getProjectName() %>
        	</div>
        	<div class="m50 project-seller center">
	        	<a href="<%=request.getContextPath()%>/project/seller_page.jsp?sellerNo=<%=projectDto.getProjectSellerNo()%>" class="link">
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
				            		<%if(profileList.size() == 1){ %>
								  <%for(ProjectAttachDto projectAttachDto : profileList){ %>
					            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="100%" height="100%">
					            	<%} %>
				            		<%}else{ %>
				            		<%for(ProjectAttachDto projectAttachDto : profileList){ %>
					            		<div class="swiper-slide">
					            			<img src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" width="100%" height="100%">
					            		</div>
				            		<%}} %>
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
							<%if(profileList.size() != 1){ %>
							<div class="swiper-pagination"></div>
							
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
							<%} %>
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
        
                <div class="row fill h60 mb30 m-t40">
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
        


