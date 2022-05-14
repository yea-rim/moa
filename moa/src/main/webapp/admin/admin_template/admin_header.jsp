<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.menu-li{
	padding: 0px 0px 25px 10px;
	list-style-type: square;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/add_reward.js"></script>
    <div class="row m20">
        <!-- 세로 배치를 위한 flex container -->
        <div class="flex-container flex-vertical">
            <div class="flex-container list-admin">
                <div class="menu-wrapper" style="border-right: 1px solid gray;">
                <div class="row m20 center" style="font-weight: bold; font-size: 17px;">관리자 메뉴</div><hr>
                    <ul class="m30 mlr30 left">
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/projectList.jsp" class="link">
                           		프로젝트 관리
                            </a>
                        </li>
                        
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/member_list.jsp" class="link">
                           		회원 목록
                            </a>
                        </li>
                            
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/seller_list.jsp" class="link">
                           		판매자 목록
                            </a>
                        </li>
                        
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/seller_join_list.jsp" class="link">
                           		판매자 신청 목록
                            </a>
                        </li>      
                         <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/notice_list.jsp" class="link">
                           		공지사항 관리
                            </a>
                        </li>
                        <li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/question_list.jsp" class="link">
                           		1:1 문의 관리
                            </a>
                        </li>
					<li class="menu-li">
                            <a href="<%=request.getContextPath()%>/admin/faq_insert.jsp" class="link">
                           		FAQ 작성
                            </a>
                        </li>   
                                         
                    </ul>
                </div>
                <div class="content-wrapper mlr30 m50">
