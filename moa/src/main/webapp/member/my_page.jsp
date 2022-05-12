<%@page import="moa.beans.RewardSelectionDto"%>
<%@page import="moa.beans.RewardSelectionDao"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="moa.beans.FundingDao"%>
<%@page import="moa.beans.ProjectAttachDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.JoaDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.JoaDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 현재 세션에 저장된 로그인 정보 가져오기
	Integer memberNo = (Integer) session.getAttribute("login");

	// 회원 상세 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
		
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재 
	
	
	// seller인지 판단 
	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberDto.getMemberNo());
	
	boolean isSellerWait = sellerDto != null && sellerDto.getSellerRegistDate() == null; // Dto에 정보는 있지만 registDate가 없으면 대기 상태 
	boolean isSeller = sellerDto != null && sellerDto.getSellerRegistDate() != null; // true면 seller 
	
	
	// 관심 프로젝트 조회
	JoaDao joaDao = new JoaDao();
	List<JoaDto> list = joaDao.selectList(memberNo);
	
	// 프로젝트 Dao 준비 
	ProjectDao projectDao = new ProjectDao();
	
	
	// 프로젝트 Attach Dao 준비 
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
	
	// 펀딩한 프로젝트 조회 
/* 	FundingDao fundingDao = new FundingDao();
	List<FundingDto> fundingList = fundingDao.selectList(memberNo);
	
	// 리워드 셀렉션 Dao 준비
	RewardSelectionDao rewardSelectionDao = new RewardSelectionDao(); */
%>

<jsp:include page="/template/header.jsp"></jsp:include>

                <div class="container fill m10">
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        <!-- 프로필 사진 출력 -->
                        	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150"  height="150px" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
                                    <%-- <%=memberProfileDto.getAttachNo() %> --%>
                             <%} else { // 존재하지 않는다면 %>
                                    <img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="150px" height="150px" class="img img-circle">
                             <%} %>
                        </div>
                        
                        <!-- 회원 번호, 판매자 번호 버튼 -->
                        <div class="float-left m20 mlr20">
                            <div class="row m10">
                            	<div class="float-container">
                            		 <%if(isSeller) { // 판매자이면 %>
                            		 		<div class="float-left">
                            					<h4>(판매자 번호) </h4>
	                            			</div>
	                            			<div class="float-left mlr10">
	                            				<h3><%=sellerDto.getSellerNo() %></h3>
	                            			</div>
                            		<%} else { // 일반 회원이면 %>
	                            			<div class="float-left">
	                            				<h4>(회원번호) </h4>
	                            			</div>
	                            			<div class="float-left mlr10">
	                            				<h3><%=memberDto.getMemberNo() %></h3>
	                            			</div>
                            		<% } %>
                            	</div>
                            </div>
                            <div class="row">
                                
                                <!-- 닉네임 출력 -->
                                <%if(isSeller) { %>
                                		<h2><%=memberDto.getMemberNick() %> (<%=sellerDto.getSellerNick() %>)</h2>
                                <%} else { %>
                                		<h2><%=memberDto.getMemberNick() %></h2>
                                <% } %>
                                
                            </div>
                        </div> 
                        <div class="float-right m70 mlr40">
                            
                            <!-- 프로젝트 관련 버튼 -->
                            <%if(isSellerWait) { // 판매자 대기일 때 (판매자 신청 현황으로 이동) %>
		                            <a href="<%=request.getContextPath() %>/seller/seller_wait.jsp" class="link link-reverse h60">
			                             <h3>판매자 신청</h3>
	                                	<h3 class="center">(신청현황)</h3>
			                        </a>
                            <%} else if(isSeller) { // 판매자일 때 프로젝트 관리 페이지로 이동 %>
                        			<a href="<%=request.getContextPath() %>/seller/my_page.jsp" class="link link-reverse h40">
	                                	<h3>나의 프로젝트 관리</h3>
	                            	</a>
                        	<%} else { // 일반회원일 때 판매자 신청 페이지로 이동 %>
                        			<a href="<%=request.getContextPath() %>/seller/seller_join.jsp" class="link link-reverse h60">
	                                	<h3>판매자 신청</h3>
	                                	<h3 class="center">(신청현황)</h3>
	                            	</a>
                        	<%} %>
                        </div>
                    </div>

                    <div class="float-container">
                    	<div class="float-right m10">
                    		<!-- 개인정보 설정 -->
		                     <h3>
		                          <a href="confirm_pw.jsp" class="link">개인정보 설정</a>
		                      </h3>
		                 </div>
		                 <div class="float-right m10 mlr20">
		                 	<h3>
                    			<a href="profile.jsp" class="link">프로필 설정</a>
                    		</h3>
		                 </div>
                    </div>

                    <!-- 관심 프로젝트 -->
                    <div class="row m50">
                        <h2>
                            <a href="joa_list.jsp" class="link">관심 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                        
                    <div class="container">
            			<div class="flex-container3">
            			
            				<%
            				int limit = 0; 
            				
            				for(JoaDto joaDto : list) {
            					
            					int projectNo = joaDto.getProjectNo();
            					
								ProjectDto projectDto = projectDao.selectOne(projectNo);
								SellerDto sellerDto1 = sellerDao.selectOne(projectDto.getProjectSellerNo()); 
								/* int profileNo = projectAttachDao.getAttachNo(projectNo); */
								
								// projectAttach로 대표 이미지 가져오기 실패 
								%> 
								
									<div class="list-card mlr30 m15">
					                    <!-- 이미지 자리 -->
					                    <div class="row center">
					                    	<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectNo%>">
					                        	<img src="https://dummyimage.com/150x112" alt="" class="card-image-wrapper" width="150px" height="112px">
					                        </a>
					                    </div>
					                    
					                    <!-- 제목 -->
					                    <div class="row flex-title m10 mlr10 txt-overflow">
					                    	<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectNo%>"class="link">
					                     		<h2><%=projectDto.getProjectName() %></h2>
					                     	</a>
					                    </div>
					
					                    <!-- 판매자 -->
					                    <div class="row m10 mlr10">
					                        <p><%=sellerDto1.getSellerNick() %></p>
					                    </div>
					
					                    <!-- 카테고리 -->
					                    <div class="row m30 mlr10">
					                        <p class="link-purple"><%=projectDto.getProjectCategory() %></p>
					                    </div>
					                </div>
							<%
								limit++;
	            				
								if(limit == 4) {
									break;
								}
            				} %>
							
			                
     				  </div>
                    </div>
                    
                    
                    
                    <!-- 후원한 프로젝트 -->
                    <div class="row m50">
                        <h2>
                            <a href="" class="link">후원 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                       
                       	<div class="container">
            				<div class="flex-container3">
            			
            				<%-- <%for(FundingDto fundingDto : fundingList) {
            					int fundingNo = fundingDto.getFundingNo();
            					
            					RewardSelectionDto rewardSelectionDto = rewardSelectionDao.;
								int projectNo = rewardSelectionDto.getSelectionProjectNo();
								
								ProjectDto projectDto = projectDao.selectOne(projectNo);
								SellerDto sellerDto1 = sellerDao.selectOne(projectDto.getProjectSellerNo());
								%>
									<div class="list-card mlr40 m15">
					                    <!-- 이미지 자리 -->
					                    <div class="row center">
					                    	<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectNo%>">
					                        	<img src="https://dummyimage.com/200x200" alt="" class="card-image-wrapper">
					                        </a>
					                    </div>
					                    
					                    <!-- 제목 -->
					                    <div class="row flex-title m10 mlr10 txt-overflow">
					                    	<a href="<%=request.getContextPath() %>/project/projectDetail.jsp?projectNo=<%=projectNo%>" class="link">
					                     		<h2><%=projectDto.getProjectName() %></h2>
					                     	</a>
					                    </div>
					
					                    <!-- 판매자 -->
					                    <div class="row m10 mlr10">
					                        <p><%=sellerDto1.getSellerNick() %></p>
					                    </div>
					
					                    <!-- 카테고리 -->
					                    <div class="row m30 mlr10">
					                        <p class="link-purple"><%=projectDto.getProjectCategory() %></p>
					                    </div>
					                </div>
							<%} %> --%>
			                
     				  		</div>
                    	</div>
                       
                    </div>
                </div>

	
<jsp:include page="/template/footer.jsp"></jsp:include>