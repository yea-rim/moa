<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	$(".check-pw").click(function(){
        var checkList = $(".check-pw").prop("checked");

        if(checkList) {
            // 체크되었으면
            $("input[name=memberPw]").prop("type", "text");
        } else {
            // 체크 해제되면 
            $("input[name=memberPw]").prop("type", "password");
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
                                <h2>회원 탈퇴</h2>
                            </a>
                   	</div>
				
					<div class="row m30"><hr></div>
	</div>
	
	<div class="container w300 m50">
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

<jsp:include page="/template/footer.jsp"></jsp:include>