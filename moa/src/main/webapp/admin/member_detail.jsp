<%@page import="moa.beans.SellerAttachDto"%>
<%@page import="moa.beans.SellerAttachDao"%>
<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

<%
int memberNo = Integer.parseInt(request.getParameter("memberNo"));

MemberDao memberDao = new MemberDao();
MemberDto memberDto = memberDao.selectOne(memberNo);

SellerDao sellerDao = new SellerDao();
SellerDto sellerDto = sellerDao.selectOne(memberNo);

// 회원 프로필 사진 조회
MemberProfileDao memberProfileDao = new MemberProfileDao();
MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
boolean isExistProfile = memberProfileDto != null; // true면 프로필 사진 존재

// 인증 첨부파일 꺼내와야 함
%>

<div class="row center">
	<h1 class="mb50">
		회원 [<%=memberDto.getMemberEmail()%>] 상세정보
	</h1>
</div>

<div class="float-container center m30">
	<!-- 상세페이지 프로필 부분 -->

	<div class="float-left w60p center">
		<h3 class="left m10">회원 관련 상세정보</h3>
		<div class="float-left m20 mlr20 center">

			<!-- 프로필 사진 출력 -->
			<%
			if (isExistProfile) { // 프로필 사진 존재한다면
			%>
			<img
				src="<%=request.getContextPath()%>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>"
				width="150" height="150px" class="img img-circle"
				onerror="javascript:this.src='https://dummyimage.com/200x200'">
			<%-- <%=memberProfileDto.getAttachNo() %> --%>
			<%
			} else { // 존재하지 않는다면
			%>
			<img src="<%=request.getContextPath()%>/image/profile.png"
				alt="기본 프로필" width="150px" height="150px" class="img img-circle">
			<%
			}
			%>
		</div>
		<div class="float-container">
			<div class="float-left center layer-2 h40 " style="font-size: 14px;">
				<a
					href="<%=request.getContextPath()%>/admin/member_edit.jsp?memberNo=<%=memberDto.getMemberNo()%>">
					<button class="btn w90p h100p">정보 수정</button>
				</a>
			</div>
			<div class="float-left center layer-2 h40" style="font-size: 14px;">
				<a
					href="<%=request.getContextPath()%>/member/exit.do?memberNo=<%=memberDto.getMemberNo()%>"
					class="del">
					<button class="btn w90p h100p">회원 탈퇴</button>
				</a>
			</div>
		</div>
	</div>
	<div class="float-left w40p left p10px">
		<!-- 프로필 부분의 오른쪽 플로트 -->
		<div class="row fill m20">
			<h4>[이메일]</h4>
			<%=memberDto.getMemberEmail()%>
		</div>
		<div class="row fill m20">
			<h4>[닉네임]</h4>
			<%=memberDto.getMemberNick()%>
		</div>
		<div class="row fill m20">
			<h4>[전화번호]</h4>
			<%=memberDto.getMemberPhone()%>
		</div>
		<div class="row fill m20">
			<h4>[가입일]</h4>
			<%=memberDto.getMemberJoinDate()%>
		</div>
		<div class="row fill m20">
			<h4>[우편번호]</h4>
			<%=memberDto.getMemberPost()%>
		</div>
		<div class="row fill m20">
			<h4>[주소]</h4>
			<%=memberDto.getMemberBasicAddress()%>
		</div>
		<div class="row fill m20">
			<h4>[상세주소]</h4>
			<%=memberDto.getMemberDetailAddress()%>
		</div>
		<div class="row fill m20">
			<h4>[가입 경로]</h4>
			<%=memberDto.getMemberRoute()%>
		</div>

	</div>
</div>

<%if (sellerDto != null) { %>
<div class="float-container center m30">
	<!-- 본문 부분-->
	<div class="float-left w60p">

		<h3 class="left m10">판매자 관련 상세 정보</h3>
		<h4 class="left m10">판매자 인증 첨부파일</h4>
		<img src="https://via.placeholder.com/400x300" width="75%">
		<div class="float-container ">
			<div class="float-left center layer-2 h40 " style="font-size: 14px;">
				<a
					href="<%=request.getContextPath()%>/admin/approve.do?sellerNo=<%=sellerDto.getSellerNo()%>">
					<button class="btn w90p h100p">판매자 승인</button>
				</a>
			</div>
			<div class="float-left center layer-2 h40" style="font-size: 14px;">
				<a href="#" class="btn-refuse">
					<button class="btn w90p h100p">판매자 거절</button>
				</a>
			</div>
		</div>
		<div class="row m20 refuse-msg">
			<form action="#" method="post">
				<label>거절 메세지 입력</label> <input type="hidden" name="sellerNo"
					value="<%=sellerDto.getSellerNo()%>">
				<textarea name="sellerRefuseMsg" rows="5"
					class="float-right fill form-input mt5" placeholder="내용입력"
					autocomplete="off"></textarea>
				<div class="row center">
					<button class="btn btn-reverse fill">거절하기</button>
				</div>
			</form>
		</div>
	</div>

	<!-- 본문 오른쪽 리워드 부분 -->
	<div class="float-left w40p p10px-left">
		<div class="row fill m20">
			<h4>[판매자 닉네임]</h4>
			<%=sellerDto.getSellerNick()%>
		</div>

		<div class="row fill m20">
			<h4>[은행]</h4>
			<%=sellerDto.getSellerAccountBank()%>
		</div>

		<div class="row fill m20">
			<h4>[계좌]</h4>
			<%=sellerDto.getSellerAccountNo()%>
		</div>

		<div class="row fill m20">
			<h4>[판매자 유형]</h4>
			<%=sellerDto.getSellerType()%>
		</div>

		<div class="row fill m20">
			<h4>[판매자 여부]</h4>
					<%if(sellerDto.getSellerPermission()==0){ %>
							<span style="color: red">승인필요</span>
						<%}else if(sellerDto.getSellerPermission()==1){%>
							<span style="color: blue">승인완료</span>
 						<%}else { %>
							거절 
						<%} %>
		</div>
	</div>
</div>
						<%} %>


<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include>