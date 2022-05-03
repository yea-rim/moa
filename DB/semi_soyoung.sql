--관리자
create table admin(
admin_id varchar2(17) primary key,
admin_pw varchar2(16) not null
);

--moa공지사항
create table moa_notice(
notice_no number primary key,
notice_writer references admin(admin_id) on delete set null,
notice_title varchar2(100) not null,
notice_content varchar2(4000) not null,
notice_time date default sysdate not null,
notice_readcount number default 0 not null
);
create sequence moa_notice_seq;

--첨부파일
create table attach(
attach_no number primary key,
attach_uploadname varchar2(256) not null,
attach_savename varchar2(256) not null,
attach_type varchar2(256) not null,
attach_size number default 0 not null
);
drop table attach;
create sequence attach_seq;

--공지사항 첨부파일
create table moa_notice_attach (
notice_no references moa_notice(notice_no) on delete cascade not null,
attach_no references attach(attach_no) on delete cascade not null,
primary key(notice_no,attach_no)
);

--moa 1:1문의
create table moa_question(
question_no number primary key,
question_writer references member(member_no) on delete set null,
question_title varchar2(100) not null,
question_content varchar2(4000) not null,
question_time date default sysdate not null
);
create sequence moa_question_seq;

--1:1문의 첨부파일
create table moa_question_attach (
question_no references moa_question(question_no) on delete cascade not null,
attach_no references attach(attach_no) on delete cascade not null,
primary key(question_no,attach_no)
);

--1:1문의 댓글
create table moa_question_reply(
reply_no number primary key,
target_no references moa_question(question_no) on delete cascade not null,
reply_writer_admin references admin(admin_id) on delete set null,
reply_write_member references member(member_no) on delete set null,
reply_time date default sysdate not null,
reply_content varchar2(600) not null
);
create sequence question_reply_seq;

