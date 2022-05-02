-- 회원 테이블 
create table member(
member_no number primary key,
member_email varchar2(100) unique not null check(regexp_like(member_email, '^[a-zA-Z0-9_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]$')), 
member_pw varchar2(16) not null check(regexp_like(member_pw, '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,16}$')), 
member_nick varchar2(30) unique not null check(regexp_like(member_nick, '^[가-힣a-zA-Z0-9]{2,10}$')), 
member_phone char(11) unique not null check(regexp_like(member_phone, '^010([1-9][0-9]{3})([0-9]{4})$')), /* '-' 제외 */
member_join_date date default sysdate not null,
member_post varchar2(6),
member_basic_address varchar2(300),
member_detail_address varchar2(300),
member_route varchar2(30) check(member_route in ('친구 추천', '인터넷 검색', '광고', 'sns', '기타'))
);

-- 회원 시퀀스 
create sequence member_seq;

drop table seller;
-- 판매자 테이블 
create table seller(
seller_no number references member(member_no) on delete cascade not null unique,
seller_nick varchar2(30) unique not null check(regexp_like(seller_nick, '^[가-힣a-zA-Z0-9()]{2,10}$')),
seller_regist_date date,
seller_account_bank varchar2(30) not null,
seller_account_no varchar2(20) unique not null, /* '-' 포함 */
seller_type varchar2(15) not null check(seller_type in ('개인 사업자', '법인 사업자', '개인 판매자'))
);


drop table member_profile;
-- 회원 프로필 테이블  
create table member_profile(
member_no references member(member_no) on delete cascade primary key,
attach_no references attach(attach_no) on delete cascade not null
);


-- 좋아요 테이블 
create table like(
project_no references project(project_no) on delete cascade not null, 
member_no references member(member_no) on delete cascade not null,
primary key (project_no, member_no)
);


