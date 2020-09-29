conditional insert
all : 조건에 만족하는 모든 구만의 insert 실행
first : 조건에 만족하는 첫번 째 구문의 insert 만 실행;


INSERT FIRST
    WHEN eno >= 9500 THEN
        INTO emp_test VALUES (eno,enm)
    WHEN eno >= 9000 THEN
        INTO emp_test2 VALUES (eno,enm)
SELECT 9000 eno, 'brown' enm FROM dual UNION ALL
SELECT  9500, 'sally' FROM dual;

SELECT *
FROM emp_test;
SELECT *
FROM emp_test2;

--MERGE
EXPLAIN PLAN FOR
MERGE INTO emp_test
    USING (SELECT 9000 eno, 'moon' enm FROM dual) a
    ON (emp_test.empno = a.eno)
WHEN MATCHED THEN
    UPDATE SET ename = a.enm
WHEN NOT MATCHED THEN
    INSERT VALUES (a.eno, a.enm);
    
    

SELECT *
FROM table (dbms_xplan.display);

emp ==> emp_test 데이터 두건 복사

INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7499);

emp테이블을 이용하여 emp 테이블에 존재하고 emp_test에는 없는 사원에 대해서는 신규로 
emp_test 테이블에 신규로 입력
emp,emp_test 양쪽에 존재하는 사원은 이름 || '_M';

MERGE INTO emp_test
    USING emp
    ON(emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = emp_test.ename || '_M'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);
    
    
SELECT *
FROM emp_test, emp
WHERE emp.empno = emp_test.empno;

--report group function

SELECT  deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL, SUM(sal)
FROM emp;

SELECT deptno, sum(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT job, deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job,deptno);
--위에것을 풀면 밑에것이 된다.
SELECT job, deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY job, deptno UNION ALL
SELECT job, NULL, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY job UNION ALL
SELECT NULL, NULL, SUM(sal + NVL(comm,0)) sal
FROM emp;



--group_ad2
SELECT DECODE(GROUPING(job),1,'총계',job) job,deptno, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(job, deptno);


SELECT DECODE(GROUPING(job),1,'총',job) job,
       NVL(DECODE(GROUPING(deptno),1,DECODE(GROUPING(job),1,'계'),deptno),'소계') sal,
       SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(job, deptno);


--group ad2
SELECT CASE
WHEN GROUPING(job) = 1 THEN '총' 
ELSE job 
END job,
CASE 
WHEN GROUPING(job)=1 THEN '계'
WHEN GROUPING(deptno) = 1 THEN '소계'
ELSE TO_CHAR(deptno)
END deptno,
SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--group ad3
SELECT deptno, job,SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP(deptno,job);

--group ad4
SELECT dname, job,SUM(sal+NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job)
ORDER BY dname, sal DESC;

--group ad5
SELECT NVL(dname,'총합') dname, job, SUM(sal+NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job)
ORDER BY dname, sal DESC;

SELECT DECODE(GROUPING(dname),1,'총합',dname) dname, job, SUM(sal+NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname,job)
ORDER BY dname, sal DESC;

--GROUPING SETS
SELECT job, deptno, SUM(sal +NVL(comm,0)) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno,'');