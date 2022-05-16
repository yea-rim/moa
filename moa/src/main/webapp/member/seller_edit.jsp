<%@page import="moa.beans.SellerDto"%>
<%@page import="moa.beans.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 회원번호 가져오기 
	Integer memberNo = (Integer) session.getAttribute("login");

	SellerDao sellerDao = new SellerDao();
	SellerDto sellerDto = sellerDao.selectOne(memberNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style type="text/css">
	span {
		color: red;
	}
</style>

<script type="text/javascript">
$(function() {
	var status = {
            sellerNick : true,
            sellerAccountNo: true,
            sellerAccountBank: true
        }

	// 판매자 닉네임 형식 검사 --> 중복 검사
	$("input[name=sellerNick]").blur(function() {
		var regex = /^[가-힣a-zA-Z0-9]{2,10}$/;
		var sellerNick = $(this).val();
		var span = $(this).next("span");

		var judge = regex.test(sellerNick);
		if (!judge) {
			span.text("형식에 맞는 판매자 닉네임을 입력해주세요.");
			status.sellerNick = false;
			return;
		} else {
			span.text("");
			status.sellerNick = true;
		}

		var that = this;

		$.ajax({
			url : "http://localhost:8080/moa/ajax/sellerNick.do",
			type : "post",
			data : {
				sellerNick : sellerNick
			},
			success : function(resp) {
				if (resp === "YY") {
					span.text("");
					status.sellerNick = true;
				} else if (resp === "NN") {
					span.text("이미 사용 중인 판매자 닉네임입니다.");
					status.sellerNick = false;
				}
			}
			
			
		});
	
	});
	
		$("input[name=sellerAccountNo]").blur(function() {
			var regex = /[0-9]/;
			var sellerAccountNo = $(this).val();
			var span = $(this).next("span");

			var judge = regex.test(sellerAccountNo);
			if (!judge) {
				span.text("숫자만 입력해주세요.");
				status.sellerAccountNo = false;
				return;
			} else {
				span.text("");
				status.sellerAccountNo = true;
			}
		});
		
		$("input[name=sellerAccountBank]").blur(function(){
			if($(this).val() == ""){
				status.sellerAccountBank = false;
			}else{
				status.sellerAccountBank = true;
			}
		});
		
		
		$(".seller-edit-formcheck").submit(function(){
			if(status.sellerNick && status.sellerAccountNo && status.sellerAccountBank){
				return true;
			}else{
				alert("필수 정보를 입력해주세요.");
				return false;
			}
		});
		
	
});
</script>




	<div class="container mt40">
		
		<div class="flex-container">
                            <!-- 마이페이지 메인으로 이동 -->
                            <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
                            <a href="<%=request.getContextPath() %>/seller/my_page.jsp">
                                <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
                            </a>
                            <a href="<%=request.getContextPath() %>/seller/my_page.jsp" class="link mlr5">
                                <%if(sellerDto.getSellerPermission() == 1) { // 판매자이면 %>
                                	<h2>판매자 정보 변경하기</h2>
                                <%} else { // 판매자 신청 대기 중이면 %>
                                	<h2>판매자 신청 정보 변경하기</h2>
                                <%} %>
                            </a>
        </div>
        
        <div class="row m30"><hr></div>
        
        <div class="container mt60">
			
			<form action="<%=request.getContextPath() %>/member/seller_edit.do" method="post" class="seller-edit-formcheck">	
			<input type="hidden" name="sellerNo" value="<%=sellerDto.getSellerNo()%>">
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>판매자 닉네임</h2>
						<br>
						<p>판매자로 사용할 닉네임을 입력해주세요. (10자 이내)</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerNick" value="<%=sellerDto.getSellerNick()%>" class="row m10 form-input fill answer" autocomplete="off">
						<span></span>
					</div>
				</div>
				
				<br><br>
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>입금 은행</h2>
						<br>
						<p>후원금이 전달될 계좌의 은행명을 입력해주세요.</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerAccountBank" value="<%=sellerDto.getSellerAccountBank()%>" class="row m10 form-input fill" autocomplete="off">
					</div>
				</div>
				
				<br><br>
				
				<div class="float-container">
					<div class="float-left layer-2">
						<h2>입금 계좌</h2>
						<br>
						<p>후원금이 전달될 계좌번호를 입력해주세요. ('-' 제외)</p>
					</div>
					<div class="float-left layer-2">
						<input type="text" name="sellerAccountNo" value="<%=sellerDto.getSellerAccountNo()%>" class="row m10 form-input fill" autocomplete="off">
						<span></span>
					</div>
				</div>
				
				<br><br>
				
				
				<div class="row m20 mt50 center">
					<input type="submit" value="변경하기" class="btn form-answer">
				</div>
			
			</form>
			
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>