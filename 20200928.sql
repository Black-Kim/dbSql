SELECT deptcd,LPAD(' ',(LEVEL-1) *3) || deptnm deptnm
FROM dept_h
START WITH DEPTCD = 'dept0'
CONNECT BY PRIOR DEPTCD = P_DEPTCD
ORDER BY LEVEL, deptcd;

--**PRIOR 키워드는 CONNECT BY 바로 다음에 나오지 않아도 된다.
CONNECT BY PRIOR DEPTCD = P_DEPTCD
CONNECT BY P_DEPTCD = PRIOR DEPTCD

--**연결 조건이 두개 이상일 때
CONNECT BY PRIOR p = q AND PRIOR a = b;

--실습 h_2
SELECT level lv,deptcd,LPAD(' ',(LEVEL-1) *3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH DEPTCD = 'dept0_02'
--START WITH DEPTNM = '정보시스템부'
CONNECT BY PRIOR DEPTCD = P_DEPTCD
ORDER BY LEVEL, deptcd;

--계층쿼리(상형식)
--디자인팀(dept0_00_0)부터 시작하여 자신의 상위 부서로 연결하는 쿼리
SELECT LEVEL lv, deptcd, LPAD(' ',(LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

SELECT *
FROM h_sum;

--실습 h_4
SELECT LPAD(' ',(LEVEL-1)*3) || S_ID s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--가지치기
--하향식 쿼리로 데이터 조회
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptcd != 'dept0_01';
현재읽은 행의 deptcd 값이 앞으로 읽을 행의 p_deptcd 컬럼과 같고
앞으로 읽을 행의 dept_cd 컬럼값이 'dept0_01'이 아닐때 연결하겠다.

==>XX회사 밑에는 디자인부, 정보기획부, 정보시스템부 3개의 부가 있는데
   그중에서 정보기획부를 제외한 2개 부서에 대해서만 연결하겠다.

행 제한 조건을 WHERE절에 기술한 경우 
FROM -> START WITH -> WHERE 절 순으로 실행되기 때문에 
1. 계층 탐색을 전부 완료한 후
2. WHERE 절에 해당하는 행만 데이터를 제외한다.
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm
FROM dept_h
WHERE deptcd != 'dept0_01'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

--계층쿼리 특수함수
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm,
       CONNECT_BY_ROOT(deptnm) cbr,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'),'-') scbp,
       CONNECT_BY_ISLEAF CBI
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM board_test;

--실습 h6
SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH seq IN(1,2,4)
--START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;
--실습 h7
SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title,
       CONNECT_BY_ROOT(seq) gn
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY gn DESC, seq;

1. CONNECT_BY_ROOT 를 활용한 그룹번호 생성
SELECT *
FROM
(SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title,
       CONNECT_BY_ROOT(seq) gn
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq)
ORDER BY gn DESC, seq ASC;

2. gn(NUMBER) 컬럼을 테이블에 추가
ALTER TABLE board_test ADD (gn NUMBER);
UPDATE board_test SET gn = 1
WHERE seq IN(1,9);
UPDATE board_test SET gn = 2
WHERE seq IN(2,3);
UPDATE board_test SET gn = 4
WHERE seq NOT IN(1,2,3,9);
COMMIT;

SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC , seq ASC;

SELECT seq
FROM board_test
WHERE parent_seq IS NULL
START WITH parent_seq IS NULL
CONNECT BY  seq = PRIOR parent_seq
ORDER SIBLINGS BY seq DESC ;

--분석함수, 윈도운 함수
SELECT empno, ename, sal
FROM emp 
WHERE sal = (SELECT MAX(sal)  FROM emp);

SQL의 단점 : 행간 연산이 부족 ==> 해당 부분을 보완 해주는 것이 분석함수(윈도우 함수)
--실습 ana0
SELECT  ename, sal,deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

분석함수 사용하지 않고도 위와 동일한 결과를 만들어내는 것이 가능
(*** 분석함수가 모드 DBMS에서 제공을 하지는 않음);
SELECT  ename, sal, deptno
FROM emp e
WHERE e.sal IN (SELECT m.sal  FROM emp m WHERE e.deptno = m.deptno)
ORDER BY deptno , sal DESC;

SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno;

SELECT *
FROM
(SELECT a.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 10
ORDER BY sal DESC)a
UNION
SELECT a.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 20
ORDER BY sal DESC)a
UNION
SELECT a.*, ROWNUM sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno = 30
ORDER BY sal DESC)a)
ORDER BY deptno, sal_rank;

--순위관련 분석함수 - 동일 값에 대한 순위처리에 따라 3가지 함수 제공
SELECT ename, sal, deptno,
      RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_rank,
      DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_dense_rank,
      ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_row_number
FROM emp;

--실습 ana1
SELECT empno, ename, sal,deptno, 
       RANK() OVER(ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_number
FROM emp;
--no_ana2
SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;
--윈도우 함수 없이
SELECT empno, ename, emp.deptno, a.cnt
FROM emp,
(SELECT deptno, COUNT(*) cnt FROM emp GROUP BY deptno) a
WHERE emp.deptno = a.deptno
ORDER BY deptno;

--실습 ana2
SELECT empno, ename, deptno,
       ROUND(AVG(sal) OVER(PARTITION BY deptno),2) avg_sal
FROM emp;
--윈도우 함수 없이
SELECT empno, ename, emp.deptno, a.avg_sal
FROM emp,
(SELECT deptno, ROUND(AVG(sal),2) avg_sal FROM emp GROUP BY deptno) a
WHERE emp.deptno = a.deptno
ORDER BY deptno;

--실습 ana3
SELECT empno, ename, deptno,
       MAX(sal) OVER(PARTITION BY deptno) max_sal
FROM emp;

--실습 ana4
SELECT empno, ename, deptno,
       MIN(sal) OVER(PARTITION BY deptno) min_sal
FROM emp;