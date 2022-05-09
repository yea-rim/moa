<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".check-pw").on("input", function(){
    		$("input[name=currentPw]").prop("type", "text"); // 비밀번호 보여주기
    		$("input[name=changePw]").prop("type", "text");
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

	<div class="container w300 m50">
        <form action="edit_information.do" method="post">
            <div class="row m20">
                <label> 
                    기존 비밀번호 
                    <div class="row m10">
                        <input type="password" name="currentPw" class="form-input fill">
                    </div>
                </label>
            </div>
            <div class="row m20">
                <label>
                    변경할 비밀번호
                    <div class="row m10">
                        <input type="password" name="changePw" class="form-input fill">
                    </div>
                </label>
            </div>
            
            <div class="row m10">
				<label>
					<input type="checkbox" class="form-input check-pw">
					<span class="link-gray">비밀번호 보기</span>
				</label>
			</div>
            
            <div class="row m20">
                <input type="submit" value="확인" class="btn fill">
            </div>
        </form>
        
        <%if(request.getParameter("error=1") != null) { %>
        	<h3>기존 비밀번호와 같은 비밀번호로 수정할 수 없습니다.</h3>
        <%} %>
        
        <%if(request.getParameter("error=2") != null) { %>
        	<h3>비밀번호를 입력해주세요.</h3>
        <%} %>
        
    </div>
    
    <div class="container">
        	<div class="row m20 right mlr20">
            	<a href="exit.jsp" class="link link-btn">
            		회원 탈퇴
            	</a>
        	</div>
    </div>

<jsp:include page="/template/footer.jsp"></jsp:include>