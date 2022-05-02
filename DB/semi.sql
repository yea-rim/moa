-- 프로젝트 진행상황 테이블 
CREATE TABLE pj_progress(
progress_no NUMBER PRIMARY KEY, 
project_no REFERENCES project(project_no) ON DELETE CASCADE NOT NULL,
progress_title varchar2(256),
progress_content varchar2(4000),
progress_time DATE DEFAULT sysdate NOT NULL
);

CREATE SEQUENCE pj_progress_seq;

-- 진행상황 첨부파일 
CREATE TABLE progress_attach(
attach_no REFERENCES attach(attach_no) ON DELETE CASCADE NOT NULL,
progress_no REFERENCES pj_progress(progress_no) ON DELETE CASCADE NOT NULL,
PRIMARY KEY(attach_no, progress_no)
);


-- 프로젝트 문의 댓글 테이블
CREATE TABLE pj_qna(
qna_no NUMBER PRIMARY KEY,
qna_member_no REFERENCES member(member_no) ON DELETE CASCADE SET NULL,
qna_project_no REFERENCES project(project_no) ON DELETE CASCADE NOT NULL,
qna_content varchar2(900) NOT NULL,
qna_time DATE default sysdate NOT NULL, 
group_no NUMBER NOT NULL,
super_no NUMBER default 0 NOT NULL, 
DEPTH NUMBER default 0 NOT NULL,
qna_lock char(1) DEFAULT 0 NOT NULL CHECK(qna_lock IN(0,1))
);

CREATE SEQUENCE pj_inquiry_seq;


-- 펀딩 테이블 
CREATE TABLE funding(
funding_no NUMBER PRIMARY KEY,
funding_member_no REFERENCES member(member_no) ON DELETE CASCADE NOT NULL,
funding_date DATE default sysdate NOT NULL,
funding_post varchar2(6) NOT NULL,
funding_basic_address varchar2(300) NOT NULL,
funding_detail_address varchar2(300) NOT NULL CHECK(regexp_like(funding_detail_address,'^[가-힣A-Za-z·\d~\-\.]{2,}$')), 
funding_post_message varchar2(300),
funding_phone char(11) NOT NULL CHECK(regexp_like(funding_phone,'^(010)[1-9][0-9]{7}$')),
funding_delete_date DATE,
funding_payment_date DATE
);

CREATE SEQUENCE funding_seq;






