<%@page import="moa.beans.PjProgressDto"%>
<%@page import="moa.beans.PjProgressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 준비 --%>
<% 
	int progressNo = Integer.parseInt(request.getParameter("progressNo"));
%>
<%-- 처리 --%>
<% 
	PjProgressDao pjProgressDao = new PjProgressDao();
	PjProgressDto pjProgressDto = pjProgressDao.selectOne(progressNo);
%>
<title>프로젝트 공지 수정</title>
<style>
textarea[name=progressContent] {
	height: 400px;
}

.filebox-a input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

/* 인풋 스타일 변경 */
.upload-name {
	display: inline-block;
	height: 35px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #B6B6B6;
	border-radius: 0.3em;
	width: 50%;
	color: #999999;
}

/* label 스타일 변경 */
.filebox-a label {
	display: inline-block;
	padding: 10px 10px;
	color: white;
	vertical-align: middle;
	background-color: #dddddd;
	border-radius: 0.3em;
	cursor: pointer;
	height: 35px;
	margin-left: 5px;
	font-size: 13px;
}

.table.table-a>tbody>tr>th, .table.table-a>tbody>tr>td {
	text-align: left;
	border-bottom: 0.5px solid #f1f2f6;
	padding: 1em;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	
    $(function () {
    	
      	// 작성중 페이지 이탈 방지
	    var checkUnload = true;
	    $(".progress-submit").on("click", function () {
	      checkUnload = false;
	    });
	    
	    $(window).on("beforeunload", function () {
	      if (checkUnload) {
	    	  return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
	      }
	    }); 
	    
        // null검사
	    $(".form-all").on("submit", function () {
	          if (vali($(".progress-title").val())) {
	            alert("제목을 입력해주세요");
	            return false;
	          } 
	          else {
	            return true;
	          }
	        });

        $(".form-all").on("submit", function () {
            if (vali($(".progress-content").val())) {
              alert("내용을 입력해주세요");
              return false;
            } 
            else {
              return true;
            }
          });
        
        function vali(val) {
            if (val === null) return true;
            if (val === "") return true;
            if (typeof val === "undefined") return true;

            return false;
           }
        
      // 글자수 제한
      $(".progress-title").on("input", function(){
    	  var content = $(this).val();
    	  var length = content.length;
    	  
 		  while(length > 30){
    	  	$(this).val($(this).val().substring(0, length - 1));
    		length--;
    	  }
      });
      
      $(".progress-content").on("input", function(){
    	  var content = $(this).val();
    	  var length = content.length;
    	  
    	  while(length > 1300){
    		  $(this).val($(this).val().substring(0, length - 1));
    		  length--;
    	  }
      });
      
      
   		// 파일명 input에 출력하는 JS
		$("#file").on('change', function() {
			var fileFullName = $("#file").val();
			var fileName = fileFullName.substring(12, fileFullName.length);
			$(".upload-name").val(fileName);
		});
});
</script>
<jsp:include page="/template/header.jsp"></jsp:include>



<form action="progress_edit.do" method="post" enctype="multipart/form-data" class="form-all">
<input type="hidden" name="progressNo" value="<%=progressNo %>">
	<div class="container w700">
		<div class="row mt50 m10">
			<div class="flex-container">
				<div class="left-wrapper mlr10">
					<h3>프로젝트 공지 작성</h3>
				</div>
			</div>
		</div>
		<hr>
		<div class="row">
			<table class="table table-a">
				<tbody>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="form-input fill progress-title" name="progressTitle" value="<%=pjProgressDto.getProgressTitle() %>" autocomplete="off">
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">공지내용</th>
						<td>
							<textarea rows="5" class="form-input fill progress-content" name="progressContent"><%=pjProgressDto.getProgressContent() %></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<div class="filebox-a">
								<input class="upload-name" placeholder="첨부파일"> 
									<label for="file">파일선택</label> 
								<input type="file" id="file" name="attach">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row m50">
			<div class="flex-container">
				<div class="left-wrapper right mlr10">
					<input type="submit" value="작성하기" class="link link-btn w150 progress-submit">
				</div>
				<div class="right-wrapper">
					<a href="list.jsp"> <input type="button" value="취소" class="link link-reverse w150">
					</a>
				</div>
			</div>
		</div>
	</div>
</form>


<jsp:include page="/template/footer.jsp"></jsp:include>