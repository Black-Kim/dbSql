 CREATE TABLE ranger(ranger_no NUMBER, ranger_nm VARCHAR2(50), reg_dt DATE);
  
 INSERT INTO ranger(RANGER_NO, ranger_nm, reg_dt) VALUES (1 , 'brown', SYSDATE);
 
 SELECT *
 FROM ranger;
 
 --테이블 삭제
 DROP TABLE ranger;
 
 --데이터 타입
 1. 숫자 : NUMBER (p,s) p:전체자리수, s: 소수점 자리수 라고 생각하면 됨
 2. 문자 : VARCHAR2(사이즈-byte 최대 4000byte), CHAR(X)(2000byte,고정길이 문자열)
          java - 2byte , oracle xe 11g - 3byte
          CHAR(5) 'test'
          test는 4 byte고 char(5) 5 byte이기 때문에 남는 데이터 공간에 공백 문자를 삽입함
          'test '
 3. 날짜 : DATE
           7byte 고정 , 일자 시간정보를 저장
           varchar2 날짜관리 : yyyymmdd ==> '20200918' ==> 8byte
           시스템에서 문자 형식으로 많이 사용한다면 문자 타입으로 사용도 고려
 4. Large OBJECT
    1. CLOB : 문자열을 저장할 수 있는 타입(최대 4gb)
    2. BLOB : 바이너리 데이터(유니코드) (최대 4gb)

-- 제약조건 생성
-- 테이블 생성시 컬럼 레벨로 제약조건 생성
CREATE TABLE 테이블명 ( 컬럼1이름 컬럼1타입 [컬럼제약조건]...);

CREATE TABLE dept_test (deptno NUMBER(2) PRIMARY KEY, dname VARCHAR(14), loc VARCHAR2(13));
-- PRIMARY KEY 제약에 의해 deptno 컬럼에는 NULL 값이 들어갈 수 없다.
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
-- 90번 부서는 존재하지 않고 NULL값이 아니므로 정상적으로 등록
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
-- 90번 부서가 이미 존재 하는 상태였기 때문에 PRIMARY KEY 제약에 의해 정상적으로 입력될 수 없다.
-- ORA-00001: unique constraint (PC01.SYS_C007083) violated
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');

--비교
--dept 테이블에는 deptno컬럼에 PRIMARY KEY 제약이 없는 상태
INSERT INTO dept VALUES(90, 'ddit', 'daejeon');
INSERT INTO dept VALUES(90, 'ddit', 'daejeon');
SELECT *
FROM dept
WHERE deptno = 90;

--제약조건 생성시 이름을 부여할수 있음
--명명규칙 : pk_테이블명
CREATE TABLE dept_test 
(deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY, dname VARCHAR(14), loc VARCHAR2(13));
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');

--테이블 생성시 테이블 레벨로 제약조건 생성
CREATE TABLE 테이블명( 컬럼 1 컬럼1의 데이터타입, 컬럼2 컬럼2의 데이터타입, [TABLE LEVEL제약조건]);

CREATE TABLE dept_test 
(deptno NUMBER(2) , dname VARCHAR(14), loc VARCHAR2(13), 
 CONSTRAINT PK_dept_test PRIMARY KEY (deptno, dname));
 --deptno 컬럼의 값은 90으로 같지만 dname 컬럼의 값이 다르므로 PRIMARY KEY(deptno, dname) 설정에 따라 데이터가 입력될 수 있다.
 --복합컬럼에 대한 제약조건은 컬럼 레벨에서는 설정이 불가하고 테이블레벨, 혹은 테이블 생성 후 제약조건을 추가하는 형태에서만 가능
 INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(90, 'ddit2', 'daejeon');

--NOT NULL제약조건 생성
DROP TABLE dept_test;

CREATE TABLE dept_test 
(deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY , dname VARCHAR(14) NOT NULL, loc VARCHAR2(13));

INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(91, NULL, 'daejeon');

--UNIQUE 제약조건 생성
--명명조건 U_테이블명_컬럼명
DROP TABLE dept_test;

CREATE TABLE dept_test 
(deptno NUMBER(2) , dname VARCHAR(14) , loc VARCHAR2(13),CONSTRAINT U_dept_test UNIQUE(dname));

INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(90, NULL, 'daejeon');
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');

SELECT *
FROM dept_test;

--FOREIGN KEY 제약조건 : 참조하는 테이블에 데이터만 입력가능하도록 제어 다른제약조건과 다르게 두개의 테이블 간의 제약조건 설정
1. dept_test (부모) 테이블 생성
2. emp_test (자식) 테이블 생성
    2.1 참조 제약 조건을 같이 생성

1.
DROP TABLE dept_test;
CREATE TABLE dept_test 
(deptno NUMBER(2) PRIMARY KEY , dname VARCHAR(14), loc VARCHAR2(13));
INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');

2.
CREATE TABLE emp_test 
(empno NUMBER(4) , ename VARCHAR2(10), deptno NUMBER(2)REFERENCES dept_test(deptno));

--참조 무결성 제약조건에 의해 emp_test 테이블의 deptno 컬럼의 값은 dept_test 테이블의 deptno 컬럼에 존재하는 값만 입력 가능하다.
--현재는 dept_test 테이블에는 90번 부서만 존재, 그렇기 때문에 emp_test 에는 90번 이외의 값이 들어갈 수 없다.
INSERT INTO emp_test VALUES (9000,'brown',90);
INSERT INTO emp_test VALUES (9001,'sally',10);

--테이블 레벨 참조 무결성 제약조건 생성
--명명조건 :FK_소스테이블_참조테이블
DROP TABLE emp_test;
CREATE TABLE emp_test
(empno NUMBER(4) , ename VARCHAR2(10), deptno NUMBER(2),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno));
INSERT INTO emp_test VALUES (9000,'brown',90);
INSERT INTO emp_test VALUES (9001,'sally',10);

DELETE dept_test
WHERE deptno = 90;

--참조 무결성 조건 2번
DROP TABLE emp_test;

CREATE TABLE emp_test
(empno NUMBER(4) , ename VARCHAR2(10), deptno NUMBER(2),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) 
REFERENCES dept_test(deptno) ON DELETE SET NULL);

INSERT INTO emp_test VALUES (9000,'brown',90);

DELETE dept_test
WHERE deptno = 90;

SELECT *
FROM emp_test;


--참조 무결성 조건 3번
DROP TABLE emp_test;

CREATE TABLE emp_test
(empno NUMBER(4) , ename VARCHAR2(10), deptno NUMBER(2),
CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) 
REFERENCES dept_test(deptno) ON DELETE CASCADE);

INSERT INTO dept_test VALUES (90, 'ddit', 'daejeon');
INSERT INTO emp_test VALUES (9000,'brown',90);

DELETE dept_test
WHERE deptno = 90;

SELECT *
FROM emp_test;

--CHECK 제약조건 (컬럼에서 생성)
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(14),
    sal NUMBER(7) CHECK ( sal > 0),
    gender VARCHAR2(1) CHECK ( gender IN('M','F')));
INSERT INTO emp_test VALUES (9000,'brown', -5, 'M'); --sal 체크
INSERT INTO emp_test VALUES (9000,'brown', 100, 'T'); --성별 체크
INSERT INTO emp_test VALUES (9000,'brown', 1000, 'M'); --체크 통과

SELECT *
FROM emp_test;

--CHECK 제약조건2 (오류 이름 붙이기)
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(14),
    sal NUMBER(7) CONSTRAINT c_sal CHECK ( sal > 0),
    gender VARCHAR2(1) CONSTRAINT c_gender CHECK ( gender IN('M','F')));
INSERT INTO emp_test VALUES (9000,'brown', -5, 'M'); --sal 체크
INSERT INTO emp_test VALUES (9000,'brown', 100, 'T'); --성별 체크
INSERT INTO emp_test VALUES (9000,'brown', 1000, 'M'); --체크 통과

--CHECK 제약조건3 (테이블 레벨에서 생성)
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(14),
    sal NUMBER(7),
    gender VARCHAR2(1),
    CONSTRAINT c_sal CHECK ( sal > 0),
    CONSTRAINT c_gender CHECK ( gender IN('M','F')));
INSERT INTO emp_test VALUES (9000,'brown', -5, 'M'); --sal 체크
INSERT INTO emp_test VALUES (9000,'brown', 100, 'T'); --성별 체크
INSERT INTO emp_test VALUES (9000,'brown', 1000, 'M'); --체크 통과


--DLL주의점 1
DROP TABLE emp_test;
CREATE TABLE emp_test (empno NUMBER(4), ename VARCHAR2(14));
ROLLBACK;

--DLL 주의점 2
DROP TABLE emp_test;
DROP TABLE dept_test;
CREATE TABLE emp_test (empno NUMBER(4), ename VARCHAR2(14));
INSERT INTO emp_test VALUES (9000, 'brown');
CREATE TABLE dept_test (deptno NUMBER(2), dname VARCHAR2(14));
--여기서부터는 새로운 트랜잭션
ROLLBACK;
SELECT *
FROM emp_test;

--SELECT 결과를 이용하여 테이블 생성하기
CREATE TABLE 테이블명 [(컬럼,컬럼2)] AS 
SELECT 쿼리;

DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

CREATE TABLE dept_test (dno,dnm,location) AS
SELECT *
FROM dept;

SELECT *
FROM dept_test;

--컬럼 추가
CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR(14));
DESC emp_test;
--emp_test 테이블에 hp컬럼을 VARCHAR2(15)로 추가
ALTER TABLE emp_test ADD (hp VARCHAR2(15));
--hp컬럼의 문자열 사이즈를 30으로 변경
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));
--hp컬럼의 문자열 타입을 NUMBER로 변경
ALTER TABLE emp_test MODIFY (hp NUMBER(10));

--컬럼명 변경(데이터 타입 변경과 다르게 이름 변경은 자유롭다)
--hp ==> phone
ALTER TABLE emp_test RENAME COLUMN hp TO phone;

--컬럼 삭제
ALTER TABLE emp_test DROP (phone);

--테이블이 이미 생성된 시점에서 제약조건을 추가, 삭제하기(쪼금 중요)
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 타입;
ALTER TABEL 테이블명 DROP CONSTRAINT 제약조건명;

DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test 
(deptno NUMBER(2) , dname VARCHAR(14));
CREATE TABLE emp_test
(empno NUMBER(4) , ename VARCHAR2(10), deptno NUMBER(2));

1.dept_test 테이블의 deptno컬럼에 PRIMARY KEY 제약조건 추가
ALTER TABLE dept_test ADD CONSTRAINT PK_DEPT_TEST PRIMARY KEY(deptno);
2.emp_test 테이블의 empno컬럼에 PRIMARY KEY 제약조건 추가
ALTER TABLE emp_test ADD CONSTRAINT PK_EMP_TEST PRIMARY KEY(empno);
3.emp_TEST 테이블의 deptno컬럼이 dept_test 컬럼의 deptno컬럼을 참조하는 FOREIGN KEY 제약조건 추가;
ALTER TABLE emp_test ADD CONSTRAINT FK_EMP_DEPT_TEST FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

INSERT INTO dept_test VALUES(90, 'ddit', 'daejeon');