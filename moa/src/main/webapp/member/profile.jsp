<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 로그인 세션으로 회원 정보 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	// 상세 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
	
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; 
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

    <script type="text/javascript">
        $(function(){
            // 주소 api JS
            $(".address-find-btn").click(findAddress); // 콜백 함수 (예약 실행)
            
	        // 파일명 input에 출력하는 JS
	        $("#file").on('change',function(){
	            var fileFullName = $("#file").val();	      
	            var fileName = fileFullName.substring(12,fileFullName.length);
	            $(".upload-name").val(fileName);
	        });
        });

    </script>

                <div class="container fill m40">
                    <form action="edit.do" method="post" enctype="multipart/form-data">
						<input type = "hidden" name = "memberNo" value="<%=memberNo%>">
                    
                        <div class="flex-container">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="my_page.jsp" class="link mlr5">
                                <h2>프로필 설정</h2>
                            </a>
                        </div>
    
                        <div class="row m30"><hr></div>
    
                        <div class="float-container m50">
                            <!-- 프로필 사진 변경 -->
                            <div class="float-left layer-2 center">
                                <!-- 프로필 사진 출력 -->
                                <div class="row">
                                    <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    	<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="200px" height="200px"class="img img-circle">
                                    	
                                    	<%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                                    <%} else { // 존재하지 않는다면 %>
                                    	<img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="200px" height="200px" class="img img-circle">
                                    <%} %>
                                </div>
                                
                                <!-- 프로필 사진 등록 (attach table)-->
                                <div class="row m20 right">
                                    <div class="filebox center">
                                        <input class="upload-name" value="첨부파일" placeholder="첨부파일">
                                        <label for="file">파일찾기</label> 
                                        <input type="file" id="file" name="attach">
                                    </div>
                                </div>
                            <div>
                            	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
									<a href="delete_profile.do?memberNo=<%=memberNo%>"><button type="button" class="btn">프로필 사진 삭제</button></a>
								<%} %>
                            </div>
                            </div>
                            

                            <div class="float-left layer-2 center">
    
                                <!-- 개인 정보 수정 -->
                                <div class="container w400">
                                    <!-- 닉네임 입력 -->
                                    <div class="row mt100">
                                        닉네임 
                                    </div>
                                    <div class="row m5">
                                        <input type="text" name="memberNick" value="<%=memberDto.getMemberNick() %>" autocomplete="off" class="form-input fill">
                                    </div>
        
                                    <!-- 변경 버튼 -->
                                    <div class="row m30">
                                        <input type="submit" value="프로필 변경" class="link link-btn fill">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                </div>
                
                <%-- <div class="float-left layer-2 center">
                    	<form action="delete_profile.do" method="post">
                    		<input type="hidden" name="memberNo" value="<%=memberNo%>">
                    		<input type="submit" value="프로필 사진 삭제" class="btn">
                    	</form>
                    </div> --%>

<jsp:include page="/template/footer.jsp"></jsp:include>