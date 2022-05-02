create table project(
project_no number primary key,
project_seller_no references seller(seller_no) not null,
project_category varchar2(100) not null check(project_category in('패션/잡화','뷰티','푸드','홈/리빙','테크/가전','기타')),
project_name varchar2(100) not null check(regexp_like(project_name, '^(?!.*ㄱ-ㅎ)(?!.*ㅏ-ㅣ)[.]{2,10}$')),
project_summary varchar2(300) not null,
project_target_money number not null check(project_target_money > 0),
project_present_money number default 0 not null check(project_present_money >= 0),
project_sponsor_no number default 0 not null check(project_sponsor_no >= 0),
project_start_date date not null,
project_semi_finish date not null,
project_finish_date date not null,
project_permission char(1) default 0 not null,
check(project_start_date < project_semi_finish and project_semi_finish < project_finish_date)
);


create table reward(
reward_no number primary key,
reward_project_no REFERENCES project(project_no) not null,
reward_name varchar2(100) not null check(regexp_like(reward_name, '^(?!.*ㄱ-ㅎ)(?!.*ㅏ-ㅣ)[.]{2,10}$')),
reward_content varchar2(300) not null,
reward_price number not null check(reward_price > 0),
reward_stock number not null check(reward_stock > 0)
);

create table reward_selection(
selection_funding_no REFERENCES funding(funding_no) not null,
selection_reward_no REFERENCES reward(reward_no) not null,
selection_project_no REFERENCES reward(reward_project_no) not null,
selection_reward_amount number not null check(selection_reward_amount > 0),
selection_price number not null check(selection_price > 0),
primary key (selection_funding_no, selection_reward_no)
);

create table project_attach(
project_attach_no REFERENCES attach(attach_no) not null,
project_no REFERENCES project(project_no),
primary key(project_attach_no, project_no)
);

create SEQUENCE reward_seq;
create SEQUENCE project_seq;


