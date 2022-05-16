<%@page import="moa.beans.AttachDao"%>
<%@page import="moa.beans.AttachDto"%>
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

<style type="text/css">
	span {
		color: red; 
	}
</style>

    <script type="text/javascript">
        $(function(){
            
	        // 파일명 input에 출력하는 JS
	        $("#file").on('change',function(){
	            var fileFullName = $("#file").val();	      
	            var fileName = fileFullName.substring(12,fileFullName.length);
	            $(".upload-name").val(fileName);
	        });
        });
        
    </script>
    
    <script type="text/javascript">
    $(function(){
		var status = {
	        	memberNick : true
	        }
	        
	        $("input[name=memberNick]").blur(function() {
				var regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
				var memberNick = $(this).val();
				var span = $(this).next("span");

				var judge = regex.test(memberNick);
				if (!judge) {
					span.text("형식에 맞는 닉네임을 사용하세요.");
					status.memberNick = false;
					return;
				} else {
					span.text("");
					status.memberNick = true;
				}

				var that = this;

				$.ajax({
					url : "http://localhost:8080/moa/ajax/nick.do",
					type : "post",
					data : {
						memberNick : memberNick
					},
					success : function(resp) {
						if (resp === "Y") {
							span.text("사용 가능한 닉네임입니다.");
							status.memberNick = true;
						} else if (resp === "N") {
							span.text("이미 사용 중인 닉네임입니다.");
							status.memberNick = false;
						}
					}
				});
	        });
			
			$(".profile-formcheck").submit(function(){
				if(status.memberNick){
					return true;
				}else{
					alert("닉네임을 작성해주세요.");
					return false;
				}
			});
		
		});
    </script>

                <div class="container fill m40">
                    <form action="edit.do" method="post" enctype="multipart/form-data" class="profile-formcheck">
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
                                    	<%-- <img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="200px" height="200px"class="img img-circle"> --%>
                                    	<a href="delete_profile.do?memberNo=<%=memberNo%>"><img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="200px" height="200px"class="img img-circle"></a>
                                    <%} else { // 존재하지 않는다면 %>
                                    	<img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="200px" height="200px" class="img img-circle">
                                    <%} %>
                                </div>
                                
                                <!-- 프로필 사진 등록 (attach table)-->
                                <div class="row m20 right">
                                    <div class="filebox center">
                                        <%if(isExistProfile) { // 프로필 사진 존재한다면 
                                        	AttachDao attachDao = new AttachDao();
                                        	AttachDto attachDto = attachDao.selectOne(memberProfileDto.getAttachNo());
                                        %>
	                                    	 <input class="upload-name" placeholder="<%=attachDto.getAttachUploadname()%>" style="height: 35px;" disabled>
	                                    <%} else { // 존재하지 않는다면 %>
	                                    	 <input class="upload-name" placeholder="첨부파일" style="height: 35px;" disabled>
	                                    <%} %>
                                        <label for="file" style="height: 35px; font-size:13px;">파일찾기</label> 
                                        <input type="file" id="file" name="attach">
                                    </div>
                                </div>
                            <div>
                            	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
									<p class="f12 link-purple">프로필 사진을 클릭하면 기본 프로필로 변경됩니다.</p>
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
                                        <span class="mt5"></span>
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