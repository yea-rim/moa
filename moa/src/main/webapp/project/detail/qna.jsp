<%@page import="java.util.ArrayList"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.PjQnaDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.PjQnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		s = 5;
	}
%>  
<%

	// 세션에서 login 정보 꺼내기 (session은 객체로 저장되기 때문에 업캐스팅)
	Integer memberNo = (Integer) session.getAttribute("login"); 
	// memberNo 데이터 여부 판단 -> 로그인 여부 판단 
	memberNo = 23;//나중에지우기**********************************************
	boolean isLogin = memberNo != null;


	PjQnaDao pjQnaDao = new PjQnaDao();
	List<PjQnaDto> list = new ArrayList<>();
	if(hideSecret){
		list = pjQnaDao.selectOpen(projectNo, p, s, memberNo);
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
	if(hideSecret){
		count = pjQnaDao.countByPagingOpen(projectNo, memberNo);
	}else{
		count = pjQnaDao.countByPaging(projectNo);
		
	}

	// 블록크기
	int blockSize = 2;
	
	// 마지막 페이지 번호
	int lastPage = (count + s - 1) / s;
	
	int endBlock = (p + blockSize - 1) / blockSize * blockSize;
	int startBlock = endBlock - (blockSize - 1);
	
	if(endBlock > lastPage){
		endBlock = lastPage;
	}
	
	
	
%>
<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>
    
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_qna.js"></script>
<script type="text/javascript">
	/* $(function(){
			
		$(".delete-confirm").hide();
		$(".delete-btn").each(function(){
			var confirm = $(this).parent("div").parent("td").children(".delete-confirm");
			$(this).click(function(){
				confirm.show();
			});
		});
		
		$(".cancel-delete").each(function(){
			$(this).click(function(){
				$(this).parent(".delete-confirm").hide();
			});
		});
		
		$(".no-auth").click(function(){
			alert("권한이 없습니다.");
		});
		
	}) */
</script>


<div class="right m10">
                    <a class="link btn link-btn btn-qna">문의하기</a>
                </div>

                <div class="qna">
                    <form action="qna_write.do" method="post">
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
                                    <input type="checkbox" name="qnaLock" id="check-secret" value="1" checked>
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
                            <input type="submit" class="btn" value="작성">
                            <button class="hide-qna link link-btn btn btn-reverse">취소</button>
                        </div>
                        <hr>
                    </form>
                </div>

                <!-- 상세페이지 문의 리스트 -->
                <div class="ask-list fill">
                    <table class="row table fill">
                        <thead>
                            <tr>
                                <th width="10%">번호</th>
                                <th width="40%">제목</th>
                                <th width="25%">작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <!-- 문의글 목록 -->
                <%for(PjQnaDto pjQnaDto : list){ %>
                        <tbody>
                            <tr class="body center">
                                <td><%=pjQnaDto.getQnaNo() %></td>
                                <td class="table-title left">
                                <%if(pjQnaDto.getDepth() > 0){
                                	for(int i = 0; i < pjQnaDto.getDepth(); i++){%>
                                		&nbsp;
                                	<%} %>
                                	ㄴ>
                                <%} %>
                                    <%=pjQnaDto.getQnaTitle() %>
                                    <%if(pjQnaDto.getQnaLock() == 1){ %>
                                    <span>[비밀글]</span>
                                    <%} %>
                                    <%if(pjQnaDto.getQnaLock() == 0 || pjQnaDto.getQnaMemberNo() == memberNo){ %>
                                    <span hidden class="secret" value="1"></span>
                                    <%} %>
                                </td>
                                <td>
                                    <span class="writer">
                                    <%memberDto = memberDao.selectOne(pjQnaDto.getQnaMemberNo());%>
                                    <%=memberDto.getMemberEmail()%>
                                    </span>
                                </td>
                                <td><%=pjQnaDto.getQnaTime() %></td>
                            </tr>
                            <!-- 문의 내용 -->
                            <tr class="qna-content" hidden>
                                <div>
                                    <td colspan="4">
                                        <div>
                                            <pre><%=pjQnaDto.getQnaContent() %></pre>
                                        </div>
                                        <div class="row right m10">
                                            <a class="link btn link-btn btn-answer">답글</a>
                                            <!-- 자기가 쓴 글만 삭제버튼 구현 (관리자도 추후 구현) -->
                                            <%if(pjQnaDto.getQnaMemberNo() == memberNo){ %>
                                            <button class="btn delete-btn btn-reverse">삭제</button>
                                            <%}else{ %>
                                            <button class="btn no-auth btn-reverse">삭제</button>
                                            <%} %>
                                        </div>
                                        
                                        <!-- 답글 -->
                                        <div class="answer">
                                            <form action="qna_write.do" method="post">
                                            	<input name="memberNo" type="hidden" value="<%=memberNo%>">
                    							<input name="projectNo" type="hidden" value="<%=projectNo%>">
                                            	<input name="superNo" type="hidden" value="<%=pjQnaDto.getQnaNo()%>">
                                                <hr>
                                                <div class="flex-container left m-b10">
                                                    <div class="display-center">
                                                        <label>제목</label>
                                                    </div>
                                                    <div class="flex-container w70p">
                                                        <div class="rigth w80p">
                                                            <input type="text" name="qnaTitle" placeholder="제목입력"
                                                                class="form-input fill" autocomplete="off">
                                                        </div>
                                                        <div class="right display-center-right">
                                                            <label for="check-answer-secret">비밀글</label>
                                                            <input type="checkbox" name="qnaLock" id="check-answer-secret" value="1">
                                                        </div>
                                                    </div>
                                                </div>
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
                                                    <button class="btn btn-reverse hide-answer">취소</button>
                                                </div>
                                                <hr>
                                            </form>
                                        </div>
                                        <!-- 삭제 확인 -->
                                        <%if(pjQnaDto.getQnaMemberNo() == memberNo){ %>
                                        <div class="row delete-confirm right">
											<span>삭제하시겠습니까?</span>
											<a href="qna_delete.do?qnaNo=<%=pjQnaDto.getQnaNo() %>" class="confirm-btn link btn link-btn">삭제</a>       
											<button class="cancel-delete btn btn-reverse">취소</button>                          
                                        </div>
                                        <%} %>
                                    </td>
                                </div>
                            </tr>

                        </tbody>
		                <%} %>
                        <tfoot>
                            <tr>
                                <td colspan="4">
                                    <div class="float-container">
                                        <span class="float-left">
	                                        <%if(hideSecret){ %>
	                                            <input type="checkbox" id="hide-secret" checked>
	                                        <%}else{ %>
	                                            <input type="checkbox" id="hide-secret">
	                                        <%} %>
                                            <label for="hide-secret">비밀글 숨김</label>
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