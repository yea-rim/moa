<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.PjQnaDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.PjQnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	Integer secretNo;
	try{
		secretNo = Integer.parseInt(request.getParameter("secret"));
		
	}catch(Exception e){
		secretNo = null;
	}
		boolean hideSecret = secretNo != null && secretNo == 1;
%>
<!-- 페이지네이션 준비 -->
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));


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
		s = 10;
	}
%>  
<!-- 프로젝트 정보 -->
<%
	ProjectDao projectDao = new ProjectDao();
	ProjectDto projectDto = projectDao.selectOne(projectNo);
%>
<%


	PjQnaDao pjQnaDao = new PjQnaDao();
	List<PjQnaDto> list = new ArrayList<>();
	if/* (isAdmin || (isSeller && projectDto.getProjectSellerNo() == memberNo)){
		list = pjQnaDao.select(projectNo, p, s);
	}else if(isLogin && hideSecret){
		list = pjQnaDao.selectOpen(projectNo, p, s, memberNo);
	}else if */(hideSecret){
		list = pjQnaDao.selectOpen(projectNo, p, s)	;
	}else{
		list = pjQnaDao.select(projectNo, p, s);
	}
	
	
	
	// 작성자 아이디 찾아오는 용도
	MemberDao memberDao = new MemberDao();
	
	MemberDto memberDto;
	

%>
<!-- 페이지네이션 처리 -->
<% 

	int count;
	if/* (isAdmin || (isSeller && projectDto.getProjectSellerNo() == memberNo)){
		count = pjQnaDao.countByPaging(projectNo);
	}else if(isLogin && hideSecret){
		count = pjQnaDao.countByPagingOpen(projectNo, memberNo);
	}else if */(hideSecret){
		count = pjQnaDao.countByPagingOpen(projectNo);	
	}else{
		count = pjQnaDao.countByPaging(projectNo);
		
	}

	// 블록크기
	int blockSize = 3;
	
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
	.flex-container-jun {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
}
	.flex-left{
		display: flex;
    	justify-content: left;/*display가 flex인 경우 가로 정렬 옵션 */
   		align-items: center;/*display가 flex인 경우 세로 정렬 옵션*/
		padding-left: 1em;
		padding-top: 2em;
		padding-bottom: 2em;
		padding-right: 0.5em;
		border-right: 1px solid rgb(231, 231, 231);
		border-bottom:1px solid rgb(231, 231, 231);
		border-top:1px solid rgb(231, 231, 231);
		width: 17%;
		
	}
	.flex-rigth{
		width: 83%;
		border-bottom:1px solid rgb(231, 231, 231);
		border-top:1px solid rgb(231, 231, 231);
	}
	.seller-answer2{
		padding-left: 2em;
		padding-top: 1em;
	}
	
	.edit-content {
		position: fixed;
		top:50%;
		left:12%;
		
		transform: translate(-50%, -50%);
	
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_qna.js"></script>

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
            <a href="<%=request.getContextPath() %>/project/detail/notice.jsp?projectNo=<%=projectNo%>" class="link"><span>공지</span></a>
        </div>
		<hr>

        <div class="float-container center">
        
            <!-- 상세페이지 본문 부분-->

            <div class="float-left left-container mt30">
            
			<div class="right m10">
			<%if(isLogin) {%>
                    <button class="link btn link-btn btn-qna">문의하기</button>
                    <%}else{ %>
                    <button class="btn no-auth ">문의하기</button>
                    <%} %>
                </div>
				<%if(isLogin) {%>
                <div class="qna">
                    <form action="qna_write.do" method="post" class="write-form">
                    <input name="memberNo" type="hidden" value="<%=memberNo%>">
                    <input name="projectNo" type="hidden" value="<%=projectNo%>">
                        <hr>
                        <div class="flex-container left m-b10">
                            <div class="display-center">
                                <label>제목</label>
                            </div>
                            <div class="flex-container w70p">
                                <div class="rigth w80p">
                                    <input type="text" name="qnaTitle" placeholder="제목입력" class="form-input fill" autocomplete="off">
                                </div>
                                <div class="right display-center-right">
                                    <label for="check-secret">비밀글</label>
                                    <input type="checkbox" name="qnaLock" id="check-secret" value="1" checked style="accent-color: #B899CD;">
                                </div>
                            </div>
                        </div>
                        <div class="flex-container left">
                            <div class="flex-vertical display-center">
                                <label>내용</label>
                            </div>
                            <div class="w70p">
                                <textarea name="qnaContent" rows="10" class="float-right fill form-input" placeholder="내용입력"
                                    autocomplete="off"></textarea>
                            </div>
                        </div>
                        <div class=" right m10">
                            <input type="submit" class="btn write-btn" value="작성">
                            <button type="button" class="hide-qna btn btn-reverse">취소</button>
                        </div>
                        <hr>
                    </form>
                </div>
                <%} %>

                <!-- 상세페이지 문의 리스트 -->
                <div class="ask-list fill">
                    <table class="row table fill">
                        <thead>
                            <tr>
                                <th width="10%">번호</th>
                                <th>답변</th>
                                <th width="40%">제목</th>
                                <th width="25%">작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <!-- 문의글 목록 -->
                        <tbody>
                <%for(PjQnaDto pjQnaDto : list){ %>
                        <!-- 계층형 문의글 깊이가 0인것만 노출되게 표시 -->
                            <tr class="body center">
                                <td><span class="font14"><%=pjQnaDto.getQnaNo() %></span></td>
                                <td>
                                	<span class="font14">
                                	<!-- 그룹된 계층게시판이 1개 초과이면 답글 달린것으로 판단 -->
                                	<%if(pjQnaDao.isAnswer(pjQnaDto.getQnaNo())){ %>
                                	완료
                                	<%}else{ %>
                                	예정
                                	<%} %>
                                	</span>
                                </td>
                                <td class="table-title left font14">
                                	<span class="font14">
                                    <%=pjQnaDto.getQnaTitle() %>
                                    </span>
                                    <%if(pjQnaDto.getQnaLock() == 1){ %>
                                    <span class="font12">[비밀글]</span>
                                    <%} %>
                                    <%if(pjQnaDto.getQnaLock() == 0 || (isLogin && pjQnaDto.getQnaMemberNo() == memberNo) || isAdmin || (isSeller && projectDto.getProjectSellerNo() == memberNo)){ %>
                                    <span hidden class="secret" value="1"></span>
                                    <%} %>
                                </td>
                                <td>
                                    <span class="writer font14">
                                    <%memberDto = memberDao.selectOne(pjQnaDto.getQnaMemberNo());%>
                                    <%=memberDto.getMemberEmail()%>
                                    </span>
                                </td>
                                <td><span class="font14"><%=pjQnaDto.getQnaTime() %></span></td>
                            </tr>
                            <!-- 문의 내용 -->
                            <tr class="qna-content" hidden>
                                	<%if(pjQnaDto.getQnaLock() == 0 || (isLogin && pjQnaDto.getQnaMemberNo() == memberNo) || isAdmin || (isSeller && projectDto.getProjectSellerNo() == memberNo)){ %>
                                    <td colspan="5">
                                        <div class="m50">
                                            <pre class="font14"><%=pjQnaDto.getQnaContent() %></pre>
                                        </div>
                                        
                                        <!-- 수정 창 구현 자기가 쓴 글만 나옴 -->
                                        <%if(!pjQnaDao.isAnswer(pjQnaDto.getQnaNo()) && (isLogin && pjQnaDto.getQnaMemberNo() == memberNo)){ %>
                                        <div class="edit-content" hidden>
                                        	<form action="<%=request.getContextPath() %>/project/detail/qna_edit.do" method="post" class="edit-formcheck">
                                        		<input name="projectNo" type="hidden" value="<%=projectNo%>">
										        <input name="qnaNo" type="hidden" value="<%=pjQnaDto.getQnaNo()%>">
										        <div class="edit-pop" style="width: 350px;">
										            <div class="flex-container left m-b10">
										                <div class="display-center">
										                    <label>제목</label>
										                </div>
										                <div class="flex-container w70p">
										                    <div class="rigth w70p">
										                        <input type="text" name="qnaTitle" placeholder="제목입력" class="form-input fill" autocomplete="off" value="<%=pjQnaDto.getQnaTitle()%>">
										                    </div>
										                    <div class="right display-center-right">
										                        <label for="check-secret" class="font14">비밀글</label>
										                        <%if(pjQnaDto.getQnaLock() == 1){ %>
										                        <input type="checkbox" name="qnaLock" id="check-secret" value="1" checked style="accent-color: #B899CD;">
										                        	<%}else{ %>
										                        <input type="checkbox" name="qnaLock" id="check-secret" value="1" style="accent-color: #B899CD;">
										                        <%} %>
										                    </div>
										                </div>
										            </div>
										            <div class="flex-container left">
										                <div class="flex-vertical display-center">
										                    <label>내용</label>
										                </div>
										                <div class="w70p">
										                    <textarea name="qnaContent" rows="10" class="float-right fill form-input" placeholder="내용입력"
										                    autocomplete="off"><%=pjQnaDto.getQnaContent() %></textarea>
										                </div>
										            </div>
										            <div class="right m10">
										                <input type="submit" class="btn btn-edit" value="수정">
										                <button type="button" class="btn btn-edit-cancel">취소</button>
										            </div>
										        </div>
										    </form>
                                        </div>
                                        <%} %>
                                        
                                        	<!-- <hr style="margin-bottom: 0; background-color: rgb(231, 231, 231);"> -->
                                        
                                        <!-- 판매자 답변 -->
                                        <%if(pjQnaDao.isAnswer(pjQnaDto.getQnaNo())){
                                        	PjQnaDto pjQnaAnswer = pjQnaDao.selectOneAnswer(pjQnaDto.getQnaNo()); %>
                                        <div class="flex-container-jun fill seller-answer">
                                        	<div class="flex-left">
                                        		<span class="left font14">판매자 답변</span>
                                       		</div>
                                        	 <div class="flex-rigth">
                                        	 	<pre class="font14 seller-answer2"><%=pjQnaAnswer.getQnaContent() %></pre>
                                        	</div>
                                        </div>
                                        	<!-- <hr style="margin-top: 0; background-color: rgb(231, 231, 231);"> -->
                                        <%} %>
                                        <div class="row right m10"" >
                                        	<%if(!pjQnaDao.isAnswer(pjQnaDto.getQnaNo()) && ((isSeller && projectDto.getProjectSellerNo() == memberNo)  || isAdmin)){ %>
                                            <button class="btn btn-answer">답글</button>
                                            <%}%>
                                            <!-- 자기가 쓴 글만 수정버튼 구현 (관리자도 추후 구현) -->
                                            <%if(!pjQnaDao.isAnswer(pjQnaDto.getQnaNo()) && ((isLogin && pjQnaDto.getQnaMemberNo() == memberNo) || isAdmin)){ %>
                                           	 <button class="btn btn-editopen">수정</button>
                                           	<%} %>
                                            <!-- 자기가 쓴 글만 삭제버튼 구현 (관리자도 추후 구현) -->
                                            <%if(isAdmin || (isLogin && pjQnaDto.getQnaMemberNo() == memberNo)){ %>
                                            <button class="btn delete-btn btn-reverse">삭제</button>
                                            <%}%>
                                        </div>
                                        
                                        <!-- 답글 -->
                                        <%if(!pjQnaDao.isAnswer(pjQnaDto.getQnaNo()) && (isSeller && projectDto.getProjectSellerNo() == memberNo)){ %>
                                        <div class="answer" style="padding-left: 10px">
                                            <form action="qna_write.do" method="post" class="seller-answer-formcheck">
                                            	<input name="memberNo" type="hidden" value="<%=memberNo%>">
                    							<input name="projectNo" type="hidden" value="<%=projectNo%>">
                                            	<input name="superNo" type="hidden" value="<%=pjQnaDto.getQnaNo()%>">
                                                <hr>
                                                        <div class="rigth w80p">
                                                            <input type="hidden" name="qnaTitle" class="form-input fill" value="<%=pjQnaDto.getQnaTitle()%>">
                                                        </div>
                                                        	<%if(pjQnaDto.getQnaLock() == 1){ %>
                                                            <input type="hidden" name="qnaLock" id="check-answer-secret" value="<%=pjQnaDto.getQnaLock()%>" checked>
                                                            <%}else {%>
                                                            <input type="hidden" name="qnaLock" id="check-answer-secret" value="<%=pjQnaDto.getQnaLock()%>">
                                                            <%} %>
                                                <div class="flex-container left">
                                                    <div class="flex-vertical display-center">
                                                        <label>내용</label>
                                                    </div>
                                                    <div class="w70p">
                                                        <textarea name="qnaContent" rows="10" class="float-right fill form-input"
                                                            autocomplete="off" placeholder="내용입력"></textarea>
                                                    </div>
                                                </div>
                                                <div class=" right m10">
                                                    <input type="submit" class="link btn link-btn" value="작성">
                                                    <button type="button" class="btn btn-reverse hide-answer">취소</button>
                                                </div>
                                                <hr>
                                            </form>
                                        </div>
                                        <%} %>
                                        <!-- 삭제 확인 -->
                                        <%if(isAdmin || (isLogin && pjQnaDto.getQnaMemberNo() == memberNo)){ %>
                                        <div class="row delete-confirm right">
											<span class="font14">삭제하시겠습니까?</span>
											<a href="qna_delete.do?qnaNo=<%=pjQnaDto.getQnaNo() %>" class="confirm-btn link btn link-btn">삭제</a>       
											<button class="cancel-delete btn btn-reverse">취소</button>                          
                                        </div>
                                        <%} %>
                                    </td>
                                    <%} %>
                            </tr>
		                <%} %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="5">
                                    <div class="float-container">
                                        <span class="float-left mt10 mlr10">
	                                        <%if(hideSecret){ %>
	                                            <input type="checkbox" id="hide-secret" checked style="accent-color: #B899CD;">
	                                        <%}else{ %>
	                                            <input type="checkbox" id="hide-secret" style="accent-color: #B899CD;">
	                                        <%} %>
                                            <label for="hide-secret" style="font-size: 15px;">비밀글 숨김</label>
                                        </span>
                                        <span class="pagination float-right">
	                                        <%if(startBlock > 1){ %>
												<a href="qna.jsp?projectNo=<%=projectNo %>&p=<%=startBlock-1%>&s=<%=s%>">&lt;</a>
											<%} %>
											<%for(int i = startBlock; i <= endBlock; i++){ %>
												<%if(i == p){ %>
													<a class="active" href="qna.jsp?projectNo=<%=projectNo %>&p=<%=i%>&s=<%=s%>"><%=i%></a>	
												<%} else { %>
													<a href="qna.jsp?projectNo=<%=projectNo %>&p=<%=i%>&s=<%=s%>"><%=i%></a>
												<%} %>
											<%} %>
											<%if(endBlock < lastPage){ %>
												<a href="qna.jsp?projectNo=<%=projectNo %>&p=<%=endBlock+1%>&s=<%=s%>">&gt;</a>
											<%} %>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>