<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/template/header.jsp"></jsp:include>

<%
	// 로그인 세션으로 회원 정보 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	// 상세 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
%>

    
    <!-- kakao 우편 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function findAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        // document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        // document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    // document.getElementById('sample6_postcode').value = data.zonecode;
                    $("input[name=memberPost]").val(data.zonecode);
                    // document.getElementById("sample6_address").value = addr;
                    $("input[name=memberBasicAddress]").val(addr);
                    
                    // 커서를 상세주소 필드로 이동한다.
                    // document.getElementById("sample6_detailAddress").focus();
                    $("input[name=memberDetailAddress]").focus();
                }
            }).open();
        }
    </script>
    
    <script type="text/javascript">
        $(function(){
            // 주소 api JS
            $(".address-find-btn").click(findAddress); // 콜백 함수 (예약 실행)
            
	        // 파일명 input에 출력하는 JS
	        $("#file").on('change',function(){
	            var fileFullName = $("#file").val();	      
	            var fileName = fileFullName.substring(12,fileFullName.length);
	            $(".upload-name").val(fileName);
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
                                <h2><a href="<%=request.getContextPath() %>/member/change_phone.jsp" class="link">전화번호 변경</a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/change_address.jsp" class="link link-purple" class="link"><li>주소 변경</li></a></h2>
                            </div>
                            <div class="row m40">
                                <h2><a href="<%=request.getContextPath() %>/member/exit.jsp" class="link">회원 탈퇴</a></h2>
                            </div>
                        </div>
                        
	                        <div class="float-left layer-2">
	                            
		                     <form action="change_address.do" method="post">
		                     	<label>
				                    주소
				                    <%if(memberDto.getMemberPost() == null) { %>
					                    <div class="row m10">
					                        <div>
					                             <input type="text" name="memberPost" id="memberPost" placeholder="우편번호" class="form-input" readonly> 
					                             <button type="button" class="address-find-btn btn">검색</button>
					                        </div>
					                        <div><input type="text" name="memberBasicAddress" placeholder="기본주소" class="form-input fill m5" readonly> </div>
					                        <div><input type="text" name="memberDetailAddress" placeholder="상세주소" class="form-input fill" ></div>
					                    </div>
				                    <%} else {%>
					                    <div class="row m10">
					                        <div>
					                             <input type="text" name="memberPost" id="memberPost" placeholder="우편번호" class="form-input" value="<%=memberDto.getMemberPost() %>" readonly> 
					                             <button type="button" class="address-find-btn btn">검색</button>
					                        </div>
					                        <div><input type="text" name="memberBasicAddress" placeholder="기본주소" class="form-input fill m5" value="<%=memberDto.getMemberBasicAddress() %>" readonly> </div>
					                        <div><input type="text" name="memberDetailAddress" placeholder="상세주소" class="form-input fill" value="<%=memberDto.getMemberDetailAddress()%>"></div>
					                    </div>
				                    <%} %>
				                    <div class="row m10">
				                    	<input type="submit" value="변경하기" class="link link-btn fill">
				                    </div>
				                </label>
		                     </form>
		                     
                    	
                    	</div>
                    	
                    	
                </div>
                
              </div>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>