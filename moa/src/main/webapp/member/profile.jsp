<%@page import="moa.beans.MemberProfileDto"%>
<%@page import="moa.beans.MemberProfileDao"%>
<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 로그인 세션으로 회원 정보 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	// 상세 조회
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
	
	// 회원 프로필 사진 조회
	MemberProfileDao memberProfileDao = new MemberProfileDao();
	MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberNo);
	
	// 회원 프로필 존재 여부 확인 
	boolean isExistProfile = memberProfileDto != null; 
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

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
	            var fileName = $("#file").val();
	            $(".upload-name").val(fileName);
	        });
        });

    </script>

                <div class="container fill m40">
                    <form action="edit.do" method="post" enctype="multipart/form-data">
						<input type = "hidden" name = "memberNo" value="<%=memberNo%>">
                    
                        <div class="flex-container">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="my_page.jsp" class="link mlr5">
                                <h2>프로필 설정</h2>
                            </a>
                        </div>
    
                        <div class="row m30"><hr></div>
    
                        <div class="float-container m50">
                            <!-- 프로필 사진 변경 -->
                            <div class="float-left layer-2 center">
                                <!-- 프로필 사진 출력 -->
                                <div class="row">
                                    <%if(isExistProfile) { // 프로필 사진 존재한다면 %>
                                    	<img src = "<%=request.getContextPath() %>/attach/download.do?attachNo=<%=memberProfileDto.getAttachNo()%>" width="200px" height="200px"class="img img-circle">
                                    	
                                    	<%-- <%=memberProfileDto.getAttachNo() %> --%>
                                    	
                                    <%} else { // 존재하지 않는다면 %>
                                    	<img src="<%=request.getContextPath() %>/image/profile.png" alt="기본 프로필" width="200px" height="200px" class="img img-circle">
                                    <%} %>
                                </div>
                                
                                <!-- 프로필 사진 등록 (attach table)-->
                                <div class="row m20 right">
                                    <div class="filebox center">
                                        <input class="upload-name" value="첨부파일" placeholder="첨부파일">
                                        <label for="file">파일찾기</label> 
                                        <input type="file" id="file" name="attach">
                                    </div>
                                </div>
                            <div>
                            	<%if(isExistProfile) { // 프로필 사진 존재한다면 %>
									<a href="delete_profile.do?memberNo=<%=memberNo%>"><button type="button" class="btn">프로필 사진 삭제</button></a>
								<%} %>
                            </div>
                            </div>
                            

                            <div class="float-left layer-2 center">
    
                                <!-- 개인 정보 수정 -->
                                <div class="container w400">
                                    <!-- 닉네임 입력 -->
                                    <div class="row">
                                        닉네임 
                                    </div>
                                    <div class="row m5">
                                        <input type="text" name="memberNick" value="<%=memberDto.getMemberNick() %>" autocomplete="off" class="form-input fill">
                                    </div>
        
                                    <!-- 전화번호 입력 -->
                                    <div class="row">
                                        전화번호  
                                    </div>
                                    <div class="row m5">
                                        <input type="text" name="memberPhone" value="<%=memberDto.getMemberPhone() %>" autocomplete="off" class="form-input fill">
                                    </div>
        
                                    <!-- 주소 입력 -->
                                    <div class="row">
                                        주소
                                    </div>
                                    <div class="row m5">
                                        <div>
                                            <input type="text" name="memberPost" id="memberPost" placeholder="우편번호" class="form-input" readonly> 
                                            <button type="button" class="address-find-btn btn">검색</button>
                                        </div>
                                        <div><input type="text" name="memberBasicAddress" placeholder="기본주소" class="form-input fill m5" readonly> </div>
                                        <div><input type="text" name="memberDetailAddress" placeholder="상세주소" class="form-input fill"> </div>
                                    </div>
                                    <!-- 변경 버튼 -->
                                    <div class="row m30">
                                        <input type="submit" value="프로필 변경" class="link link-btn fill">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                </div>
                
                <%-- <div class="float-left layer-2 center">
                    	<form action="delete_profile.do" method="post">
                    		<input type="hidden" name="memberNo" value="<%=memberNo%>">
                    		<input type="submit" value="프로필 사진 삭제" class="btn">
                    	</form>
                    </div> --%>

<jsp:include page="/template/footer.jsp"></jsp:include>