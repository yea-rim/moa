<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".check-pw").on("input", function(){
    		$("input[name=memberPw]").prop("type", "text"); // 비밀번호 보여주기 
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
                                <h2>비밀번호 확인</h2>
                            </a>
                           
                   	</div>
				
					<div class="row m30"><hr></div>
				</div>
					
				<div class="container w300">
					
                    <form action="confirm_pw.do" method="post">
                        <div class="row m10">
                            <input type="password" class="form-input fill" name="memberPw">
                        </div>
                        <div class="row m10">
			                    <label>
			                        <input type="checkbox" class="form-input check-pw">
			                        <span class="link-gray">비밀번호 보기</span>
			                    </label>
			            </div>
                        
                        <divc class="row m30">
                            <input type="submit" class="btn fill" value="확인">
                        </div>
                    </form>
                    
                    <div class="row m20">
                    	<%if(request.getParameter("error") != null) { // error 파라미터가 붙으면 %> 
                    	<h3>비밀번호가 일치하지 않습니다.</h3>
                    <%} %>
                    </div>
                    
                </div>

<jsp:include page="/template/footer.jsp"></jsp:include>