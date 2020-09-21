--전체직원의 급여 평균보다 높은 급여를 받는 사원들 조회
SELECT *
FROM emp
WHERE sal >(SELECT AVG(sal)FROM emp);
--본인 속한 부서의 급여 평균보다 높은 급여를 받는 사원들 조회
SELECT *
FROM emp e
WHERE sal >(SELECT AVG(sal) FROM emp WHERE deptno = e.deptno);

--sub4
INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
--인원이 추가되면 변경되야 하므로 실패코드(답만 나옴)
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp WHERE deptno IN (10,20,30));

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

--sub5
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid FROM cycle WHERE cid = 1);

--sub6
SELECT *
FROM cycle e
WHERE e.cid = 1 AND e.pid IN (SELECT pid FROM cycle d WHERE d. cid = 2);

--sub7
SELECT a.cid ,t.cnm, p.PID, p.PNM, a.day,a.cnt
FROM
(SELECT *
FROM cycle e
WHERE e.cid = 1 AND e.pid IN (SELECT pid FROM cycle d WHERE d. cid = 2))a, customer t , product p
WHERE a.pid = p.pid AND t.cid = a.cid;

--EXISTS
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 'X'
               FROM emp m
               WHERE e.mgr = m.empno);


--sub8
SELECT e.*
FROM emp e , emp m
WHERE e.mgr = m.empno;

--sub9
SELECT *
FROM product p  
WHERE EXISTS 
(SELECT * FROM product WHERE p.pid 
IN (SELECT pid FROM cycle WHERE cid = 1));

SELECT *
FROM product
WHERE EXISTS
(SELECT *
FROM cycle
WHERE cid = 1 AND pid = product.pid);

--sub10
SELECT *
FROM product
WHERE NOT EXISTS
(SELECT *
FROM cycle
WHERE cid = 1 AND pid = product.pid);

--집합연산자
--위아래 집합이 동일하기 때문에 합집합을 하더라도 행이 추가되진 않는다.
SELECT empno, ename
FROM emp
WHERE deptno = 10
UNION 
SELECT empno, ename
FROM emp
WHERE deptno = 10;

--위아래 집합에 7369번 사번은 중복 되므로 한번만 나오게 된다. : 전체행은 3건
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7566)
UNION 
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7782);

--UNION ALL 연산자는 중복제거 단계가 없다. 총 데이터 4개의 행
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7566)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7782);

--두 집합의 공통된 부분은 7369행 밖에 없음 총 데이터 1행
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7566)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7782);

--윗쪽 집합에서 아래쪽 집합의 행을 제거하고 남은 행 : 1개의 행 (7566)
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7566)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7782);

--집합연산자 특징
--1. 컬럼명은 첫번째 집합의 컬럼명을 따라간다
--2. ORDER BY 절은 마지막 집합에 적용한다. 
    -- 마지막 SQL이 아닌 SQL에서 정렬을 사용하고 싶은 경우 INLINE-VIEW를 활용
    -- UNION ALL의 경우 위, 아해 집합을 이어 주기 때문에 집합의 순서를 그대로 
    -- 유지 하기 때문에 요구사항에 따라 정렬된 데이터 집합이 필요하다면 해당 방법을 고려
     
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7566)
MINUS
SELECT empno , ename
FROM emp
WHERE empno IN (7369, 7782);