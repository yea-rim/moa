<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/template/header.jsp"></jsp:include>

    <style type="text/css">
        .msg {
            color: red;
        }
    </style>

<script type="text/javascript">
	$(function(){
		$(".check-pw").click(function(){
	        var checkList = $(".check-pw").prop("checked");
	
	        if(checkList) {
	            // 체크되었으면
	            $("input[name=changePw]").prop("type", "text");
	        } else {
	            // 체크 해제되면 
	            $("input[name=changePw]").prop("type", "password");
	        }
	    });
	});
</script>

<script type="text/javascript">
        $(function(){
        	
	        var status = {
	            changePw : true
	        }
            // 1. 비밀번호 형식 검사
            $("input[name=changePw]").blur(function(){
                var regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$])[A-Za-z\d!@#$]{8,16}$/;
                var changePw = $(this).val();

                var judge = regex.test(changePw);

                if(!judge) {
                    $(this).next("p").text("비밀번호 형식을 맞춰주세요.");
                    status.changePw = false;
                    return;
                } else {
                	$(this).next("p").text("");
                	status.changePw = true;
                }
                console.log(status.changePw);
            });
            
            $(".pw-formcheck").submit(function(){
            	if(status.changePw){
            		return true;
            	}else{
            		alert("형식에 맞게 입력 해주세요.");
            		return false;
            	}
            		
            });
            
        });
    </script>

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
                                <h2><a href="<%=request.getContextPath() %>/member/change_password.jsp" class="link link-purple"><li>비밀번호 변경</li></a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_phone.jsp" class="link">전화번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_address.jsp" class="link">주소 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/exit.jsp" class="link">회원 탈퇴</a></h2>
                            </div>
                        </div>
                        
	                        <div class="float-left layer-2">
	                            
		                     <form action="change_password.do" method="post" class="pw-formcheck">
					            <div class="row">
					                <label>
					                    변경할 비밀번호
					                </label>
					                    <div class="row m10">
					                        <input type="password" name="changePw" class="form-input fill" autocomplete="off" placeholder="비밀번호(영문, 숫자, 특수 문자 포함)">
						                    <p class="right msg"></p>
					                    </div>
					            </div>
					            
					            <div class="row m10">
									<label>
										<input type="checkbox" class="form-input check-pw">
										<span class="link-gray">비밀번호 보기</span>
									</label>
	                        </div>
	                        
	                        <div class="row mt30">
	                        	<input type="submit" value="변경하기" class="link link-btn fill">
	                        </div>
                        
		                    </form>
		                    
		                    <%if(request.getParameter("error") != null) { %>
                    			<div class="row mt20 fill">
		                    		<h3 class="center">기존 비밀번호와 다른 비밀번호를 입력해주세요.</h3>
		                    	</div>
                    	<%} %>
		                    
                    	</div>
                    	
                    	
                </div>
             </div>
              
                
                
                
<jsp:include page = "/template/footer.jsp"></jsp:include>