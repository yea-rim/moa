<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="flex-container mt40">
             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
             <a href="<%=request.getContextPath() %>/seller/my_page.jsp">
                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
             </a>
             <a href="my_rejected_project.jsp" class="link mlr5">
                     <h2>돌아가기</h2>
              </a>
	</div>

	<%if(request.getParameter("error") == null) { %>
		
		<div class="container m50">
			<div class="row center">
				<h1>프로젝트 재신청이 완료되었습니다.</h1>
			</div>
		</div>
		
	<%} else { %>
		
		<div class="container m50">
			<div class="row center">
				<h1>프로젝트 재신청에 실패했습니다.</h1>
			</div>
		</div>
		
	<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>