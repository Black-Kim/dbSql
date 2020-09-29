--실습 ana3
SELECT empno, ename, deptno,
       MAX(sal) OVER(PARTITION BY deptno) max_sal
FROM emp;

SELECT emp.empno, emp.ename, emp.sal,emp.deptno, a.max_sal
FROM emp,
(SELECT MAX(sal)max_sal,deptno
FROM emp
GROUP BY deptno)a
WHERE emp.deptno = a.deptno
ORDER BY deptno;

--실습 ana4
SELECT empno, ename, deptno,
       MIN(sal) OVER(PARTITION BY deptno) min_sal
FROM emp;

--사원번호, 사원이름, 입사일자, 급여, 급여순위가 자신보다 한단계 낮은 사람의 급여
--(단, 급여가 같을 경우 입사일이 빠른 사람이 높은 우선순위)

SELECT empno, ename, hiredate, sal , 
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate) LEAD_sal
FROM emp;

SELECT empno, ename, hiredate, sal , 
       LAG(sal) OVER (ORDER BY sal DESC, hiredate) LEAD_sal
FROM emp;

SELECT b.empno,b.ename,b.hiredate,b.sal, d.sal
FROM
(SELECT ROWNUM ro, a.*
FROM
(SELECT *
FROM emp  ORDER BY sal DESC)a)b,
(SELECT ROWNUM rn, c.sal
FROM
(SELECT DECODE(sal,800,NULL,sal) sal  FROM emp  ORDER BY sal DESC)c)d
WHERE b.ro = d.rn(+)
ORDER BY d.sal DESC;

(SELECT ROWNUM rn, c.sal
FROM
(SELECT sal  FROM emp WHERE sal > 900 ORDER BY sal DESC)c);



--실습 ana6
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--이전 / 이후 n행 가져오기
LAG(col[, 건너뛸 행수 - default 1][, 값이 없을 경우 적용할 기본값])
SELECT empno, ename, hiredate, job, sal,
       LAG(sal,2,0) OVER(ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT empno, ename, sal, 
       SUM(sal) OVER (ORDER BY sal, hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum,
       SUM(sal) OVER (ORDER BY sal, hiredate ROWS UNBOUNDED PRECEDING) c_sum2
FROM emp;

--선행하는 이전 첫번째 행부터 후행하는 이후 첫번째 행까지 선행 - 현재행 - 후행 총 3개의 행에 대해 급여 합을 구하기
SELECT empno, ename, sal,
       SUM(sal) OVER(ORDER BY sal, hiredate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

--실습 ana7
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

--

SELECT empno, ename, deptno, sal,
       SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
       SUM(sal) OVER(ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER(ORDER BY sal) c_sum
FROM emp;

--SQL
1.SELECT * /* SQL_TEST */ FROM emp;
2.Select * /* SQL_TEST */ FROM emp;
3.Select * /* SQL_TEST */   FROM emp;

10번 부서에 속하는 사원 정보 조회
=> 특정 부서에 속하는 사원 정보 조회
3.Select * /* SQL_TEST */   FROM emp WHERE deptno = 10;
바인드 변수를 왜 사용해야 하는가에 대한 설명
Select * /* SQL_TEST */   FROM emp WHERE deptno = :deptno;