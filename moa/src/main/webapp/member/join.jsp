<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    
<script type="text/javascript">
	$(function(){
		$(".check-pw").on("input", function(){
    		$("input[name=memberPw]").prop("type", "text"); // 비밀번호 보여주기 
    	});
		
		var status = {
                //이름 : 값
                memberEmail : false,
                memberNick : false,
                memberPhone : false,
                memberRoute : false
            };

            $("input[name=memberEmail]").blur(function(){

                var regex = /[a-z][a-z0-9]{7,19}/;
                var memberEmail = $(this).val();

                var judge = regex.test(memberEmail);
                if(!judge) {
                    $(this).next("span").text("아이디를 형식에 맞게 작성해 주세요.");
                    status.email = false;
                    return;
                }

                var that = this;

                $.ajax({
                    url:"http://localhost:8080/moa/ajax/id.do?memberEmail="+memberEmail,
                    type:"get",
                    success:function(resp) {
                        // resp는 "NNNNN" 또는 "NNNNY"
                        if(resp == "NNNNN"){
                            $(that).next("span").text("이미 사용 중인 이메일입니다.");
                            status.email = false;
                        }
                        else if(resp == "NNNNY"){
                            $(that).next("span").text("사용 가능한 이메일입니다.");
                            status.email = true;
                        }
                    }
                });
            });

            $("input[name=memberNick]").blur(function(){
                var regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
                var memberNick = $(this).val();
                var span = $(this).next("span");

                var judge = regex.test(memberNick);
                if(!judge){
                    span.text("형식에 맞는 닉네임을 사용하세요.");
                    status.nickname = false;
                    return;
                }

                $.ajax({
                    url:"http://localhost:8080/moa/member/join.do",
                    type:"post",
                    data:{
                        memberNick : memberNick
                    },
                    success:function(resp) {
                        if(resp === "Y") {
                            span.text("사용 가능한 닉네임입니다");
                            status.nickname = true;
                        }
                        else if(resp === "N") {
                            span.text("사용 불가능한 닉네임입니다");
                            status.nickname = false;
                        }
                    }
                });
            });

	});
</script>

    <form action="join.do" method="post">
    
        <div class="container w450 m30">
        
            <div class="row center">
                <h1>회원가입</h1>
            </div>
            
            <div class="row m20">
                <label>* 이메일</label>
                <input type="email" name="memberEmail" required class="form-input fill input-round" autocomplete="off">
                <span></span>
            </div>
            
            <div class="row m20">
                <label>* 비밀번호</label>
                <input type="password" name="memberPw" required placeholder="영어, 숫자, 특수문자 8~16자" class="form-input fill input-round">
                <span></span>
            </div>
                        
            <div class="row m20">
                <label>* 닉네임</label>
                    <input type="text" name="memberNick" required placeholder="한글, 숫자 10자 이내" autocomplete="off" class="form-input fill input-round">
                <span></span>
            </div>
                          
            <div class="row m20">
                <label>* 전화번호</label>
                <input type="tel" name="memberPhone" required placeholder="- 제외하고 입력" class="form-input fill input-round" autocomplete="off">
                <span></span>
            </div>
              
            <div class="row m20">
                <label>* 가입 경로</label>
                <select name="memberRoute" class="form-input input-round">
                    <option selected disabled>선택</option>                
                    <option value="친구 추천">친구 추천</option>
                    <option value="인터넷 검색">인터넷 검색</option>
                    <option value="광고">광고</option>
                    <option value="sns">sns</option>
                    <option value="기타">기타</option>
                </select>
                <span></span>
            </div>
              
            <div class="row m20">
                <button type="submit" class="btn btn-primary fill">회원가입</button>
            </div>
            
        </div>
    </form>
    
<jsp:include page="/template/footer.jsp"></jsp:include>