<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.ProjectDto"%>
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

	// 준비
	int sellerNo = Integer.parseInt(request.getParameter("sellerNo"));

	// 판매자 상세 조회
	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(sellerNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(sellerNo);
		
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null;
	
	ProjectDao projectDao = new ProjectDao();
	List<ProjectDto> list2 = projectDao.selectNew();
%>

<style>
.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
}
.flex-container2 {
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: center;
}
.flex-items1 {
	flex-basis: 20%;
	padding: 10px;
}

.flex-items2 {
	flex-basis: 50%;
	padding: 10px;
}

.flex-items-a{
	flex-basis: 80%;
}
.flex-items-b{
	flex-basis: 20%;
}
.project-name {
	font-size: 25px;
	padding: 10px;
}
.percent{
	color: #B899CD;
	font-size: 15px;
	padding: 10px;
}
.seller{
	font-size: 15px;
	padding: 0px 10px;
}
</style>


<jsp:include page="/template/header.jsp"></jsp:include>
	
				<div class="container fill">
				
                    <!-- 마이페이지 상단 바 -->
                    <div class="float-container b-purple">
                        <div class="float-left m20 mlr20">
                        
                        	<!-- 프로필 사진 출력 -->
                            <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="150" class="img img-circle" onerror="javascript:this.src='https://dummyimage.com/200x200'">
                                    	
                                    <%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                             <%} else { // 존재하지 않는다면 %>
                                    <img src="https://dummyimage.com/200x200" alt="기본 프로필" width="200" class="img img-circle">
                             <%} %>
                        </div>
                        
                        <%if(sellerDto == null) {%>
                        <h1>존재하지 않는 판매자입니다.</h1>
                        <%} else { %>
                        <div class="float-left m20 mlr20">
                            <div class="row m10">
                            	<div class="float-container">
                            		<div class="float-left">
                            			<h4>(판매자번호) </h4>
                            		</div>
                            		<div class="float-left mlr10">
                            			<h3><%=sellerDto.getSellerNo() %></h3>
                            		</div>
                            	</div>
                            </div>
                            <div class="row">
                                <h2><%=sellerDto.getSellerNick() %></h2>
                            </div>
                        </div> 
                        <div class="float-right m60 mlr20">
                            <a href="" class="link link-reverse">
                                <h3 class="center">판매자 구독</h3>
                            </a>
                        </div>
                    </div>

                    <!-- 개인정보 설정 -->
                    <div class="row m20">
                        <h3 class="right">
                            <a href="" class="link">✉️ 판매자 1:1 문의</a>
                        </h3>
                    </div>

                    <div class="row m20">
				 <hr style="border: solid lightgray 0.5px" />
                <div class="row left big-text mt50 mlr10">
                    <a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">예정된 프로젝트</a>
                </div>
                
				<div class="row flex-container1">
				<%for(ProjectDto projectDto : list2){ %>
					<div class="row flex-items1 m10">
						<div class="row">
							<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo() %>"><img src="https://dummyimage.com/200x200" width="100%"></a>
						</div>
						<div class="row left m10">
							<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=projectDto.getProjectNo() %>" class="link">
								<span><%=projectDto.getProjectName() %></span>
							</a>
						</div>
					</div>
				<%} %>
				</div>
                        <hr>
                    </div>
                    <div class="row m20">
                        내용
                    </div>

                    <div class="row m20">
                        <h2>
                            <a href="" class="link">펀딩 중인 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                        내용
                    </div>

                    <div class="row m20">
                        <h2>
                            <a href="" class="link">마감된 프로젝트</a>
                        </h2>
                        <hr>
                    </div>
                    <div class="row m20">
                        내용
                    </div>
                </div>
             <%} %>
		
<jsp:include page="/template/footer.jsp"></jsp:include>