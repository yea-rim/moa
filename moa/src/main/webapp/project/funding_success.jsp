<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	boolean isLogin = memberNo != null;
	
	
	int fundingNo = Integer.parseInt(request.getParameter("fundingNo"));

%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style>
    .container{
        height: 300px;
    }    
    .funding-image{
        text-align: center;
        margin-top: 100px;
    }
    .btn {
        margin-left: 10px;
        margin-right: 10px;
        height: 40px;
    }
</style>

    <div class="container w1000 center">
        <div class="funding-image">
            <img src="<%=request.getContextPath() %>/project/image/funding_success.png" width="150px" height="150px" >
        </div>
        <div class="row center m30">
            <h2>펀딩 예약이 완료되었습니다.</h2>
            <br>
            <h5>펀딩 번호 : <%=fundingNo %></h5>
        </div>
        <div>
            <a href="<%=request.getContextPath()%>"><button class="btn">메인페이지 이동</button></a>
            <a href="<%=request.getContextPath()%>/member/my_page.jsp"><button class="btn">마이페이지 이동</button></a>
        </div>
    </div>
    
    
    <jsp:include page="/template/footer.jsp"></jsp:include>