<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<title>moa FAQ 작성</title>

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
});
</script>

<jsp:include page="/admin/admin_template/admin_header.jsp"></jsp:include>

<hr style="border:solid 0.5px lightgray">
	<div class="container w700 m50">
		
		<div class="row">
			<h2>FAQ 작성</h2>
		</div>
		
		<form action="insert.do" method="post" enctype="multipart/form-data">
					
			<div class="row fill m10">			
			<select name="faqCategory" required class="form-input fill">
				<option  selected disabled>선택</option>
				<option value="회원정보">회원정보</option>
				<option value="운영정책">운영정책</option>
				<option value="이용문의">이용문의</option>
				<option value="기타">기타</option>
			</select>
			</div>

		<div class="row fill m10">
				<input type="text" name="faqTitle" required placeholder="FAQ 제목을 입력해 주세요."  class="form-input fill" autocomplete="off" class="faq-title">
			</div>
			
			<div class="row fill center m10">
				<textarea name="faqContent" required placeholder="FAQ 본문을 입력해 주세요." class="faq-content" autocomplete="off" ></textarea>
			</div>
			
			<div class="row center fill">
				<button type="submit" class="btn fill">작성</button>
			</div>
		</form>
		
	</div>


<jsp:include page="/admin/admin_template/admin_footer.jsp"></jsp:include> 