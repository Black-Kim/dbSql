--comm 컬럼이 NULL일때 0으로 변경하여 sal 컬럼과 합계를 구한다.
SELECT empno, ename, sal, comm, 
       sal + NVL(comm, 0) nvl_sum,
       sal + NVL2(comm, comm, 0) nvl2_sum,
       NVL2(comm, comm + sal, sal) nvl2_sum2,
       NULLIF(sal, sal) nullif,
       NULLIF(sal, 5000) nullif_sal,
       sal+ COALESCE(comm, 0) coalesce_sum,
       COALESCE(sal + comm, sal) coalesce_sum2
FROM emp;

DESC emp;

--실습fn4
SELECT empno, ename, mgr, 
       NVL(mgr, 9999) MGR_N,
       NVL2(mgr, mgr, 9999) MGR_N_1, 
       COALESCE (mgr, 9999) MGR_N_2
FROM emp;

--실습 fn5(다시 복습 필요)
SELECT userid, usernm, reg_dt,
       NVL(reg_dt, SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

--조건
SELECT ename, job, sal, 
       CASE
        WHEN job ='SALESMAN' THEN sal * 1.05
        WHEN job ='MANAGER' THEN sal * 1.10
        WHEN job ='PRESIDENT' THEN sal * 1.20
        ELSE sal
       END sal_b
FROM emp;

SELECT ename, job, sal,
       CASE
        WHEN job ='SALESMAN' THEN sal * 1.05
        WHEN job ='MANAGER' THEN sal * 1.10
        WHEN job ='PRESIDENT' THEN sal * 1.20
        ELSE sal
       END sal_b,
         DECODE(job , 'SALESMAN', sal * 1.05,
                      'MANAGER', sal *1.10,
                      'PRESIDENT', sal * 1.20,
                       sal) sal_c
                      
FROM emp;

--실습 cond1
SELECT empno, ename, 
        CASE
         WHEN deptno = 10 THEN 'ACCOUNTING'
         WHEN deptno = 20 THEN 'RESEARCH'
         WHEN deptno = 30 THEN 'SALES'
         WHEN deptno = 40 THEN 'OPERATIONS'
         ELSE 'DDIT'
         END DNAME,
         DECODE(deptno , 10, 'ACCOUNTING',
                      20, 'RESEARCH',
                      30, 'SALES',
                      40, 'OPERATIONS',
                       'DDIT') DNAME_B
FROM emp;

--실습 cond2
SELECT empno, ename, hiredate,
        CASE
          WHEN MOD(TO_CHAR(hiredate,'yy'),2) =0 AND MOD(TO_CHAR(SYSDATE,'yy'),2)=0 THEN '건강검진 대상자'
          WHEN MOD(TO_CHAR(hiredate,'yy'),2)!=0 AND MOD(TO_CHAR(SYSDATE,'yy'),2)=0 THEN '건강검진 비대상자'
         END CONTRACT_TO_DOCTOR        
FROM emp;

SELECT empno, ename, hiredate,
        CASE
          WHEN MOD(TO_CHAR(hiredate,'yy'),2) = MOD(TO_CHAR(SYSDATE,'yy'),2) THEN '건강검진 대상자'
          ELSE '건강검진 비대상자'
          END CONTRACT_TO_DOCTOR        
FROM emp;

SELECT empno, ename,hiredate,
       CASE
        WHEN case1 + case2 = 2 THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
        END CONTRACT_TO_DOCTOR
FROM
(SELECT empno, ename,hiredate,CASE
        WHEN MOD(TO_CHAR(hiredate,'yy'),2)=0 THEN 1
        END case1,
        CASE
        WHEN MOD(TO_CHAR(SYSDATE,'yy'),2)=0 THEN 1
        END case2
FROM emp);

--실습 cond3
SELECT userid, usernm, alias,TO_CHAR(reg_dt,'yyyy/mm/dd') REG_DT,
        CASE
          WHEN MOD(TO_CHAR(reg_dt,'yy'),2) = MOD(TO_CHAR(SYSDATE,'yy'),2) THEN '건강검진 대상자'
          WHEN reg_dt IS Null THEN '건강검진 비대상자'
          ELSE '건강검진 비대상자' 
         END CONTRACTTODOCTOR,
         DECODE(MOD(TO_CHAR(reg_dt,'yy'),2),
                                    MOD(TO_CHAR(SYSDATE,'yy'),2), '건강검진 대상자',
                                    '건강검진 비대상자') CONTRACTTODOCTOR2
FROM users;