<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="flex-container mt40">
		  <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
		 <a href="<%=request.getContextPath() %>/member/funding_wait_list.jsp">
		    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		 </a>
		<a href="<%=request.getContextPath() %>/member/funding_wait_list.jsp" class="link mlr5">
		    <h2>돌아가기</h2>
		</a>
	</div>


	<div class="container">
		<div class="row center">
			<h2>후원이 취소되었습니다.</h2>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>