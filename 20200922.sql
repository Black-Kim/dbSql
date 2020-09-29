CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.*, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;

--view 삭제
DROP VIEW 뷰이름;
DROP VIEW v_emp_dept;

CREATE VIEW v_emp_cnt AS
SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno;

SELECT *
FROM v_emp_cnt;

--SEQUENCE 문법
CREATE SEQUENCE 시퀀스 이름;
CREATE SEQUENCE SEQ_emp;
--사용방법 : 함수를 생각하자
-- .nextval : 시퀀스 객체에서 마지막으로 사용한 다음 값을 반환
-- .currval : nextval 함수를 실행하고 나서 사용할 수 있다. nextval 함수를 통해 얻어진 값을 반환
SELECT seq_emp.nextval
FROM dual;

SELECT seq_emp.currval
FROM dual;
--사용 예
INSERT INTO emp (empno, ename, hiredate)
            VALUES(seq_emp.nextval,'brown',SYSDATE);

--INDEX            
SELECT ROWID empno, ename
FROM emp;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID = 'AAAE5hAAFAAAACNAAH';
SELECT * FROM TABLE(dbms_xplan.display);

SELECT *
FROM user_constraints
WHERE table_name = 'EMP';

ALTER TABLE emp ADD CONSTRAINTS PK_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINTS PK_dept PRIMARY KEY(deptno);
ALTER TABLE emp ADD CONSTRAINTS FR_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT * FROM TABLE (dbms_xplan.display);

ALTER TABLE emp DROP CONSTRAINT PK_EMP;
ALTER TABLE emp DROP CONSTRAINT FK_EMP_EMP;

CREATE INDEX IDX_emp_N_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE INDEX IDX_emp_N_02 ON emp(job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job ='MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

--시나리오 5
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job ='MANAGER' AND ename LIKE 'C%';
--시나리오 6
CREATE INDEX idx_emp_n_03 ON emp(job,ename);
SELECT job , ename, ROWID
FROM emp
ORDER BY job, ename;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job ='MANAGER' AND ename LIKE 'C%';
SELECT *
FROM TABLE(dbms_xplan.display);

--시나리오 7
DROP INDEX idx_emp_n_03;
CREATE INDEX idx_emp_n_04 ON emp(ename,job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job ='MANAGER' AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--시나리오 8
DROP INDEX idx_emp_n_01;

ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);
COMMIT;

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno AND emp.empno = 7788;

SELECT *
FROM TABLE (dbms_xplan.display);