DESC emp;

SELECT empno AS test
FROM emp;

users 테이블에는 총 5명의 캐릭터가 등록이 되어 있는데 
그중에서 userid 컬럼의 값이 'brown'인 행만 조회되도록
WHERE절에 조건을 기술
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE 1=2;

emp 테이블에서 부서번호(deptno)가 30보다 크거나 같은 사원들만 조회
컬럼은 모든 컬럼 조회
SELECT *
FROM emp
WHERE deptno >= 30;

날짜 비교
1982년 1월 1일 이후에 입사한 사람들만 조회
컬럼은 이름, 입사일
*hiredate type : date
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'yyyy/mm/dd');

emp테이블에서 sal 컬럼의 값이 1000 이상 2000이하인 사원들의 모든 컬럼을 조회
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

비교연산자를 이용한 풀이
SELECT *
FROM emp
WHERE sal >= 1000 AND sal <= 2000;

[실습 WHERE] (ppt 82~83)
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'yyyy/mm/dd') 
                   AND TO_DATE('1983/01/01', 'yyyy/mm/dd');
                   
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101','yyyymmdd') 
  AND hiredate <= TO_DATE('19830101','yyyymmdd');


[IN연산자]
emp테이블에서 사원이 10번 부서 혹은 30번 부서에 속한 사원들정보를 조회(모든컬럼)
SELECT *
FROM emp
WHERE deptno IN (10 , 30);

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30;

[실습 WHERE3] (ppt 85)
SELECT userid "아이디" , usernm "이름", alias "별명" 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

SELECT userid 아이디 , usernm 이름, alias 별명 
FROM users
WHERE userid = 'brown' 
   OR userid = 'cony' 
   OR userid = 'sally';

[LIKE 연산자]
SELECT *
FROM emp
WHERE ename LIKE 'W___';

[실습 WHERE4]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

[실습 WHERE5]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';


[실습 WHERE6]
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE comm IS NOT NULL;