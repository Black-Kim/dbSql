SELECT *
FROM emp, dept;

SELECT *
FROM customer, product;

--서브쿼리
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;

==> 서브쿼리를 이용하여 하나로 합칠수가 있다
서브쿼리가 한개의 행 복수컬럼을 조회하고, 단일 컬럼과 = 비교하는 경우 ==>x
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');

서브쿼리가 여러개의 행, 단일 컬럼을 조회하는 경우
1. 사용되는 위치 : WHRER - 서브쿼리
2. 조회되는 행 , 컬럼의 개수 : 복수행, 단일컬럼
3. 메인쿼리의 컬럼을 서브쿼리에서 사용유무 : 비상호연관 서브쿼리
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename = 'SMITH' 
                 OR ename = 'ALLEN');

[sub1]
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
[sub2]             
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);                
[sub3]
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN('SMITH', 'WARD'));

복수행 연산자 : IN(중요) , ANY, ALL(빈도 떨어짐)
SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
                 FROM emp
                 WHERE ename IN('SMITH', 'WARD'));
-- SAL 컬럼의 값이 800이나, 1250 보다 작은 사원 

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                 FROM emp
                 WHERE ename IN('SMITH', 'WARD'));
-- SAL 컬럼의 값이 800보다 크다 1250보다 큰 사원

관리자가 아닌 사원의 정보를 조회
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp);
                    
--pair wise
서브쿼리 : 복수행, 복수컬럼
SELECT *
FROM emp
WHERE (mgr,deptno) IN (SELECT mgr, deptno 
                       FROM emp
                       WHERE empno IN ( 7499, 7782));
                       
--SCALAR SUBQUERY
***스칼라 서브 쿼리는 하나의 행, 하나의 컬럼을 조회하는 쿼리여야 한다.
SELECT dummy, (SELECT SYSDATE
               FROM dual)
FROM dual;

--스칼라 서브쿼리가 복수개의 행(4개), 단일 컬럼을 조회 ==> 에러
SELECT empno, ename, deptno, (SELECT dname FROM dept)
FROM emp;

emp 테이블과 스칼라 서브쿼리를 이용하여 부서명 가져오기
기존 : emp 테이블과 dept 테이블을 조인하여 컬럼을 확장
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;



SELECT *
FROM dept
WHERE deptno IN ( SELECT deptno FROM emp);

