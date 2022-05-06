<%@page import="java.util.Date"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 현재 세션에 저장된 로그인 정보 가져오기
	Integer memberNo = (Integer) session.getAttribute("login");
	
	// 회원 상세 조회
	MemberDao memberDao = new MemberDao();
	SellerDao sellerDao = new SellerDao();
	
	Integer sellerNo = (Integer) session.getAttribute("sellerNo");
	Integer sellerRegistDate = (Integer) session.getAttribute("sellerRegistDate");
	boolean isApprove = sellerRegistDate != null;	
	
	// 아직 승인 대기 처리 안 함 !!!!!!
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<h1>판매자 신청 완료!</h1>
	<%if (isApprove) { %>
	<h2>현재 상태 : 판매자</h2>
	<%} else { %>
	<h2>현재 상태 : 승인 대기 중</h2>
	<%} %>
	<h2>
		<a href="<%=request.getContextPath()%>">메인페이지로 이동</a>
	</h2>
	
<jsp:include page="/template/footer.jsp"></jsp:include>