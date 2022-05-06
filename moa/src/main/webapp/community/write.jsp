
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>moa 홍보게시글 작성</title>

<jsp:include page="/template/header.jsp"></jsp:include>

    <!-- 폰트 cdn -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap" rel="stylesheet"> 
    
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"/>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"/>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	<!-- css 링크 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/commons.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/layout.css" type="text/css">

<script type="text/javascript">
$(function(){
	$('textarea[name=communityContent]').summernote({
		  height: 500,                
		  minHeight: 500,            
		  maxHeight: 500,            
		  focus: true,                
		  placeholder: '내용을 입력해주세요'
        
	});
});
</script>

	<div class="container w800 m50">
	
		<div class="row">
			<h2>게시글 작성</h2>
		</div>
	
		<form action="write.kh" method="post">
						<div class="row fill m10">
							<input type="text" name="communityTitle" required placeholder="제목을 입력해주세요"  class="form-input fill">
						</div>
						<div class="row fill center">
							<textarea name="communityContent" required></textarea>
						</div>
						<div class="row center fill">
							<button type="submit" class="btn fill">작성</button>
						</div>
		</form>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>