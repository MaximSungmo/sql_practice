-- serial vs sequence

create table t1 (
	t1 serial
);

insert into t1 values(default);
select * from t1;
-------------------------------------
create sequence t2_seq;
create table t2(
	c2 int not null default nextval('t2_seq')
);
-- t2_seq를 만든 다음에 t2테이블의 c2애트리뷰트가 가지고 있다라고 지정해주기, 다른 곳에서 t2_seq 쓰지 못함.
alter sequence t2_seq owned by t2.c2;

insert into t2 values(default);
select * from t2;
------------------------------------
--char test
create table t3(
	c3 char(4)
);
insert into t3 values('ok');
select c3, char_length(c3) from t3;
-- 길이가 넘어간 데이터는 들어가지 않는다. 하지만 스페이스는 데이터를 넘어가는 공간에 있더라도 무시한다.
insert into t3 values('okay  ');
insert into t3 values('okaybary');
------------------------------------
--varchar test
create table t4(
	c4 varchar(5)
);
insert into t4 values('ok');
select c4, char_length(c4) from t4;
-- 길이가 넘어간 데이터는 들어가지 않는다. 하지만 스페이스는 데이터를 넘어가는 공간에 있더라도 무시한다.
insert into t4 values('good          ');
insert into t4 values('good day');
-- insert 시 캐스팅해주면 오류없이 짤라서 들어간다. 
insert into t4 values('good day'::varchar(5));
------------------------------------
-- enum --
create type mood as enum('sad','ok','happy');

create table person(
	name varchar(10),
	current_mood mood
);

insert into person values('you', 'happy');
-- enum type 값의 후보가 아니라면 오류를 발생한다. 
insert into person values('you', 'bir');

select * from person;

-- enum type의 크기 비교 
select * from person where current_mood > 'ok';
------------------------------------
--JSON으로 저장 테스트 
select '{"result": "success", "data":1}'::json;

create table t5 ( 
	response json
);

insert into t5 values('{"result": "success", "data":1}');
insert into t5 values('{"result": "success", "data":2}');

select * from t5;

-- DDL 데이터 정의

--테이블 생성 및 기초 조건 지정
create table member1(
	no int,
	email varchar(50) not null default '',
	passwd varchar(20) not null,
	name varchar(25),
	department_name varchar(25),
	primary key(no)
);

-- 테이블에 새 칼럼 추가
alter table member1 add juminbunho char(13) not null;
alter table member1 add join_date timestamp not null;

-- 테이블에 컬럼 삭제
alter table member1 drop juminbunho;

-- 컬럼 타입 변경 
-- 데이터가 만약에 있다면 오류생길 수 있으므로 using 을 작성하여 모든 기존 저장된 데이터도 함께 변경될 수 있도록 한다. 
alter table member1 alter column no type bigint using no::bigint;

-- not null 셋팅
alter table member1 alter column no set not null;
alter table member1 alter column department_name set not null;
alter table member1 alter column name set not null;

-- not null 제거 
alter table member1 alter column name drop not null;


-- default 셋팅 
create sequence member1_seq;
alter table member1 alter column no set default nextval('member1_seq');

-- 컬럼 이름 변경 
alter table member1 rename column department_name to dept_name;

-- 테이블 이름 변경 
alter table member1 rename to member2;

select * from member1;





