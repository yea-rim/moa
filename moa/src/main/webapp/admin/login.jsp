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

	<form action="login.do" method="post">

        <div class="container w400">
            <div class="row m50">
                <h1 class="center">관리자 로그인</h1>
            </div>
            
            <%-- "error" 파라미터가 붙으면 --%>
        	<%if(request.getParameter("error") != null) { %>
        		<div class = "row m50 center">
        			<h3>로그인 정보가 일치하지 않습니다.</h3>
        		</div>
        	<%} %>
            
            <!-- 아이디 입력 -->
            <div class="row m5">
                <input type="text" name="adminId" class=" form-input fill" placeholder="관리자 아이디"  autocomplete="off">
            </div>
            
            <!-- 비밀번호 -->
            <div class="row m5">
                <input type="password" name="adminPw" class="form-input fill" placeholder="관리자 비밀번호" autocomplete="off">
            </div>
            
            <!-- 비밀번호 확인하기 -->
            <div class="row m5">
            	<label>
                	<input type="checkbox" class="form-input check-pw">
                    <span class="link-gray">비밀번호 보기</span>
                </label>
            </div>
            
            <div class="row m20">
                <h3><input type="submit" class="form-input btn fill" value="로그인"></h3>
            </div>
        </div>
        
    </form>

<jsp:include page="/template/footer.jsp"></jsp:include>