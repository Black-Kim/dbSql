==SELECT 쿼리 문법==
SELECT * | { column | expressoin [alias]}
from 테이블이름;

SQL 실행방법
1. 실행하려고 하는 SQL을 선택 후 ctrl + enter;
2. 실행하려는 SQL 구문에 커서를 위치시키고 ctrl + enter;

select *
from emp;

SELECT job
from emp;

select *
from dept

SQL의 경우 KEY워드의 대소문자를 구분하지 않는다


실습  select1

SELECT *
FROM  lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

연산
SELECT ename, sal, sal +100
FROM emp;

데이터타입
DESC 테이블명
DESC emp;

hiredate에서 365일 미래의 일자
SELECT ename AS emp_name, hiredate, 
       hiredate + 365 after_1year, hiredate - 365 before_1year
FROM emp;

emp 테이블에서 NULL값을 확인
SELECT *
FROM emp;

emp 테이블컬럼 정리
SELECT *
FROM dept;

SELECT ename, sal , comm, sal + comm AS total_sal
FROM emp;

SELECT userid, usernm, reg_dt, reg_dt + 5
FROM users;

실습2
SELECT prod_id AS "id", prod_name "name"
FROM prod;

SELECT lprod_gu AS "gu", lprod_nm "nm"
FROM lprod;

SELECT buyer_id AS "바이어아이디", buyer_name "이름"
FROM buyer;

문자표기
SELECT empno, 'Hello world'
FROM emp;

문자열 연산
emp 테이블의 ename, job 컬럼이 문자열
SELECT ename ||'       '|| job ,
 CONCAT(ename, CONCAT('         ',job))
FROM emp;

CONCAT(문자열1, 문자열2) : 문자열 1과 문자열 2를 합쳐서 결과값을 반환해준다.


SELECT 
    CONCAT('SELECT * FROM',CONCAT(' ', CONCAT(table_name,';'))) QUERY,
    'SELECT * FROM' || ' ' || table_name || ';' QUERY
FROM user_tables;