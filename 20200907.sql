SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <=10;

SELECT *
FROM(SELECT ROWNUM rn, a.*
     FROM(SELECT empno, ename
          FROM emp)a)
WHERE rn>=11 AND rn<=14;

SELECT *
FROM(SELECT ROWNUM rn, a.*
     FROM(SELECT empno, ename
          FROM emp
          ORDER BY ename ASC)a)
WHERE rn BETWEEN (:page -1)* : pageSize +1 AND :page *:pageSize;          
--WHERE rn>=11 AND rn<=14;

SELECT empno,ename, LENGTH('hello'), LENGTH(ename)
FROM emp;

SELECT LENGTH('hello')
FROM dual;

SELECT ename, LOWER(ename)
FROM emp
WHERE ename = UPPER('smith');
--문자열 관련 함수
SELECT  CONCAT('HELLO',', WORLD') concat,
/*       SUBSTR('HEllO ,WORLD' , 1, 5) substr,
        SUBSTR('HEllO ,WORLD' , 5) substr,
        LENGTH('HELLO, WORLA') length,
        INSTR('HELLO, WORLD', 'W') instr,
        INSTR('HELLO, WORLD', 'O') instr,
        INSTR('HELLO, WORLD', 'O', 6) instr,
        INSTR('HELLO, WORLD', 'O', 5 + 1) instr,
        INSTR('HELLO, WORLD', 'O', INSTR('HELLO, WORLD', 'O')+1) instr,
        LPAD('HELLO, WORLD', 15, '*') lpad,
        LPAD('HELLO, WORLD', 15) lpad,
        RPAD('HELLO, WORLD', 15) Rpad
        REPLACE('HELLO, WORLD', 'HELLO', 'HELL') replace,
        TRIM('HELLO, WORLD') trim,*/
        TRIM('   HELLO, WORLD       ') trim2,
        TRIM( 'H' FROM 'HELLO, WORLD') trim3
FROM dual;

--숫자 관련 함수 
SELECT ROUND(105.54, 1) round,
       ROUND(105.55, 1) round,
       ROUND(105.55, 0) round,
       ROUND(105.55, -1) round
FROM dual;

SELECT TRUNC(105.54, 1) trunc,
       TRUNC(105.55, 1) trunc,
       TRUNC(105.55, 0) trunc,
       TRUNC(105.55, -1) trunc
FROM dual;

SELECT MOD(10,3) , TRUNC(10/3,0) why
FROM dual;

--날짜 관련 함수
SELECT SYSDATE
FROM dual;

SELECT SYSDATE +5, SYSDATE, SYSDATE -5
FROM dual;

SELECT SYSDATE +(5/24/60/60), SYSDATE, SYSDATE -(5/24/60/60)
FROM dual;

SELECT TO_DATE('20191231','yyyymmdd')"LASTDAY", 
       TO_DATE('20191231','yyyymmdd')-5 "LASTDAY_BEFORES5",
       SYSDATE "NOW",
       SYSDATE -3 "NOW_BEFORES3"
FROM dual;