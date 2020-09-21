--제약조건 조회
SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');

SELECT *
FROM user_constraints
WHERE table_name = 'EMP';

--제약조건 삭제
ALTER TABLE emp_test DROP CONSTRAINT FK_emp_dept_test;
ALTER TABLE dept_test DROP CONSTRAINT PK_dept_test;
ALTER TABLE emp_test DROP CONSTRAINT PK_emp_test;

--제약조건 생성
ALTER TABLE dept_test ADD CONSTRAINT PK_dept_test PRIMARY KEY (deptno);
ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test 
            FOREIGN KEY (deptno) REFERENCES dept_test(deptno);
            
--제약조건 활성화 비활성화 테스트
--테스트 데이터 준비 : 부모 - 자식 관계가 있는 테이블에서는 부모 테이블에 데이터를 먼저 입력
dept_test ==> emp_test
INSERT INTO dept_test VALUES (10, 'ddit');
--dept_test 와 emp_test 테이블간 fk가 설정되어 있지만 10번 부서는 dept_test에 존재하기 때문에 정상입력
INSERT INTO emp_test VALUES (9999,'brown',10);
--20번 부서는 dept_test 테이블에 존재하지 않는 데이터이기 때문에 fk에 의해 입력불가
INSERT INTO emp_test VALUES (9998,'sally',20);

--FK 비활성화 한후 다시 입력
SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');

ALTER TABLE emp_test DISABLE CONSTRAINT FK_emp_test_dept_test;
INSERT INTO emp_test VALUES (9998,'sally',20);
COMMIT;

--fk 제약조건 재 활성화
ALTER TABLE emp_test ENABLE CONSTRAINT FK_emp_test_dept_test;

--테이블, 컬럼 (comments) 생성가능
--테이블 주석 정보확인
user_tables, user_constrints, user_tab_comments
SELECT *
FROM user_tab_comments;

--테이블 주석 작성방법
COMMENT ON TABLE 테이블병 IS '주석';
--emp 테이블에 주석(사원) 생성하기
COMMENT ON TABLE emp IS '사원';
--컬럼 주석 확인
SELECT *
FROM user_col_comments
WHERE table_name = 'EMP';

컬럼 주석 다는 문법
COMMENT ON COLUMN 테이블명. 컬럼명 IS '주석';

COMMENT ON COLUMN emp.EMPNO IS '사번';
COMMENT ON COLUMN emp.ENAME IS '사원이름';
COMMENT ON COLUMN emp.JOB IS '담당역할';
COMMENT ON COLUMN emp.MGR IS '매니저 사번';
COMMENT ON COLUMN emp.HIREDATE IS '입사일자';
COMMENT ON COLUMN emp.SAL IS '급여';
COMMENT ON COLUMN emp.COMM IS '성과급';
COMMENT ON COLUMN emp.DEPTNO IS '소속부서번호';

--comment1
SELECT t.table_name, t.table_type, t.COMMENTS tab_comment, c.column_name, c.COMMENTS col_comment
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name 
      AND (t.table_name = 'CUSTOMER'
      OR t.table_name = 'PRODUCT'
      OR t.table_name = 'CYCLE'
      OR t.table_name = 'DAILY');
      
SELECT *
FROM user_constraints
WHERE table_name IN ('EMP','DEPT');

ALTER TABLE dept_test ADD CONSTRAINT PK_dept_test PRIMARY KEY (deptno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test 
            FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_emp FOREIGN KEY (mgr) REFERENCES emp (empno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

--view
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

GRANT CONNECT, RESOURCE TO 계정명;
--view에 대한 생성권한은 RESOURCE에 포함되지 않는다.

SELECT *
FROM v_emp
WHERE deptno = 10;

GRANT SELECT ON v_emp TO hr;
