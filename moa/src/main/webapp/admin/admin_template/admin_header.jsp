<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.menu-li{
	padding: 0px 0px 35px 20px;
	list-style-type: square;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/add_reward.js"></script>
    <div class="row m20">
        <!-- 세로 배치를 위한 flex container -->
        <div class="flex-container flex-vertical">
            <div class="flex-container list-admin">
                <div class="menu-wrapper">
                    <ul class="m30 mlr30 left">
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/projectList.jsp" class="link">
                           		프로젝트 관리
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="content-wrapper mlr30 m50">
