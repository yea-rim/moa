<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

    <form action="join.do" method="post">
        <div class="container w450 m30">
            <div class="row center">
                <h1>회원가입</h1>
            </div>
            <div class="row">
                <label>이메일</label>
                <input type="email" name="memberEmail" required class="form-input fill input-round" autocomplete="off">
            </div>
            <div class="row">
                <label>비밀번호</label>
                <input type="password" name="memberPw" required placeholder="영어, 숫자, 특수문자 8~16자" class="form-input fill input-round">
            </div>
            <div class="row">
                <label>
                    닉네임
                    <input type="text" name="memberNick" required placeholder="한글, 숫자 10자 이내" autocomplete="off" class="form-input fill input-round">
                </label>
            </div>
            <div class="row">
                <label>전화번호</label>
                <input type="tel" name="memberPhone" required placeholder="- 제외하고 입력" class="form-input fill input-round" autocomplete="off">
            </div>

            <div class="row">
                <label>가입 경로</label>
                <select name="memberRoute" class="form-input input-round">
                    <option value="친구 추천">친구 추천</option>
                    <option value="인터넷 검색">인터넷 검색</option>
                    <option value="광고">광고</option>
                    <option value="sns">sns</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="row">
                <button type="submit" class="btn btn-primary fill">회원가입</button>
            </div>
        </div>
    </form>
<jsp:include page="/template/footer.jsp"></jsp:include>