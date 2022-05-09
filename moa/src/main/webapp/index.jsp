<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

				<div class="row fill">
                    <img src="https://dummyimage.com/1305x250" alt="" class="fill">
                </div>
                <div class="row left big-text m30">
                    <a href="<%=request.getContextPath()%>/project/ongoingList.jsp?sort=인기순" class="link">인기 프로젝트</a>
                </div>
                <div class="row left big-text m30">
                    <a href="<%=request.getContextPath()%>/project/ongoingList.jsp" class="link">신규 프로젝트</a>
                </div>

<jsp:include page="/template/footer.jsp"></jsp:include>