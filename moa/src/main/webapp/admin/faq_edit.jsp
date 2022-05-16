<%@page import="moa.beans.MoaFaqDto"%>
<%@page import="moa.beans.MoaFaqDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int faqNo = Integer.parseInt(request.getParameter("faqNo"));

	MoaFaqDao moaFaqDao = new MoaFaqDao();
	MoaFaqDto moaFaqDto = moaFaqDao.selectOne(faqNo);
%>
<style>
textarea[name=faqContent] {
	width: 100%;
	height: 500px;
	resize: none;
	padding: 1em;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
    $(function () {
      $(".faq-title").on("input", function(){
    	  var content = $(this).val();
    	  var length = content.length;
    	  console.log(content);
    	  while(length > 30){
    		  $(this).val($(this).val().substring(0, length - 1));
    		  length--;
    	  }
      });
      
      $(".faq-content").on("input", function(){
    	  var content = $(this).val();
    	  var length = content.length;
    	  console.log(content);
    	  while(length > 1300){
    		  $(this).val($(this).val().substring(0, length - 1));
    		  length--;
    	  }
      });
      
  	//전송 시 확인
  	$(".insert-form").submit(function(){
  			var count = 0;
  			var target = $(this).find(".checkValue");
  				target.each(function(){
  					if($(this).val()==""){
  						count++;
  					}
  				});
  				if(count>0){
  					alert("필수 사항을 모두 입력해주세요");
  					return false;			
  				}else{
  					return true;		
  				}
  	});
});
</script>

<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>
	<div class="container w700 m50">
		<div class="row m10">
			<h2>FAQ 수정</h2>
		</div>
		<hr style="border:solid 0.5px lightgray">
		
		<form action="faq_edit.do" method="post" class="insert-form">
			<input type="hidden" name="faqNo" value="<%=moaFaqDto.getFaqNo()%>"> 	
			<div class="row fill m10">			
			<select name="faqCategory" class="form-input fill checkValue" value = "<%=moaFaqDto.getFaqCategory()  %>">
				<%if(moaFaqDto.getFaqCategory().equals("운영정책")){ %>
					<option>선택</option>
					<option >회원정보</option>
					<option selected>운영정책</option>
					<option>이용문의</option>
					<option>기타</option>
			<%}else if(moaFaqDto.getFaqCategory().equals("이용문의")){ %>
					<option>선택</option>
					<option >회원정보</option>
					<option>운영정책</option>
					<option selected>이용문의</option>
					<option>기타</option>
			<%}else if(moaFaqDto.getFaqCategory().equals("기타")){ %>
					<option>선택</option>
					<option >회원정보</option>
					<option>운영정책</option>
					<option >이용문의</option>
					<option selected>기타</option>
			<%}else{ %>
					<option >선택</option>
					<option selected>회원정보</option>
					<option>운영정책</option>
					<option >이용문의</option>
					<option >기타</option>
			<%} %>
			</select>
			</div>

		<div class="row fill m10">
				<input type="text" name="faqTitle" placeholder="FAQ 제목을 입력해 주세요."  class="form-input fill" autocomplete="off" class="faq-title checkValue" value="<%=moaFaqDto.getFaqTitle()%>">
			</div>
			
			<div class="row fill center m10">
				<textarea name="faqContent" placeholder="FAQ 본문을 입력해 주세요." class="faq-content checkValue" autocomplete="off" ><%=moaFaqDto.getFaqContent()%></textarea>
			</div>
			
			<div class="row center fill">
				<button type="submit" class="btn fill">수정</button>
			</div>
		</form>
		
	</div>


<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include> 