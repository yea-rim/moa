<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.FundingDto"%>
<%@page import="moa.beans.FundingDao"%>
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
	FundingDao fundingDao = new FundingDao();
	ProjectDao projectDao = new ProjectDao();
	
	List<FundingDto> list = fundingDao.selectSuccessList(memberNo);
	
	
%>

	<div class="container fill m40">
					<div class="flex-container m20">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="my_page.jsp" class="link mlr5">
                                <h2>후원 프로젝트</h2>
                            </a>
                   	</div>
				
					<div class="row m30"><hr></div>
	</div>

	<div class="container mt30">
                    <div class="float-container">
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_wait_list.jsp" class="link link-reverse fill center">후원 대기</a>
                        </div>
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_finish_list.jsp" class="link link-btn fill center">후원 완료</a>
                        </div>
                        <div class="float-left layer-5 p10">
                            <a href="<%=request.getContextPath() %>/member/funding_cancel_list.jsp" class="link link-reverse fill center">후원 취소</a>
                        </div>
                </div>


    <%for(FundingDto fundingDto : list){ %>
    <% ProjectDto projectDto = projectDao.selectSuccessMyFunding(fundingDto.getFundingNo(), memberNo); %>
    <div class="container mt20">
		
        <div class="float-container b-purple">

            <div class="float-left layer-5 m20 mlr20">
                <img src="https://dummyimage.com/150x130" alt="" class="img img-round" width="150px" height="130px">
            </div>

            <div class="float-left layer-2 m20 mlr50">
                <div class="row">
                    <p>결제 완료일 <%=fundingDto.getFundingPaymentDate() %> | 펀딩번호 <%=fundingDto.getFundingNo() %></p>
                    <h2 class="mt10">
                        <a href="" class="link"><%=projectDto.getProjectName() %></a>
                    </h2>

                    <!-- 리워드 리스트 출력 -->
                    <p class="mt10 link-gray">
                    </p>
                    <p class="mt5 link-gray">
                    </p>
                    

                    <p class="mt10">
                        배송일 : <%=projectDto.getProjectFinishDate() %>
                    </p>

                    <p class="mt5 p-red">
                        <%=fundingDto.getFundingTotalprice()+fundingDto.getFundingTotaldelivery() %>원 결제 완료 
                    </p>
                </div>
            </div>
            
            <!-- 홍보하기 : 홍보 게시판으로 이동 -->
			<div class="float-right m70 mlr20">
				<div class="row mt5">
					  <a href="" class="link link-reverse w100 center">홍보하기</a>
				</div>
			</div>
        </div>

        
    </div>
    <%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>