<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
    <div class="row m20">
        <!-- 세로 배치를 위한 flex container -->
        <div class="flex-container flex-vertical">
            <div class="flex-container list-admin">
                <div class="menu-wrapper">
                    <ul>
                        <li>
                            <a href="<%=request.getContextPath()%>/admin/projectlist.jsp">프로젝트 관리</a>
                        </li>
                    </ul>
                </div>
                <div class="content-wrapper mlr30">
