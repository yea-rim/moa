<%@page import="moa.beans.MoaFaqDto"%>
<%@page import="moa.beans.MoaFaqDao"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 준비 --%>
<%
int faqNo = Integer.parseInt(request.getParameter("faqNo"));
%>
<%-- 처리 --%>
<%
MoaFaqDao moaFaqDao = new MoaFaqDao();
MoaFaqDto moaFaqDto = moaFaqDao.selectOne(faqNo);

Integer admin = (Integer) session.getAttribute("admin");
boolean isAdmin = admin != null;
%>

<style>
.faq-title {
	font-size: 20px;
}

.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.flex-container2 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	display: none;
	position: relative;
}

.flex-items1 {
	flex-basis: 10%;
}

.flex-items2 {
	flex-basis: 65%;
}

.flex-items3 {
	flex-basis: 15%;
}

.reply-btn {
	height: 40px;
}

.flex-item-a {
	flex-basis: 10%;
}

.flex-item-b {
	flex-basis: 90%;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
</script>

<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	//삭제 기본 이벤트 차단
	$(".del").click(function() {
		return confirm("정말 삭제 하시겠습니까?");
	});
});
</script>
<div class="container w800 m30">
	<div class="row m10" class="faq-title">
		<h2><%=moaFaqDto.getFaqTitle()%></h2>
	</div>

	<hr style="border: solid 0.5px gray">

	<div class="row m50">
		<%=moaFaqDto.getFaqContent()%>
	</div>
	<%
	if (isAdmin) {
	%>
	<div class="row right ">
		<a href="<%=request.getContextPath() %>/admin/faq_edit.jsp?faqNo=<%=faqNo%>"
			class="btn-reverse link">수정</a> 
			<a href="<%=request.getContextPath() %>/admin/faq_delete.do?faqNo=<%=faqNo%>" class="btn-reverse link del">삭제</a>		
	</div>
	<%
	}
	%>
</div>

<div class="center" style="height: 70px">
	<a href="faq_list.jsp" class="btn-reverse link">목록으로 돌아가기</a>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>