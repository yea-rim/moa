-- 커뮤니티(홍보게시판)
create table community(
community_no number primary key,
project_no references project(project_no) on delete cascade not null,
member_no references member(member_no) on delete cascade not null,
community_title varchar2(100) not null,
community_content varchar2(4000) not null,
community_time date default sysdate not null,
community_readcount number default 0 not null,
community_replycount number default 0 not null
);
create sequence community_seq;

-- 커뮤니티댓글
create table community_reply(
reply_no number primary key,
community_no references community(community_no) on delete cascade,
member_no references member(member_no) on delete set null,
reply_time date default sysdate not null,
reply_content varchar2(600) not null
);
create sequence community_reply_seq;

-- 커뮤니티 사진
create table community_photo(
community_no references community(community_no) on delete cascade not null,
attach_no references attach(attach_no) on delete cascade not null,
primary key(community_no, attach_no)
);

-- moaFAQ
create table moa_faq(
faq_no number primary key,
faq_title varchar2(300) not null,
faq_category varchar2(14) check(faq_category in ('회원정보', '운영정책', '이용문의', '기타')),
faq_content varchar2(4000) not null
);
