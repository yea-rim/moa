<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Integer memberNo = (Integer) request.getSession().getAttribute("login");

	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
%>    
    
<jsp:include page = "/template/header.jsp"></jsp:include>

    <style type="text/css">
        .msg {
            color: red;
        }
    </style>

<script type="text/javascript">

        $(function(){
            var status = {
                    memberPhone : true
                }
            
            // 1. 전화번호 형식 검사 
            $("input[name=memberPhone]").blur(function(){
				var regex = /^010([1-9][0-9]{3})([0-9]{4})$/;
				var memberPhone = $(this).val();
				
				var judge = regex.test(memberPhone);
				
				if(!judge) {
					$(this).next("p").text("전화번호 형식에 맞게 입력해주세요.");
					status.memberPhone = false;
					return; 
				} else {
					$(this).next("p").text("");
					status.memberPhone = true;
				}
				
	            var that = this;
	            
	            // 2. 전화번호 중복 검사 
	            $.ajax({
					url : "http://localhost:8080/moa/ajax/phone.do",
					type : "post",
					data : {
						memberPhone : memberPhone
					},
					success : function(resp) {
						if (resp === "Yes") {
							$(that).next("p").text("");
							status.memberPhone = true;
						} else if (resp === "No") {
							$(that).next("p").text("이미 가입된 전화번호입니다.");
							status.memberPhone = false;
						}
					}
				});
            });
            
            $(".phone-formcheck").submit(function(){
            	if(status.memberPhone){
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
                                <h2><a href="<%=request.getContextPath() %>/member/change_password.jsp" class="link">비밀번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_phone.jsp" class="link link-purple"><li>전화번호 변경</li></a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_address.jsp" class="link">주소 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/exit.jsp" class="link">회원 탈퇴</a></h2>
                            </div>
                        </div>
                        
	                        <div class="float-left layer-2">
	                            
		                     <form action="change_phone.do" method="post" class="phone-formcheck">
		                     	<label>
					                    전화번호
					            </label>
					            <div class="row m10">
				                     	<input type="text" name="memberPhone" class="form-input fill" autocomplete="off" value="<%=memberDto.getMemberPhone()%>">
						                <p class="right msg"></p>
					            </div>
					            <div class="row m10">
		                        	<input type="submit" value="변경하기" class="link link-btn fill">
		                        </div>
		                     </form>
		                     
                    	
                    	</div>
                    	
                    	
                </div>
               </div>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>