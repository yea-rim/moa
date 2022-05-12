<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));

	// 해당 프로젝트와 관련된 정보들 가져오기 
	

%>

<jsp:include page="/template/header.jsp"></jsp:include>


			<div class="flex-container mt40">
		             <!-- <a href="https://www.flaticon.com/kr/free-icons/" title="왼쪽 아이콘">왼쪽 아이콘  제작자: Catalin Fertu - Flaticon</a> -->
		             <a href="<%=request.getContextPath() %>/seller/my_ongoing_project.jsp">
		                    <img src="<%=request.getContextPath() %>/image/arrow.png" alt="왼쪽 화살표" width="25">
		             </a>
		             <a href="<%=request.getContextPath() %>/seller/my_ongoing_project.jsp" class="link mlr5">
		                     <h2>돌아가기</h2>
		              </a>
			</div>

			<div class="flex-container m50">
                    <div class="left-wrapper layer-5">
                        <img src="https://dummyimage.com/150x112" alt="" class="img img-round">
                    </div>
                    <div class="left-wrapper layer-3">
                        <div class="row">
                            <h2 class="m10 left">프로젝트 제목</h2>
                        </div>
                        <div class="row">
                            <h4 class="m10 left">카테고리</h4>
                        </div>
                    </div>
                    <div class="right-wrapper layer-4 left">
                        <div class="row mt10 m5">
                            <h3>모인 금액</h3>
                        </div>
                        <div class="row m5">
                            <p>000000원</p>
                        </div>
                        <div class="row mt10 m5">
                            <h3>남은 기간</h3>
                        </div>
                        <div class="row m5">
                            <p>10일</p>
                        </div>
                        <div class="row mt10 m5">
                            <h3>후원자 수</h3>
                        </div>
                        <div class="row m5">
                            <p>100명</p>
                        </div>
                    </div>
                </div>

                <hr>


                <div class="container mt30">

                    <table class="table table-border table-hover">
                        <thead>
                            <tr>
                                <th>펀딩 번호</th>
                                <th>후원자 닉네임</th>
                                <th>펀딩 날짜</th>
                                <th>기타</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>0</td>
                                <td>맘모스</td>
                                <td>0000-00-00</td>
                                <td>수정하기</td>
                            </tr>
                        </tbody>
                    </table>

                </div>
                
<jsp:include page = "/template/footer.jsp"></jsp:include>