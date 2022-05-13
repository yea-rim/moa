<%@page import="moa.beans.MoaFaqDto"%>
<%@page import="moa.beans.MoaFaqDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String sort = request.getParameter("sort");
if (sort == null) {
	sort = "회원정보";
}

int p;
try {
	p = Integer.parseInt(request.getParameter("p"));
	if (p <= 0) {
		throw new Exception();
	}
} catch (Exception e) {
	p = 1;
}

int s;
try {
	s = Integer.parseInt(request.getParameter("s"));
	if (s <= 0) {
		throw new Exception();
	}
} catch (Exception e) {
	s = 10;
}

// 시작지점, 종료지점 계산
int end = p * s;
int begin = end - (s - 1);

MoaFaqDao moaFaqDao = new MoaFaqDao();
List<MoaFaqDto> list = moaFaqDao.allSelectList(p, s, sort);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>moa FAQ</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
// 	$(function() {
// 		$('#show_hide').click(function() {
// 			if ($('#content').css("display") == "none") {
// 				$('#content').show();
// 			} else if ($('#content').css("display") != "none") {
// 				$('#content').hide();
// 			}
// 		});

// 	});
</script>


<style>
.flex-container1 {
	display: flex;
	flex-direction: column;
	flex-wrap: wrap;
	justify-content: center;
}

.flex-container2 {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	height: 60px;
}

.flex-items1 {
	flex-basis: 10%;
}

.flex-items2 {
	flex-basis: 10%;
}

.flex-items3 {
	flex-basis: 70%;
}

.flex-items4 {
	flex-basis: 10%;
}

.bottom {
	align-self: flex-end;
}

.faq-name {
	text-overflow: ellipsis;
	overflow: hidden;
}

.search {
	justify-content: center;
}
</style>
<jsp:include page="/template/header.jsp"></jsp:include>


<hr style="border: solid 0.5px lightgray">

<div class="row center">
	<h1 class=" m70">moa FAQ</h1>
	</a>
</div>

<div class="container w950 m70">

	<!-- 안 돌아감!! -->
	<div class="row right">
		<form action="faq_list.jsp" method="get">
			<select name="sort" class="sort">
				<option>선택</option>
				<option>회원정보</option>
				<option>운영정책</option>
				<option>이용문의</option>
				<option>기타</option>
			</select>
		</form>
	</div>

	<hr style="border: solid 1px #B899CD">

	<%
	for (MoaFaqDto moaFaqDto : list) {
	%>
	<div class="row flex-container1 m10" onclick="location.href='<%=request.getContextPath()%>/faq/faq_detail.jsp?faqNo=<%=moaFaqDto.getFaqNo() %>';">
		<div class="row flex-container2">
			<div class="flex-items1 bottom">
				<span><%=moaFaqDto.getFaqNo()%> </span>
			</div>

			<div class="flex-items3 bottom">
				<span>
					<h3><%=moaFaqDto.getFaqTitle()%></h3>				
				</span>
			</div>

			<div class="flex-items4 row right bottom">
				<span><%=moaFaqDto.getFaqCategory()%></span>
			</div>

		</div>
	</div>

	<hr style="border: solid 0.5px lightgray">
	<%
	}
	%>

</div>
<!--  순자(ㅋㅋ) 페이지네이션 -->
<%
int count = moaFaqDao.countByPaging();

//마지막 페이지 번호 계산
int lastPage = (count + s - 1) / s;

//블록 크기
int blockSize = 10;

//시작블록 혹은 종료 블록 중 하나만 계산하면 반대편은 계산이 가능하다.
//종료블록에 영향을 미치는 데이터는 현재 페이지(p) 이다.
//하단 블록에는 반드시 현재페이지 번호가 포함되어야 하므로 이 번호를 기준으로 시작과 종료를 계산한다!
int endBlock = (p + blockSize - 1) / blockSize * blockSize;
int startBlock = endBlock - (blockSize - 1);

//범위를 초과하는 문제를 해결(endBlock > lastPage)
if (endBlock > lastPage) {
	endBlock = lastPage;
}
%>

<h3>
	<!-- 이전 버튼 영역 -->
	<div class="pagination center m50">
		<%
		if (p > 1) {
		%>
		<a href="faq_list.jsp?p=1&s=<%=s%>&type=<%=sort%>">&laquo;</a>
		<%
		}
		%>

		<%
		if (startBlock > 1) {
		%>
		<a href="faq_list.jsp?p=<%=startBlock - 1%>&s=<%=s%>">&lt;</a>
		<%
		}
		%>

		<!-- 숫자 링크 영역 -->
		<%
		for (int i = startBlock; i <= endBlock; i++) {
		%>
		<%
		if (i == p) {
		%>
		<a class="active" href="faq_list.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>
		<%
		} else {
		%>
		<a href="faq_list.jsp?p=<%=i%>&s=<%=s%>&sort=<%=sort%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<!-- 다음 버튼 영역 -->
		<%
		if (endBlock < lastPage) {
		%>
		<a href="faq_list.jsp?p=<%=endBlock + 1%>&s=<%=s%>&sort=<%=sort%>">&gt;</a>
		<%
		}
		%>

		<%
		if (p < lastPage) {
		%>
		<a href="faq_list.jsp?p=<%=lastPage%>&s=<%=s%>&sort=<%=sort%>">&raquo;</a>
		<%
		}
		%>
	</div>

</h3>

<hr style="border: solid 1px #B899CD">

<jsp:include page="/template/footer.jsp"></jsp:include>