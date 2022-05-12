<%@page import="moa.beans.MemberDto"%>
<%@page import="moa.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int memberNo = (int)session.getAttribute("login");

	MemberDao memberDao = new MemberDao();
	MemberDto memberDto =  memberDao.selectOne(memberNo);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
 <style>
     .filebox-a input[type="file"] {
         position: absolute;
         width: 0;
         height: 0;
         padding: 0;
         overflow: hidden;
         border: 0;
     }

     /* 인풋 스타일 변경 */
     .filebox-a .upload-name {
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


     .table.table-a>tbody>tr>th,
     .table.table-a>tbody>tr>td {
         text-align: left;
         border-bottom: 0.5px solid #f1f2f6;
         padding: 1em;
     }
 </style>
<script type="text/javascript">
        $(function(){
	        // 파일명 input에 출력하는 JS
	        $("#file").on('change',function(){
	            var fileFullName = $("#file").val();	      
	            var fileName = fileFullName.substring(12,fileFullName.length);
	            $(".upload-name").val(fileName);
	        });
        });
</script>
<form action="insert.do" method="post" enctype="multipart/form-data">
    <div class="container w700">
        <div class="row mt50 m10">
           <div class="flex-container">
               <div class="left-wrapper mlr10">
                   <h3>1:1 문의</h3>
               </div>
               <div class="right-wrapper right mlr5" >
                   <div class="row f12 gray">※ 문의하신 사항은 성실하게 답변 드리겠습니다. </div>
                   <div class="row f12 gray">문의하시기 전에 FAQ를 참고 해주세요.</div>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <table class="table table-a">
                <tbody>
                    <tr>
                        <th style="width:110px;">작성자</th>
                        <td>
                           <h4><%=memberDto.getMemberNick()%></h4>
                        </td>
                    </tr>
                    <tr>
                        <th>문의유형</th>
                        <td>
                            <select name="questionType" class="form-input fill">
                                <option value="">선택</option>
                                <option>취소문의</option>
                                <option>배송문의</option>
                                <option>반품문의</option>
                                <option>교환/환불문의</option>
                                <option>작동오류문의</option>
                                <option>기타문의</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>
                           <input type="text" class="form-input fill" name="questionTitle" placeholder="제목을 입력해주세요">
                        </td>
                    </tr>
                    <tr>
                        <th style="vertical-align:middle">문의내용</th>
                        <td>
                           <textarea rows="5" class="form-input fill" name="questionContent" placeholder="내용을 입력해주세요"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>파일첨부</th>
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
                    <input type="submit" value="작성하기" class="link link-btn w150">
                </div>
                <div class="right-wrapper">
                    <a href="<%=request.getContextPath()%>">
                    	<input type="button" value="취소" class="link link-reverse w150">
                    </a>
                 </div>
             </div>            
        </div> 
    </div>
</form>
<jsp:include page="/template/footer.jsp"></jsp:include>