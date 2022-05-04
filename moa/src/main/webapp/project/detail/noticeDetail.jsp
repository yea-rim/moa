<%@page import="moa.beans.PjProgressDto"%>
<%@page import="java.util.List"%>
<%@page import="moa.beans.PjProgressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	int progressNo = Integer.parseInt(request.getParameter("progressNo"));
	PjProgressDao pjProgressDao = new PjProgressDao();
	
	/* 파라미터 나중에 바꿔주기!!!!!!!!!!!!!!!!!!!!!!!! */
	
	PjProgressDto pjProgressDto = pjProgressDao.selectOne(progressNo);
	
	
%>
    
<jsp:include page="/project/project_template/project_header.jsp"></jsp:include>

<div class="detail-body">
                    <div class="row left m-b10">
                        <div class="row">
                            작성자
                        </div>
                        <div class="row m10 font12"">
                            <%=pjProgressDto.getProgressTime() %> 공지사항
                        </div>
                    </div>
                    <div class="row left m10">
                        <h1>
                        	<%=pjProgressDto.getProgressTitle() %>
                        </h1>
                    </div>
                    <div class="row">
<pre>
<%=pjProgressDto.getProgressContent() %>
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
fdsafjkdasfhjskadfhlasjkdfhdasjlkfsajlkfhsdfhdsalf
asdfhdsjlfkhsadjlkfhsdajlfkhsdajlkfhdsjlkfhdsajlkfhasf
fhasdfjlkashdfjlkashfjlkshdfjlkdasfjlksahkflas
</pre>
                    </div>
                </div>
<jsp:include page="/project/project_template/project_footer.jsp"></jsp:include>