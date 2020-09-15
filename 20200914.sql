
SELECT *
FROM customer;

SELECT *
FROM batch;

pid : product id 제품 id
pnm : product name 제품명

SELECT *
FROM product;

cycle : 고객애음주기
cid : customer id 고객 id
pid : produck id 제품 id


SELECT *
FROM cycle;

SELECT *
FROM daily;

SELECT cycle.CID,cnm,pid,day,cnt
FROM customer JOIN cycle ON(CUSTOMER.cid=cycle.cid)
WHERE cnm LIKE('brown') OR cnm LIKE('sally');

SELECT cycle.CID,cnm,pid,day,cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid AND 
(cnm LIKE('brown') OR cnm LIKE('sally'));

--join 5 Oracle
SELECT cycle.cid, cnm, product.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid 
  AND cycle.pid = product.pid
  AND (cnm LIKE('brown') OR cnm LIKE('sally')) ;
--join 5 ANSI  
SELECT customer.cid, customer.cnm, product.pid, pnm, day, cnt
FROM customer  JOIN cycle ON (CUSTOMER.cid=cycle.cid) 
              JOIN product ON (product.pid = cycle.pid)
WHERE cnm LIKE('brown') OR cnm LIKE('sally');

--join6 Oracle
SELECT customer.cid, cnm, product.pid, pnm, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
AND (cnm LIKE('brown') OR cnm LIKE('sally')) 
GROUP BY ;

SELECT 
FROM cycle
WHERE cid =1 AND PID =100
GROUP BY cnt;

SELECT *
FROM product
GROUP BY ;

SELECT e.empno, e.ename, m.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

SELECT e.empno, e.ename, m.mgr, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

ANSI - SQL
SELECT e.empno, e.ename, m.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename, m.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE - SQL :데이터가 없는 쪽의 컬럼에 (+)기호를 붙인다. 
              ANSI-SQL 기준 테이블 반대편 테이블 컬럼에 (+)을 붙인다
              WHERE 절 연결 조건에 적용
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, m.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);



SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);

SELECT e.empno, e.ename, e.mgr,e.deptno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno )
WHERE e.deptno = 10;

SELECT e.empno, e.ename, e.mgr,e.deptno, m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno )
WHERE e.deptno = 10;


SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT  e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT  e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
INTERSECT
SELECT  e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

-- outerjoin
SELECT b.buy_date, b.buy_prod, p.prod_id, p.PROD_NAME, b.BUY_QTY
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.PROD_ID = b.BUY_PROD AND BUY_DATE = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT b.buy_date, b.buy_prod, p.prod_id, p.PROD_NAME, b.BUY_QTY
FROM buyprod b , prod p
WHERE p.PROD_ID = b.BUY_PROD(+) AND b.BUY_DATE(+) = TO_DATE('2005/01/25','yyyy/mm/dd');

SELECT NVL(b.buy_date,'2005/01/25') buy_date, b.buy_prod, p.prod_id, p.PROD_NAME, b.BUY_QTY
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.PROD_ID = b.BUY_PROD AND BUY_DATE = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT NVL(b.buy_date,'2005/01/25') buy_date, b.buy_prod, p.prod_id, p.PROD_NAME, NVL(b.BUY_QTY, 0) buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.PROD_ID = b.BUY_PROD AND BUY_DATE = TO_DATE('2005/01/25','yyyy/mm/dd'));

