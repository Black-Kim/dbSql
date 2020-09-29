CREATE TABLE emp_TEST2 AS
SELECT *
FROM emp
WHERE 1 =1;

--index 실습 1
CREATE UNIQUE INDEX idx_dept_test2_u_01 ON DEPT_TEST2(deptno);
CREATE INDEX idx_dept_test2_n_01 ON DEPT_TEST2(dname);
CREATE INDEX idx_dept_test2_n_02 ON DEPT_TEST2(deptno,dname);
--index 실습 2
DROP INDEX idx_dept_test2_u_01;
DROP INDEX idx_dept_test2_n_01;
DROP INDEX idx_dept_test2_n_02;
--index 실습 3
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2 e, dept
WHERE e.deptno = dept.deptno
AND e.deptno = :deptno
AND e.empno LIKE :empno||'%';

CREATE UNIQUE INDEX idx_emp_u_01 ON emp(empno);
CREATE INDEX idx_emp_n_01 ON emp(ename);
CREATE UNIQUE INDEX idx_dept_u;

EXPLAIN PLAN FOR
SELECT b.*
FROM emp_test2 a, emp_test2 b
WHERE a.mgr = b.empno
AND a.deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = : empno;

CREATE UNIQUE INDEX idx_emp_test2_u_01 ON emp_test2(empno,deptno);
DROP INDEX idx_emp_test2_u_01;

EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE sal BETWEEN :st_sal AND :ed_sal
AND deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE INDEX idx_emp_test2_u_02 ON emp_test2(deptno, sal);
CREATE INDEX idx_emp_test2_u_03 ON emp_test2(deptno);

DROP INDEX idx_emp_test2_u_03;

--SYNONYM 
emp 테이블에 e라는 이름으로 synonym 을 생성
CREATE SYNONYM e FOR emp;

SELECT *
FROM e;

--multiple insert 
1.unconditional insert : 조건과 관계없이 여러 테이블에 insert

DROP TABLE emp_test;
DROP TABLE emp_test2;

CREATE TABLE emp_test AS 
SELECT empno, ename
FROM emp
WHERE 1 = 2;

CREATE TABLE emp_test2 AS 
SELECT empno, ename
FROM emp
WHERE 1 = 2;

INSERT ALL INTO emp_test  INTO emp_test2
SELECT 9999 , 'brown'FROM dual 
UNION ALL
SELECT 9998 , 'sally'FROM dual;

SELECT *
FROM emp_test;
SELECT *
FROM emp_test2;

INSERT ALL
INTO emp_test (empno) VALUES(eno)
INTO emp_test2(empno, ename) VALUES(eno,enm)
SELECT 9999 eno , 'brown' enm FROM dual 
UNION ALL
SELECT 9998 , 'sally'FROM dual;

--conditional insert : 조건에 따라 데이터를 입력
ROLLBACK;
INSERT ALL 
    WHEN eno >= 9500 THEN 
        INTO emp_test VALUES (eno, enm)
        INTO emp_test2 VALUES (eno, enm)
    WHEN eno >= 9900 THEN 
        INTO emp_test2 VALUES (eno,enm)
SELECT 9500 eno , 'brown' enm FROM dual 
UNION ALL
SELECT 9998 , 'sally'FROM dual;