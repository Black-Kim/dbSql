SELECT *
FROM emp
WHERE comm IS NULL;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE deptno NOT IN (10);

SELECT *
FROM emp
WHERE mgr IS NULL;

SELECT *
FROM emp
WHERE mgr = 7698 OR sal > 1000;
h--WHERE mgr = 7698 AND sal > 1000;

SELECT *
FROM emp
h--WHERE mgr != 7698 AND mgr !=7839;
WHERE mgr NOT IN(7698, 7839);

SELECT *
FROM emp
WHERE mgr IN (7698, 7839) OR mgr IS NULL;
h--WHERE mgr IN (7698, 7839, NULL);
h--WHERE mgr NOT IN (7698, 7839, NULL);

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate >= TO_DATE ('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN(20,30) AND hiredate >= TO_DATE ('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job IN('SALESMAN') OR hiredate >= TO_DATE ('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno  78%;

SELECT *
FROM emp
WHERE job IN('SALESMAN') OR empno IN(78);  ????????????

SELECT *
FROM emp
WHER job = 'SALESMAN' OR               ????????????;

SELECT *
FROM emp
ORDER BY job, empno DESC;

SELECT empno eno,  ename enm
FROM emp
ORDER BY enm;   

SELECT empno, ename, sal, sal +500
FROM emp
ORDER BY sal +500;

SELECT deptno, dname, loc
FROM dept
ORDER BY dname;

SELECT deptno, dname, loc
FROM dept
ORDER BY dname DESC;

SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm NOT IN(0)
--WHERE comm != 0
ORDER BY comm DESC, empno DESC;

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job , empno DESC;

SELECT *
FROM emp
WHERE deptno IN(10,30) AND sal > 1500
ORDER BY ename DESC;

SELECT  *
FROM (SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename)a)
WHERE rn BETWEEN (:page -1) * : pageSize +1 AND :page * :pageSize;

SELECT ROWNUM, e.*
FROM emp e;
