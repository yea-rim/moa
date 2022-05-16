<%@page import="moa.beans.MoaQuestionAttachDao"%>
<%@page import="moa.beans.MoaQuestionDao"%>
<%@page import="moa.beans.MoaQuestionReplyDto"%>
<%@page import="moa.beans.MoaQuestionReplyDao"%>
<%@page import="moa.beans.MoaQuestionDto"%>
<%@page import="moa.beans.ProjectAttachDto"%>
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
<style>
  textarea {
    width: 100%;
    min-height: 6em;
    border: none;
    resize: none;
    font-size: 15px;
  }
</style>    
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
	List<JoaDto> joaList = joaDao.selectList(memberNo);
	
	// 프로젝트 Dao 준비 
	ProjectDao projectDao = new ProjectDao();
	
	
	// 프로젝트 Attach Dao 준비 
	ProjectAttachDao projectAttachDao = new ProjectAttachDao();
	
	// 펀딩한 프로젝트 조회 
	FundingDao fundingDao = new FundingDao();
	List<ProjectDto> fundingProjectList = projectDao.selectFundingProjectList(memberNo);
	
	// 리워드 셀렉션 Dao 준비
	RewardSelectionDao rewardSelectionDao = new RewardSelectionDao();

	//1:1문의
	MoaQuestionDao moaQuestionDao = new MoaQuestionDao();
	List<MoaQuestionDto> questionList = moaQuestionDao.selecMyQuestion(memberNo);
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$(".btn-detail").each(function(){
			$(this).click(function() {
				$(this).next().toggle();
			});
		});
		
		$(".btn-replyDelete").each(function(){
			$(this).click(function() {
				return confirm("정말 삭제 하시겠습니까?");
			});
		});	
	});
</script>
                <div class="container fill m10">
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        <!-- 프로필 사진 출력 -->
                        	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150px"  height="150px" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
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
            					<%if(joaList.isEmpty()){ %>
            								<div class="row m20 center">
											<span>관심 프로젝트가 없습니다.</span>
            								</div>			
            					<%}%>
            			<div class="flex-container3">
            				<%int limit = 0; 
            					
            					for(JoaDto joaDto : joaList) {
            					
            					int projectNo = joaDto.getProjectNo();
            					
								ProjectDto projectDto = projectDao.selectOne(projectNo);
								SellerDto sellerDto1 = sellerDao.selectOne(projectDto.getProjectSellerNo()); 
								
								ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectNo);
								

								boolean isExistProjectAttach = projectAttachDto != null;
								%> 
								
									<div class="list-card mlr30 m15">
					                    <!-- 이미지 자리 -->
					                    <div class="row center">
					                    	<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>">
					                        	<%if(isExistProjectAttach) { %>
					                        		<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="card-image-wrapper" width="150px" height="112px">
					                        	<%} else {%>
					                        		<img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="card-image-wrapper" width="150px" height="112px">
					                        	<%} %>
					                        </a>
					                    </div>
					                    
					                    <!-- 제목 -->
					                    <div class="row flex-title m10 mlr10 txt-overflow">
					                    	<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectNo%>"class="link">
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
                            <a href="funding_wait_list.jsp" class="link">후원 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                       
                       	<div class="container">
                       	         <%if(fundingProjectList.isEmpty()){ %>
            								<div class="row m20 center">
											<span>후원한 프로젝트가 없습니다.</span>
            								</div>			
            					<%}%>
            				<div class="flex-container3">
            			
            				<%
            					int limit2 = 0;
            				
            					for(ProjectDto projectDto : fundingProjectList) {
            					
            						ProjectDto projectOwner = projectDao.selectOne(projectDto.getProjectNo());
            						
									SellerDto sellerDto2 = sellerDao.selectOne(projectOwner.getProjectSellerNo());
									
									ProjectAttachDto projectAttachDto = projectAttachDao.getAttachNo(projectOwner.getProjectNo()); 
									
									boolean isExistProjectAttach = projectAttachDto != null;
								%>
									<div class="list-card mlr30 m15">
					                    <!-- 이미지 자리 -->
					                    <div class="row center">
					                    	<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectOwner.getProjectNo()%>">
					                        	<%if(isExistProjectAttach) { %>
					                        		<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=projectAttachDto.getAttachNo()%>" alt="" class="card-image-wrapper" width="150px" height="112px">
					                        	<%} else {%>
					                        		<img src="<%=request.getContextPath() %>/image/profile.png" alt="" class="card-image-wrapper" width="150px" height="112px">
					                        	<%} %>
					                        </a>
					                    </div>
					                    
					                    <!-- 제목 -->
					                    <div class="row flex-title m10 mlr10 txt-overflow">
					                    	<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectOwner.getProjectNo()%>" class="link">
					                     		<h2><%=projectOwner.getProjectName() %></h2>
					                     	</a>
					                    </div>
					
					                    <!-- 판매자 -->
					                    <div class="row m10 mlr10">
					                        <p><%=sellerDto2.getSellerNick() %></p>
					                    </div>
				
					                    <!-- 카테고리 -->
					                    <div class="row m30 mlr10">
					                        <p class="link-purple"><%=projectOwner.getProjectCategory() %></p>
					                    </div>
					                </div>
							<% limit2++;
	            				
									if(limit2 == 4) {
										break;
									} 
								}%>
			                
     				  		</div>
                    	</div>
                       
                    </div>
     
    <div class="row m30">
		<h2>1:1 문의</h2>
	</div>
	<hr>
	<div class="row mt20">
		<table class="table table-admin table-stripe">
			<thead>
				<tr>
					<th width="20%">문의유형</th>
					<th width="30%">제목</th>
					<th width="25%">작성일</th>
					<th width="25%">처리상태</th>
				</tr>
			</thead>
			<tbody>
				<%if(questionList.isEmpty()){ %>
					<tr>
						<td colspan="4">							
							<br>작성하신 1:1 문의가 없습니다.<br>
							주문, 배송 및 사이트 이용과 관련한 문의를 하시려면 1:1 문의를 이용해주세요.
							<br><br>
						</td>
					</tr>
				<% }%>
				<%
				for (MoaQuestionDto questionDto : questionList) {	
					//문의 답변 불러오기
					MoaQuestionReplyDao moaQuestionReplyDao = new MoaQuestionReplyDao();
					/* MoaQuestionReplyDto questionReplyDto = moaQuestionReplyDao.selectOne(questionDto.getQuestionNo()); */
					MoaQuestionReplyDto questionReplyDto = moaQuestionReplyDao.selectOne(questionDto.getQuestionNo());
					
					//문의 첨부파일 불러오기
					MoaQuestionAttachDao moaQuestionAttachDao = new MoaQuestionAttachDao();
					int questionAttachNo = moaQuestionAttachDao.selectOne(questionDto.getQuestionNo());
				%>
				<tr style="width:100%;cursor:pointer;" class="btn-detail">
					<td><%=questionDto.getQuestionType() %></td>
					<td class="left"><%=questionDto.getQuestionTitle()%></td>
					<td><%=questionDto.getQuestionTime() %></td>
					<td>
						<%if(questionDto.getAnswerStatus() ==0){ %>
							<span>답변대기</span>
						<%}else{ %>
							<span style="color: blue">답변완료</span>
						<%} %>
					</td>
				</tr>
					<%if(questionDto.getAnswerStatus() == 0){ %>
				<tr style="display: none;" class="show-detail">
					<td colspan="3" class="left" style="vertical-align: top;">
						<%if(questionAttachNo != 0) {%>
						<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=questionAttachNo%>" width="400"  height="400" class="img" onerror="javascript:this.src='https://dummyimage.com/400x400'"><br>
						<%} %>
						<span style="font-weight: bold;">문의내용</span><br>
					 	<%=questionDto.getQuestionContent() %>				
					</td>
					<td>
							<a href="<%=request.getContextPath()%>/question/delete.do?questionNo=<%=questionDto.getQuestionNo() %>" class="link link-small btn-replyDelete">삭제</a>
					</td>
				</tr>
					<%}else{%>
					<tr style="display: none;" class="show-detail b-purple">
					<td colspan="2" class=" b-right left" style="vertical-align: top;">
					 	<span style="font-weight: bold;">문의내용</span><br>
					 	<%if(questionAttachNo != 0) {%>
					 	<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=questionAttachNo%>" width="400"  height="400" class="img" onerror="javascript:this.src='https://dummyimage.com/400x400'"><br>
					 	<%} %>
					 	<textarea disabled><%=questionDto.getQuestionContent() %></textarea>
					</td>
					<td colspan="2" style="vertical-align: top;" class="left">
						<span style="font-weight: bold;">답변</span><br>
						<textarea disabled><%=questionReplyDto.getQuestionReplyContent() %></textarea>		
					</td>
				</tr>		
					<%} %>
				<%}%>
			</tbody>
		</table>
	</div>
</div>

	
<jsp:include page="/template/footer.jsp"></jsp:include>