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
                <h1 class="center">로그인</h1>
            </div>
            
            <%-- "error" 파라미터가 붙으면 --%>
        	<%if(request.getParameter("error") != null) { %>
        		<div class = "row m50 center">
        			<h3>로그인 정보가 일치하지 않습니다.</h3>
        		</div>
        	<%} %>
            
            <!-- 아이디 입력 -->
            <div class="row m5">
                <input type="text" name="memberEmail" class=" form-input fill" placeholder="이메일 아이디"  autocomplete="off">
            </div>
            
            <!-- 비밀번호 -->
            <div class="row m5">
                <input type="password" name="memberPw" class="form-input fill" placeholder="비밀번호(영문, 숫자, 특수 문자 포함)" autocomplete="off">
            </div>
            
            <!-- 비밀번호 확인하기 -->
            <div class="float-container m10">
                <div class="float-left">
                    <label>
                        <input type="checkbox" class="form-input check-pw">
                        <span class="link-gray">비밀번호 보기</span>
                    </label>
                </div>
                
                <!-- 아이디 / 비밀번호 찾기 -->
                <div class="float-right">
                    <a href="" class="link link-gray">아이디 | 비밀번호 찾기</a>
                </div>
            </div>
            
            <div class="row m20">
                <h3><input type="submit" class="form-input btn fill" value="로그인"></h3>
            </div>
            
            <div class="row m50">
                <hr>
            </div>
            
            <div class="float-container">
            	<!-- 회원가입 페이지 -->
                <div class="float-left layer-2 right">
                    <a href="" class="link">아직 계정이 없으신가요?</a>
                </div>
                
                <!-- 관리자 로그인 페이지 -->
                <div class="float-right layer-2 center">
                    <a href="" class="link link-purple">관리자</a>
                </div>
            </div>
        </div>
        
    </form>

<jsp:include page="/template/footer.jsp"></jsp:include>