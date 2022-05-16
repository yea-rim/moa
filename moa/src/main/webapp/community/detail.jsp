<%@page import="moa.beans.AttachDto"%>
<%@page import="moa.beans.AttachDao"%>
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
	int communityNo = Integer.parseInt(request.getParameter("communityNo"));
	boolean isMember = session.getAttribute("login") != null;
%>
<%-- 처리 --%>
<% 
	CommunityDao communityDao = new CommunityDao();
	communityDao.editReadCount(communityNo);
	
	CommunityDto communityDto = communityDao.selectOne(communityNo);
	
	// 작성자 정보 가져오기
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(communityDto.getCommunityMemberNo());
	
	// 프로젝트 정보 가져오기
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(communityDto.getCommunityProjectNo());
	
	// 해당 게시글 사진 가져오기
	CommunityPhotoDao communityPhotoDao = new CommunityPhotoDao();
	CommunityPhotoDto communityPhotoDto = communityPhotoDao.selectOne(communityNo);
	
	// 게시글에 사진이 있는지 없는지 판단
	boolean isExistPhoto = communityPhotoDto != null;
	
	// 댓글 불러오기
	CommunityReplyDao communityReplyDao = new CommunityReplyDao();
	List<CommunityReplyDto> list = communityReplyDao.selectAll(communityNo);
	
	// 본문 작성자인지 판단
	Integer memberNo = (Integer) session.getAttribute("login"); 
	boolean isWriter = memberNo != null && memberNo.equals(memberDto.getMemberNo());
%>
<style>
.community-title {
	font-size: 20px;
}
.community-content{
	overflow-wrap:anywhere;
}
.flex-container1 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
}
.flex-items1 {
	flex-basis:10%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.flex-items2 {
	flex-basis:60%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.flex-items3 {
	flex-basis:14%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.flex-items4 {
	flex-basis:90%;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.flex-item-a {
	flex-basis:10%;
}
.flex-item-b {
	flex-basis:90%;
}

.reply-container {
	display: none;
	position: relative;
	height: 40px;
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		$(".reply-btn").click(function () {
	         $(this).parent(".flex-container1").next(".reply-container").toggle();
	    });
		
		        var replyAdd = document.querySelectorAll(".replyButton");

		        for (var i = 0; i < replyAdd.length; i++) {
		          replyAdd[i].addEventListener("click", function () {
		            var container = document.querySelector("#target");
		            var template = document.querySelector(".row-template");

		            if (container.innerHTML == "") {
		              this.value = "취소";
		              container.innerHTML = template.innerHTML;
		            } else {
		              this.value = "수정";
		              container.innerHTML = "";
		            }
		          });
		        }
		
		$(".community-reply").on("input", function(){
	    	  var content = $(this).val();
	    	  var length = content.length;
	    	  console.log(content);
	    	  while(length > 200){
	    		  $(this).val($(this).val().substring(0, length - 1));
	    		  length--;
	    	  }
	      });
		
		$(".reply-delete").click(function(){
			return confirm("삭제하시겠습니까?");
		});
		
		$(".community-delete").click(function(){
			return confirm("삭제하시겠습니까?");
		});
		
	});
</script>

<jsp:include page="/template/header.jsp"></jsp:include>    
<div class="container w800 m30">
	<div class="row m10" class="community-title">
			<h2><%=communityDto.getCommunityTitle() %></h2>
	</div>
	<div class="row">
		<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=communityDto.getCommunityProjectNo() %>" class="link" style="color:gray">
		<h4>/ <%=projectDto.getProjectName() %></h4>
		</a>
	</div>
	<div class="row flex-container">
		<div class="row left flex-item-a">
			<br>
			<h5>조회수: <%=communityDto.getCommunityReadcount() %></h5>
		</div>
		<div class="row right flex-item-b">
			<h5><%=memberDto.getMemberNick() %></h5>
			<h5><%=communityDto.getCommunityTime() %></h5>
		</div>
	</div>
	<hr style="border:solid 0.5px gray">
	<div class="row m10 right">
		<a href="<%=request.getContextPath() %>/project/project_detail.jsp?projectNo=<%=communityDto.getCommunityProjectNo() %>" class="link" style="color:#B899CD">해당프로젝트 보러가기</a>
	</div>
	<div class="row m20">
		<%if(isExistPhoto){ %>
		<img src="<%=request.getContextPath() %>/attach/download.do?attachNo=<%=communityPhotoDto.getAttachNo() %>" width="100%" class="m20">
		<%}else{ %>
		<span></span>
		<%} %>
	</div>
	<div class="row m50 community-content"  style="min-height: 200px; text-align: top;">
		<%=communityDto.getCommunityContent() %>
	</div>
	<%if(isWriter){ %>
	<div class="row right ">
		<a href="edit.jsp?communityNo=<%=communityNo %>" class="btn-reverse link">수정</a>
		<a href="delete.do?communityNo=<%=communityNo %>" class="btn link community-delete">삭제</a>
	</div>
	<%} %>
</div>
	

	<%-- 댓글 입력창 --%>
	<div class="container w800 m20">
		<h4>댓글</h4>
		<hr>
	<%if(isMember){ %>
				<form action="reply_insert.do" method="post">
					<input type="hidden" name="communityNo" value="<%=communityNo %>">
					<div class="flex-container1" style="height:40px">
						<div class="flex-items4">
							<input type="text" name="community_reply_content" autocomplete="off" class="form-input community-reply" placeholder="댓글을 입력해주세요" style="height:100%">
						</div>
						<div class="flex-items-a">
							<input type="submit" value="작성" class="btn reply-btn" style="height:100%">
						</div>
					</div>
				</form>
	<%} else{ %>
				<form action="reply_insert.do" method="post">
					<input type="hidden" name="communityNo" value="<%=communityNo %>">
					<div class="flex-container1" style="height:40px">
						<div class="flex-items4">
							<input type="text" name="community_reply_content" autocomplete="off" class="form-input community-reply" placeholder="로그인을 해주세요"  style="height:100%" disabled>
						</div>
						<div class="flex-items-a">
							<input type="button" value="작성" class="btn reply-btn" style="height:100%">
						</div>
					</div>
				</form>
	<%} %>
		<%-- 댓글 목록 --%>
		<div class="container m30" id="reply">
		<%for(CommunityReplyDto communityReplyDto : list) { %>
				<% 
					memberDto = memberDao.selectOne(communityReplyDto.getCommunityMemberNo());
					boolean isReplyWriter =  memberNo != null && memberNo.equals(communityReplyDto.getCommunityMemberNo());
				%>
				<div class="container">
				<div class="row flex-container1 m10">
					<div class="row flex-items1">
						<%=memberDto.getMemberNick() %> |
					</div>
					<div class="row flex-items2">
						<%=communityReplyDto.getCommunityReplyContent() %>
					</div>
					<div class="row flex-items3">
						<%=communityReplyDto.getCommunityReplyTime() %>
					</div>
					
					<%if(isReplyWriter){ %>
						<input type="submit" class="reply-btn btn-reverse" value="수정">
						<a href="reply_delete.do?communityReplyNo=<%=communityReplyDto.getCommunityReplyNo() %>&communityNo=<%=communityNo %>" class="link btn reply-delete">삭제</a>
					<%}%>
					
				</div>
					<%-- 댓글 수정창 --%>
					<div class="reply-container row-template">
							<form action="reply_edit.do" method="post" class="row center">
								<input type="hidden" name="communityNo" value="<%=communityNo %>">
								<input type="hidden" name="communityReplyNo" value="<%=communityReplyDto.getCommunityReplyNo() %>">
								<input type="text" name="communityReplyContent" value="<%=communityReplyDto.getCommunityReplyContent() %>" class="form-input w600 community-reply" style="height:100%">
								<input type="submit" value="수정" class="btn-reverse reply-btn" style="height:100%">
							</form>
					</div>
				<hr style="border:solid 0.5px lightgray">
					
				</div>
		<% }%>
		</div>
	</div>
	<div class="center" style="height:70px">
				<a href="list.jsp" class="btn-reverse link">목록으로 돌아가기</a>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>