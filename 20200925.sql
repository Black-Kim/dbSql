--cube
SELECT job, deptno
FROM emp
GROUP BY CUBE(job, deptno);

SELECT job, deptno
FROM emp
GROUP BY ROLLUP(job, deptno);

SELECT job, deptno , SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY CUBE (job,deptno);

--REPORT GROUP FUNCTION
SELECT job, deptno, mgr, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY job, ROLLUP (deptno), CUBE (mgr);

--상호연관 서브 쿼리를 이용한 업데이트
1. emp_test 테이블 삭제
DROP TABLE EMP_TEST;
2. emp테이블을 사용하여 emp_test 테이블 생성(모든 컬럼, 모든 데이터)
CREATE TABLE emp_test AS
SELECT *
FROM emp;
3. emp_test 테이블에는 dname컬럼을 추가 (VARCHAR2(14))
ALTER TABLE emp_test ADD (dname VARCHAR(14));
4. 상호연관 서브쿼리를 이용하여 emp_test 테이블의 dname 컬럼을 dept를 이용하여 update
SELECT *
FROM emp_test
ORDER BY deptno;
UPDATE emp_test SET dname = (SELECT dname FROM dept WHERE deptno = emp_test.deptno);

DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

DESC dept_test;

ALTER TABLE dept_test ADD (empcnt NUMBER (7));

EXPLAIN PLAN FOR
UPDATE dept_test SET empcnt = (SELECT COUNT(deptno) FROM emp  WHERE deptno = dept_test.deptno GROUP BY deptno); 

EXPLAIN PLAN FOR
UPDATE dept_test SET empcnt = (SELECT COUNT(deptno) FROM emp  WHERE deptno = dept_test.deptno); 

SELECT *
FROM TABLE (dbms_xplan.display);
 
SELECT *
FROM dept_test;

COMMIT;

INSERT INTO dept_test (deptno, dname, loc) VALUES (99, 'it1', 'daejeon');
INSERT INTO dept_test(deptno, dname, loc) VALUES (98, 'it2', 'daejeon');

DELETE dept_test WHERE deptno NOT IN (SELECT deptno FROM emp);
DELETE dept_test WHERE NOT EXISTS (SELECT 'X' FROM emp WHERE deptno = dept_test.deptno);
DELETE dept_test WHERE 0 = (SELECT COUNT(*) FROM emp  WHERE deptno dept_test.deptno);

--계층쿼리
SELECT deptcd,LPAD(' ',(LEVEL-1) *3) || deptnm deptnm
FROM dept_h
START WITH DEPTCD = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD
ORDER BY LEVEL, deptcd;

--과제
UPDATE emp_test
SET sal_test  =  sal_test +200
WHERE emp_test.sal < (SELECT  AVG(s.sal) sal FROM emp_test s WHERE s.deptno = emp_test.deptno);

SELECT AVG(sal)
FROM emp
GROUP BY deptno;

