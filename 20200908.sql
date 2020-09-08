SELECT SYSDATE , TO_CHAR(SYSDATE,'DD-MM-YYYY'), 
       TO_CHAR(SYSDATE, 'D'), TO_CHAR(SYSDATE, 'IW')
FROM dual;

SELECT ename,
--       SUBSTR('20200908', 1, 4) || '/' || SUBSTR('202009098', 5, 2) || '/' || SUBSTR('202009098', 7, 2)
       hiredate, TO_CHAR(hiredate, ' yyyy/mm/dd hh24:mi:ss') h1,
       TO_CHAR(hiredate +1, ' yyyy/mm/dd hh24:mi:ss') h2,
       TO_CHAR(hiredate +1/24, ' yyyy/mm/dd hh24:mi:ss') h3,
       TO_CHAR(TO_DATE('20200908','YYYYMMDD'), 'YYYY/MM/DD') h4
FROM emp;

SELECT TO_DATE( TO_CHAR(SYSDATE,'YYYMMDD'),'yyyymmdd')
FROM dual;

--실습 fn2
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') "DT_DASH", 
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS') "DT_DASH_WITH_TIME",
       TO_CHAR(SYSDATE,'DD-MM-YYYY') "DT_DD_MM_YYYY"
FROM dual;

--날짜 조작 함수
SELECT --MONTHS_BETWEEN(TO_DATE('20200915','YYYYMMDD'), TO_DATE('20200808','YYYYMMDD'))
       --ADD_MONTHS(SYSDATE, 5)
       --NEXT_DAY(SYSDATE, 6)
       --LAST_DAY(SYSDATE)
       TO_DATE (TO_CHAR(SYSDATE,'YYYYmm'),'yyyymm'),
       CONCAT(TO_CHAR(SYSDATE,'YYYY/mm/'),'01')
FROM dual;

SELECT SYSDATE - TO_CHAR(SYSDATE, 'DD') +1
FROM dual;

--실습 fn3
--SELECT :yyyymm "PARAM", SUBSTR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),9,2)"DT"
SELECT :yyyymm "PARAM", TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'DD')"DT"
FROM dual;

--형변환
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7900+'69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

--숫자를 문자로 포맷팅 : db보다는 국제화 (IL8n)
SELECT empno, ename, sal, TO_CHAR(sal, '009,999L')
FROM emp;

SELECT empno, comm, NVL(comm,0)
FROM emp;
