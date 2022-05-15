<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".check-pw").click(function(){
	        var checkList = $(".check-pw").prop("checked");
	
	        if(checkList) {
	            // 체크되었으면
	            $("input[name=currentPw]").prop("type", "text");
	            $("input[name=changePw]").prop("type", "text");
	        } else {
	            // 체크 해제되면 
	            $("input[name=currentPw]").prop("type", "password");
	            $("input[name=changePw]").prop("type", "password");
	        }
	    });
	});
</script>

<script type="text/javascript">
        var status = {
            currentPw : false,
            changePw : false
        }

        $(function(){
            // 1. 비밀번호 형식 검사
            $("input[name=changePw]").blur(function(){
                var regex = /[a-zA-Z0-9]{8,16}/;
                var changePw = $(this).val();

                var judge = regex.test(changePw);

                if(!judge) {
                    $(this).next("span").text("비밀번호 형식을 맞춰주세요.");
                    status.changePw = false;
                    return;
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
                    <div class="flex-container">
                        <div class="p10 mlr40" style="flex-grow: 1;">
                            <div class="row">
                                <h2><a href="" class="link link-purple"><li>비밀번호 변경</li></a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="" class="link">전화번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="" class="link">주소 변경</a></h2>
                            </div>
                        </div>
                        
	                        <div class="p10 mlr50" style="flex-grow: 2;">
	                            
		                     <form action="change_password.do" method="post">
	                            <div class="row m20">
					                <label> 
					                    기존 비밀번호 
					                    <div class="row m10">
					                        <input type="password" name="currentPw" class="form-input fill" autocomplete="off">
					                    </div>
					                </label>
					            </div>
					            <div class="row m20">
					                <label>
					                    변경할 비밀번호
					                    <div class="row m10">
					                        <input type="password" name="changePw" class="form-input fill" autocomplete="off">
						                    <span></span>
					                    </div>
					                </label>
					                
					            </div>
					            
					            <div class="row m10">
									<label>
										<input type="checkbox" class="form-input check-pw">
										<span class="link-gray">비밀번호 보기</span>
									</label>
	                        </div>
	                        
	                        <div class="row m10">
	                        	<input type="submit" value="변경하기" class="link link-btn fill">
	                        </div>
                        
		                    </form>
                    	</div>
                </div>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>