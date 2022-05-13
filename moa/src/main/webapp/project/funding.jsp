<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@page import="moa.beans.ProjectDto"%>
<%@page import="moa.beans.ProjectDao"%>
<%@page import="moa.beans.RewardDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.RewardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Integer memberNo = (Integer) session.getAttribute("login"); 
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.selectOne(memberNo);
%>
<%
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	
	ProjectDao projectDao = new ProjectDao();
	
	ProjectDto projectDto = projectDao.selectOne(projectNo);
	RewardDao rewardDao = new RewardDao();

	List<RewardDto> list = rewardDao.selectProject(projectNo);

	
	int count = 1;
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/funding.css">


<style>

</style>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/funding.js"></script>


<!-- 멀티페이징 -->
<script type="text/javascript">
    /* $(function(){
        var index = 0;
        move(index);
     
     
     $("#nextstep").click(function(){
         move(++index);
     });

     $("#prevstep").click(function(){
         move(--index);
     });

     function move(index){
         $(".page").hide();
         $(".page").eq(index).show();
     };

    }); */
 </script>

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
                    $("input[name=fundingPost]").val(data.zonecode);
                    // document.getElementById("sample6_address").value = addr;
                    $("input[name=fundingBasicAddress]").val(addr);
                    
                    // 커서를 상세주소 필드로 이동한다.
                    // document.getElementById("sample6_detailAddress").focus();
                    $("input[name=fundingDetailAddress]").focus();
                }
            }).open();
        }
    </script>
    <script type="text/javascript">
        $(function(){
            $(".address-find-btn").click(findAddress);//콜백함수
        });
       
    </script>

    <form action="funding.do" method="post">
		<input name="projectNo" value="<%=projectNo%>" hidden>
        <div class="container w800 page" id="price-container">
			
            <div class="center">
                <img src="<%=request.getContextPath() %>/image/select.png" width="250px">
            </div>
            <hr>
			
			<%for(RewardDto rewardDto : list) {%>
            <div class="flex-container reward-select m20">
				<span class="rewardCount" hidden><%=count++ %></span>
                <div class="check-reward w30p">
                    <input type="checkbox" name="rewardNo" value="<%=rewardDto.getRewardNo() %>" class="reward-checkbox">
                </div>
                
                <div class="reward m30 w70p">
                    <h3><span class="reward-price number"><%=rewardDto.getRewardPrice() %></span>원 후원하기</h3>
                    <br>
                    <h3 class="reward-title" style="font-size: 16px;"><%=rewardDto.getRewardName() %></h3>
                    <br>
                    <span class="reward-content" style="color: grey; font-size: 13px;">
                        <pre><%=rewardDto.getRewardContent() %></pre>
                        </span>
                    <br>
                    <span style="font-size: 13px;">배송비 : <span class="delivery number" data-value="<%=rewardDto.getRewardEach() %>"><%=rewardDto.getRewardDelivery() %></span></span>
                    <br>
                    <span style="font-size: 13px;">재고 : <%=rewardDto.getRewardStock() %>개     ||     결제 예정일 : <%=projectDao.paymentDate(projectNo) %></span>
                    <div class="flex-container m20 detail">
                        <div class="amount">
                            <label style="margin-bottom: 10px;">수량</label>
                            <div style="height: 30px; display: flex;">
	                            <button type="button" class="minus-btn">-</button>
	                            <input type="text" name="selectionRewardAmount" class="form-input" value="1" readonly>
	                            <button type="button" class="plus-btn">+</button>
                            </div>
                        </div>
                        <%if(rewardDto.getRewardIsoption() > 0){%>
                        <div class="detail-option">
                            <label for="">상세옵션 : </label>
                            <input type="text" name="selectionOption" class="form-input">
                        </div>
                        <%} %>
                        <!-- <div class="detail-option"></div> -->
                    </div>
                </div>
            </div>
            <%} %>

            

            <div class="total center m-t40">
                <h3 style="color: gray;">총 펀딩 금액은 <span id="total-price" style="color: black;"></span>원 입니다.</h3>
            </div>

            <div class="center m40">
                <button type="button" id="nextstep" class="btn next-btn">다음 단계로 ></button>
            </div>

        </div>




        <!-- //////////////////////////////////////////////////////////////////////////////// -->
        <div id="funding-container" class="container w650 left page">

            <div class="center">
                <img src="<%=request.getContextPath() %>/image/funding.png" width="250px;">
            </div>

            <hr>
            <div id="reward-checklist">
            </div>
            <div class="pay-box">
                <div class="float-container m-b20">
                    <span class="float-left">펀딩 금액</span> <span class="float-right" id="funding-total"></span>
                </div>
                <div class="float-container m-b20">
                    <span class="float-left">총 배송비</span> <span class="float-right" id="delivery-total"></span>
                    
                </div>
                <hr class="dotline">
                <div class="float-container m-b20">
                    <span class="float-left">최종결제금액</span> <span class="float-right" id="final" style="font-size: 20px;"></span>
                </div>
                
            </div>
            <hr style="margin-bottom: 30px;">

            <!-- 배송지 정보 -->
            <div class="float-container">
                <!-- 좌측부분 -->
                <div class="float-left layer-2">
                    <div>
                        <h2>펀딩 서포터</h2>
                    </div>
                    <div id="supporter">
                        <div>이메일</div>
                        <div class="font-gray"><%=memberDto.getMemberEmail() %></div>
                        <div>닉네임</div>
                        <div class="font-gray"><%=memberDto.getMemberNick() %></div>
                        <div>핸드폰번호</div>
                        <div class="font-gray"><%=memberDto.getMemberPhone() %></div>
                        <hr>
                        <div class="float-container" style="padding-top: 20px;">
                            <div class="float-left w10p">
                                <input type="checkbox" id="hungry" style="accent-color: #b899cd;">
                            </div>
                            <div class="float-left w90p">
                                <label for="hungry">(디자인용) 펀딩 진행 상황 안내 문자를 받습니다.</label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 우측부분 -->
                <div class="float-left layer-2">
                    <div>
                        <h2>리워드 배송지</h2>
                    </div>
                    <hr>
                    <div id="location">
                        
                        <div>
                            <div class="row">
                                수령인
                                <span class="check-empty" style="color: red; font-size: 13px; display:none;">&nbsp;&nbsp;&nbsp;필수 정보를 입력해주세요.</span>
                                <span class="check-regex" style="color: red; font-size: 13px; display:none;">&nbsp;&nbsp;&nbsp;올바른 형식으로 입력해주세요.</span>
                            </div>
                            
                            <div class="row m5">
                                <input type="text" name="fundingGetter" value="" autocomplete="off" class="form-input fill check">
                            </div>
                        </div>
                        <div>
                            <div class="row">
                                전화번호
                                <span class="check-empty" style="color: red; font-size: 13px; display:none;">&nbsp;&nbsp;&nbsp;필수 정보를 입력해주세요.</span>
                                <span class="check-regex" style="color: red; font-size: 13px; display:none;">&nbsp;&nbsp;&nbsp;올바른 형식으로 입력해주세요.</span>
                            </div>
                            <div class="row m5">
                                <input type="text" name="fundingPhone" value="" autocomplete="off" class="form-input fill check">
                            </div>
                        </div>
                        
                        <!-- 주소 입력 -->
                        <div>
                            <div class="row">
                                주소
                                <span class="check-empty" style="color: red; font-size: 13px; display: none;">&nbsp;&nbsp;&nbsp;필수 주소 정보를 모두 입력해주세요.</span>
                            </div>
                            <div class="row m5">
                                <div>
                                    <input type="text" name="fundingPost" id="memberPost" placeholder="우편번호" class="form-input check-address" readonly> 
                                    <button type="button" class="address-find-btn btn">검색</button>
                                </div>
                                <div><input type="text" name="fundingBasicAddress" placeholder="기본주소" class="form-input fill m5 check-address" readonly> </div>
                                <div><input type="text" name="fundingDetailAddress" placeholder="상세주소" class="form-input fill check-address"> </div>
                            </div>
                        </div>
                        <div>
                            <div class="row">
                                배송메세지
                            </div>
                            <div class="row m5">
                                <input type="text" name="fundingPostMessage" class="form-input fill" placeholder="ex) 부재 시 경비실에 맡겨 주세요.">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            

            <div class="m40">
                <h2>결제정보</h2>
                <div class="empty">
                    생략
                </div>
            </div>
            <div class="m40">
                <h2>약관동의</h2>
                <div class="empty">
                    생략
                </div>
            </div>

            <div class="center m40">
                <button type="button" id="prevstep" class="btn reserve-btn">< 이전 단계로</button>
                <input type="submit" class="btn reserve-btn" value="결제 예약하기">
            </div>

        </div>
        
    </form>
<jsp:include page="/template/footer.jsp"></jsp:include>