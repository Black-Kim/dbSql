DESC emp;

INSERT INTO emp (empno, ename) VALUES (9999, 'brown');

SELECT *
FROM emp
WHERE empno = 9999;
--empno 컬럼의 설정이 NOT NULL이기 때문에 empno 컬럼에 NULL 값이 들어갈수 없어서 에러가 발생
INSERT INTO emp (ename) VALUES ('sally');

DESC dept;
--컬럼을 기술하지 않았기 때문에 테이블에 정의된 모든 컬럼에 대해 값을 기술해야하나 3개중 2개만 기술하여 에러가 발생
INSERT INTO dept VALUES (97,'DDIT');

-- 3번
INSERT INTO emp (empno, ename)
SELECT 9997 , 'cony' FROM dual
UNION ALL
SELECT 9996 , 'moon' FROM dual;


--날짜 컬럼 값 입력하기
INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, SYSDATE,3000, NULL,NULL);

INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, 
                        TO_DATE('2020/09/01''YYYY/MM/DD'),3000, NULL,NULL);
                        
--UPDATE
UPDATE dept SET dname = 'DDIT' , LOC = '영민'
WHERE deptno =99;

SELECT *
FROM dept;

UPDATE dept SET dname = 'DDIT', loc = '영민';


SELECT *
FROM emp
WHERE empno = 9000;

--ROLLBACK;

--테스트 데이터 입력
INSERT INTO emp (empno, ename, job) VALUES (9000, 'brown', NULL);
--9000번 사번의 deptno, job 컬럼의 값을 smith사원의 컬럼이랑 동일하게

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename ='SMITH') , 
                  job = (SELECT job FROM emp WHERE ename ='SMITH')
WHERE empno = 9000;

--emp 테이블에서 9000사번의  deptno 컬럼을 지우고 싶을 때 (NULL) ?? 
    -- >dempno 컬럼을 NULL로 업데이트 한다
DELETE [FROM] 테이블명 
[WHERE ....];
--emp 테이블에서 9000번 사번의 데이터를 완전히 삭제
DELETE emp ;

SELECT *
FROM emp;

ROLLBACK;
