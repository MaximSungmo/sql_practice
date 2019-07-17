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
-- t2_seq�� ���� ������ t2���̺��� c2��Ʈ����Ʈ�� ������ �ִٶ�� �������ֱ�, �ٸ� ������ t2_seq ���� ����.
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
-- ���̰� �Ѿ �����ʹ� ���� �ʴ´�. ������ �����̽��� �����͸� �Ѿ�� ������ �ִ��� �����Ѵ�.
insert into t3 values('okay  ');
insert into t3 values('okaybary');
------------------------------------
--varchar test
create table t4(
	c4 varchar(5)
);
insert into t4 values('ok');
select c4, char_length(c4) from t4;
-- ���̰� �Ѿ �����ʹ� ���� �ʴ´�. ������ �����̽��� �����͸� �Ѿ�� ������ �ִ��� �����Ѵ�.
insert into t4 values('good          ');
insert into t4 values('good day');
-- insert �� ĳ�������ָ� �������� ©�� ����. 
insert into t4 values('good day'::varchar(5));
------------------------------------
-- enum --
create type mood as enum('sad','ok','happy');

create table person(
	name varchar(10),
	current_mood mood
);

insert into person values('you', 'happy');
-- enum type ���� �ĺ��� �ƴ϶�� ������ �߻��Ѵ�. 
insert into person values('you', 'bir');

select * from person;

-- enum type�� ũ�� �� 
select * from person where current_mood > 'ok';
------------------------------------
--JSON���� ���� �׽�Ʈ 
select '{"result": "success", "data":1}'::json;

create table t5 ( 
	response json
);

insert into t5 values('{"result": "success", "data":1}');
insert into t5 values('{"result": "success", "data":2}');

select * from t5;

-- DDL ������ ����

--���̺� ���� �� ���� ���� ����
create table member1(
	no int,
	email varchar(50) not null default '',
	passwd varchar(20) not null,
	name varchar(25),
	department_name varchar(25),
	primary key(no)
);

-- ���̺� �� Į�� �߰�
alter table member1 add juminbunho char(13) not null;
alter table member1 add join_date timestamp not null;

-- ���̺� �÷� ����
alter table member1 drop juminbunho;

-- �÷� Ÿ�� ���� 
-- �����Ͱ� ���࿡ �ִٸ� �������� �� �����Ƿ� using �� �ۼ��Ͽ� ��� ���� ����� �����͵� �Բ� ����� �� �ֵ��� �Ѵ�. 
alter table member1 alter column no type bigint using no::bigint;

-- not null ����
alter table member1 alter column no set not null;
alter table member1 alter column department_name set not null;
alter table member1 alter column name set not null;

-- not null ���� 
alter table member1 alter column name drop not null;


-- default ���� 
create sequence member1_seq;
alter table member1 alter column no set default nextval('member1_seq');

-- �÷� �̸� ���� 
alter table member1 rename column department_name to dept_name;

-- ���̺� �̸� ���� 
alter table member1 rename to member2;

select * from member1;





