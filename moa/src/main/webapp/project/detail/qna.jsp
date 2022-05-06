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
	int projectNo = 11;


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
	boolean isLogin = memberNo != null;


	PjQnaDao pjQnaDao = new PjQnaDao();
	//나중에 파라미터 바꿔주기 프로젝트 넘버
	List<PjQnaDto> list = new ArrayList<>();
	if(hideSecret){
		list = pjQnaDao.selectOpen(projectNo, p, s);
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
		count = pjQnaDao.countByPagingOpen(projectNo);
	}else{
		count = pjQnaDao.countByPaging(projectNo);
		
	}

	// 블록크기
	int blockSize = 5;
	
	// 마지막 페이지 번호
	int lastPage = (count + s - 1) / s;
	
	int endBlock = (p + blockSize - 1) / blockSize * blockSize;
	int startBlock = endBlock - (blockSize - 1);
	
	if(endBlock > lastPage){
		endBlock = lastPage;
	}
	
	
	
%>
    
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/project_qna.js"></script>

<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>

<div class="right m10">
                    <a class="link btn link-btn btn-qna">문의하기</a>
                </div>

                <div class="qna">
                    <form action="" method="post">
                        <hr>
                        <div class="flex-container left m-b10">
                            <div class="display-center">
                                <label>제목</label>
                            </div>
                            <div class="flex-container w70p">
                                <div class="rigth w80p">
                                    <input type="text" placeholder="제목입력" class="form-input fill" autocomplete="off">
                                </div>
                                <div class="right display-center-right">
                                    <label for="check-secret">비밀글</label>
                                    <input type="checkbox" name="" id="check-secret" checked>
                                </div>
                            </div>
                        </div>
                        <div class="flex-container left">
                            <div class="flex-vertical display-center">
                                <label>내용</label>
                            </div>
                            <div class="w70p">
                                <textarea name="" rows="10" class="float-right fill form-input" placeholder="내용입력"
                                    autocomplete="off"></textarea>
                            </div>
                        </div>
                        <div class=" right m10">
                            <input type="submit" class="link btn link-btn" value="작성">
                            <a class="btn hide-qna">취소</a>
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
                <%for(PjQnaDto pjQnaDto : list){ %>
                        <tbody>
                            <tr class="body center">
                                <td><%=pjQnaDto.getQnaNo() %></td>
                                <td class="table-title">
                                <%if(pjQnaDto.getDepth() > 0){
                                	for(int i = 0; i < pjQnaDto.getDepth(); i++){%>
                                		&nbsp;
                                	<%} %>
                                	ㄴ>
                                <%} %>
                                    <%=pjQnaDto.getQnaTitle() %>
                                    <span class="secret" hidden>
	                                    <%if(isLogin && memberNo == pjQnaDto.getQnaMemberNo()){ %>
	                                    0
	                                    <%}else{ %>
	                                    <%=pjQnaDto.getQnaLock() %>
	                                    <%} %>
                                    </span>
                                    <span>[비밀글]</span>
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
                                            <a class="btn">삭제</a>
                                        </div>
                                        <!-- 답글 -->
                                        <div class="answer">
                                            <form action="" method="post">
                                                <hr>
                                                <div class="flex-container left m-b10">
                                                    <div class="display-center">
                                                        <label>제목</label>
                                                    </div>
                                                    <div class="flex-container w70p">
                                                        <div class="rigth w80p">
                                                            <input type="text" placeholder="제목입력"
                                                                class="form-input fill" autocomplete="off">
                                                        </div>
                                                        <div class="right display-center-right">
                                                            <span class="answer-secret" hidden>0</span>
                                                            <label for="check-answer-secret">비밀글</label>
                                                            <input type="checkbox" id="check-answer-secret" name="">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="flex-container left">
                                                    <div class="flex-vertical display-center">
                                                        <label>내용</label>
                                                    </div>
                                                    <div class="w70p">
                                                        <textarea name="" rows="10" class="float-right fill form-input"
                                                            autocomplete="off" placeholder="내용입력"></textarea>
                                                    </div>
                                                </div>
                                                <div class=" right m10">
                                                    <input type="submit" class="link btn link-btn" value="작성">
                                                    <a class="btn hide-answer">취소</a>
                                                </div>
                                                <hr>
                                            </form>
                                        </div>
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
											<%for(int i = 1; i <= lastPage; i++){ %>
												<a href="?p=<%=i%>&s=<%=s%>"><%=i %></a>
											<%} %>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>