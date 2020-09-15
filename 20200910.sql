--그룹함수 문법
SELECT 행을 묶을 컬럼, 그룹함수
FROM 테이블명
[WHERE]
GROUP BY 행을 묶을 컬럼
[HAVING 그룹함수 체크조건];

SELECT *
FROM emp
ORDER BY deptno;

SELECT deptno,  COUNT(*), MIN(sal), MAX(sal), AVG(sal), SUM(sal)
FROM emp
GROUP BY deptno;

SELECT MAX(sal)
FROM emp
GROUP BY sal;
--COUNT 함수 *인자
SELECT COUNT(*), COUNT(mgr), COUNT(comm)
FROM emp;
--그룹함수 특징1
SELECT SUM(sal + comm),SUM(sal)+SUM(comm)
FROM emp;
--그룹함수 특징2
SELECT deptno,'TEST', SYSDATE,1, COUNT(*)
FROM emp
GROUP BY deptno;
--그룹함수 특징3
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) >=5;

--grp1
SELECT MAX(sal)MAX_SAL,MIN(sal)MIN_SAL, ROUND(AVG(sal),2)AVG_SAL, SUM(sal)SUM_SAL, COUNT(sal)COUNT_SAL, COUNT(MGR)COUNT_MGR,COUNT(*)COUNT_ALL
FROM emp;
--grp2
SELECT deptno, MAX(sal)MAX_SAL,MIN(sal)MIN_SAL, ROUND(AVG(sal),2)AVG_SAL, SUM(sal)SUM_SAL, COUNT(sal)COUNT_SAL, COUNT(MGR)COUNT_MGR,COUNT(*)COUNT_ALL
FROM emp
GROUP BY deptno;
--grp3
SELECT CASE 
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 10 THEN 'ACCOUNTING'
        END DNAME ,
         MAX(sal)MAX_SAL,MIN(sal)MIN_SAL, ROUND(AVG(sal),2)AVG_SAL, SUM(sal)SUM_SAL, COUNT(sal)COUNT_SAL, COUNT(MGR)COUNT_MGR,COUNT(*)COUNT_ALL   
FROM emp
GROUP BY deptno
ORDER BY MAX_SAL DESC;

SELECT DECODE (deptno, 10 , 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES') dname,        
         MAX(sal)MAX_SAL,MIN(sal)MIN_SAL, ROUND(AVG(sal),2)AVG_SAL, SUM(sal)SUM_SAL, COUNT(sal)COUNT_SAL, COUNT(MGR)COUNT_MGR,COUNT(*)COUNT_ALL
FROM emp
GROUP BY DECODE (deptno, 10 , 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES');

--grp4
SELECT HIRE_YYYYMM, COUNT(HIRE_YYYYMM) CNT
FROM (SELECT TO_CHAR(hiredate,'yyyymm')HIRE_YYYYMM
FROM emp) 
GROUP BY HIRE_YYYYMM;

SELECT TO_CHAR(hiredate,'yyyymm') HIRE_YYYYMM, COUNT(hiredate) CNT
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

--join natural
SELECT  ename
FROM emp NATURAL JOIN dept;
--join Oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI-SQL : JOIN WITH USING
SELECT *
FROM emp JOIN dept USING(deptno);

--Oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI-SQL : JOIN WITH ON
SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.deptno IN(20,30);

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN(10,30);

--self join
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e JOIN emp m ON(m.mgr = e.empno);
--Oracle
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno;

--NONEQUI JOIN
SELECT *
FROM emp, dept
WHERE emp.empno =7369
    AND emp.deptno != dept.deptno;
    
--샐러리를 이용해서 등급을 구하기 
SELECT *
FROM salgrade;

SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;

SELECT empno, ename, sal, grade
FROM emp JOIN salgrade ON(emp.sal >= losal AND emp.sal<= hisal);

SELECT LPROD_GU,lprod_nm, prod_id, prod_name 
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);
--FROM prod, lprod
--WHERE lprod.lprod_gu = prod.prod_lgu;
 

SELECT *
FROM lprod;