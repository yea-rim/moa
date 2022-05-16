<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page = "/template/header.jsp"></jsp:include>


	<div class="container fill m40">
					<div class="flex-container m20">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="my_page.jsp" class="link mlr5">
                                <h2>개인정보 설정</h2>
                            </a>
                   	</div>
				
					<div class="row m30"><hr></div>
	</div>


			<div class="container">
			
                    <div class="float-container">
                        <div class="float-left layer-2">
                            <div class="row">
                                <h2><a href="<%=request.getContextPath() %>/member/change_password.jsp" class="link">비밀번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_phone.jsp" class="link">전화번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_address.jsp" class="link">주소 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/exit.jsp" class="link link-purple"><li>회원 탈퇴</li></a></h2>
                            </div>
                        </div>
                        
	                        <div class="float-left layer-2">
	                            
		                     <form action="exit.do" method="post">
					        	<div class="row m10">
					            	<label>비밀번호 재입력
					            		<input type="password" class="form-input fill m10" name="memberPw">
					            	</label>
					            	<label>
										<input type="checkbox" class="form-input check-pw">
										<span class="link-gray">비밀번호 보기</span>
									</label>
					        	</div>
					        	<div class="row m10">
					        		<input type="submit" value="확인" class="btn fill"> 
					        	</div>
					        </form>
		                     
                    	
                    	</div>
                    	
                    	
                </div>
               </div>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>