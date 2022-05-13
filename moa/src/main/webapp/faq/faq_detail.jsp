<%@page import="moa.beans.MoaFaqDto"%>
<%@page import="moa.beans.MoaFaqDao"%>
<%@page import="moa.beans.CommunityReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.CommunityReplyDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.CommunityPhotoDto"%>
<%@page import="moa.beans.CommunityPhotoDao"%>
<%@page import="moa.beans.CommunityDto"%>
<%@page import="moa.beans.CommunityDao"%>
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
	
	Integer memberNo = (Integer) session.getAttribute("login"); 
	boolean isAdmin = memberNo == 1;
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
	flex-basis:10%;
}
.flex-items2 {
	flex-basis:65%;
}
.flex-items3 {
	flex-basis:15%;
}

.reply-btn {
	height: 40px;
}

.flex-item-a {
	flex-basis:10%;
}
.flex-item-b {
	flex-basis:90%;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		$(".btn-edit").click(function () {
	         $(this).parent(".flex-container1").next(".flex-container2").toggle();
	    });
	});
</script>

<jsp:include page="/template/header.jsp"></jsp:include>
 
<div class="container w800 m30">
	<div class="row m10" class="faq-title">
			<h2><%=moaFaqDto.getFaqTitle() %></h2>
	</div>

	<hr style="border:solid 0.5px gray">

	<div class="row m50">
		<%=moaFaqDto.getFaqContent() %>
	</div>
	<%if(isAdmin){ %>
	<div class="row right ">
		<a href="/admin/edit.jsp?faqNo=<%=faqNo %>" class="btn-reverse link">수정</a>
		<a href="/admin/delete.do?faqNo=<%=faqNo %>" class="btn-reverse link">삭제</a>
	</div>
	<%} %>
</div>

	<div class="center" style="height:70px">
				<a href="list.jsp" class="btn-reverse link">목록으로 돌아가기</a>
	</div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>