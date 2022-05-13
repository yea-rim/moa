<%@page import="moa.beans.PjProgressDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.PjProgressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   
<%
	int p;
	try {
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0)	throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int s;
	try {
		s = Integer.parseInt(request.getParameter("s"));
		if(s <= 0) throw new Exception();
	}
	catch(Exception e){
		s = 3;
	}
%>
<%
	
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));

	PjProgressDao pjProgressDao = new PjProgressDao();
	
	/* 파라미터 나중에 바꿔주기!!!!!!!!!!!!!!!!!!!!!!!! */
	List<PjProgressDto> list = pjProgressDao.select(projectNo, p, s);
	
	
	
%>
<%
	
	int count = pjProgressDao.countByPaging(projectNo, p, s);
	
	
	
	// 블록크기
	int blockSize = 1;
	
	// 마지막 페이지 번호
	int lastPage = (count + s - 1) / s;
	
	int endBlock = (p + blockSize - 1) / blockSize * blockSize;
	int startBlock = endBlock - (blockSize - 1);
	
	if(endBlock > lastPage){
		endBlock = lastPage;
	}
%>
<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>

<style>
	.notice-box {
		border: 1px solid rgb(231, 231, 231); 
		padding: 1em;
		border-radius: 0.3em;
		
		transition: 0.2s ease-in-out;
	}
	
	.notice-box:hover {
		border: 1px solid gray;
	}
</style>

<script type="text/javascript">
	//시작하면 바로 이동
	$(function(){
    	var offset = $("#start-anc").offset(); //해당 위치 반환
    	$("html, body").animate({scrollTop: offset.top},0);
	});

</script>

<!-- 상세페이지 / 커뮤니티 메뉴바 -->
        <div class="row left h20 mt40" id="start-anc">
            <a href="<%=request.getContextPath() %>/project/detail/body.jsp?projectNo=<%=projectNo%>" class="link"><span>펀딩소개</span></a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=request.getContextPath() %>/project/detail/notice.jsp?projectNo=<%=projectNo%>" class="link"><span style="font-weight:bold;">공지</span></a>
        </div>
		<hr>

        <div class="float-container center">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container mt30">
<!-- 공지 부분 -->
			<%for(PjProgressDto pjProgressDto : list) {%>
				<div class="notice-box mb20 shadow">
                    <div class="row left m10">
                      <span>
                        	<%=pjProgressDto.getProgressTitle() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>
                        <span class="row m10 font12">
                            <%=pjProgressDto.getProgressTime() %>
                        </span>
                    </div>
                    <hr>
                    <div class="row">
<pre class="pre-list"><%=pjProgressDto.getProgressContent() %></pre>
                    </div>
                    <div class="row right m30">
                        <a href="<%=request.getContextPath() %>/project/detail/notice_detail.jsp?projectNo=<%=projectNo %>&progressNo=<%=pjProgressDto.getProgressNo() %>" class="link">
                            더보기
                        </a>
                    </div>
                </div>
              <%} %>
              <div class="float-container">
                               <span class="pagination float-right">
                                <%if(startBlock > 1){ %>
									<a href="notice.jsp?projectNo=<%=projectNo %>&p=<%=startBlock-1%>&s=<%=s%>">&lt;</a>
								<%}else{ %>
									<a>&lt;</a>
								<%} %>
								<%if(endBlock < lastPage){ %>
									<a href="notice.jsp?projectNo=<%=projectNo %>&p=<%=endBlock+1%>&s=<%=s%>">&gt;</a>
								<%}else{ %>
									<a>&gt;</a>
								<%} %>
                               </span>
                           </div>
                    <span>&nbsp;</span>
<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>
