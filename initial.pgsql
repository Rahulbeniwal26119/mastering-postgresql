-- ****** Create initial tables ******


-- CREATE TABLE departments (
    -- DEPTNO INT PRIMARY KEY,
    -- DNAME VARCHAR(255),
    -- LOC VARCHAR(255)
-- );

-- CREATE TABLE employees (
--     EMPNO BIGINT PRIMARY KEY,
--     ENAME VARCHAR(30),
--     JOB VARCHAR(30),
--     MGR BIGINT REFERENCES employees(EMPNO),
--     HIREDATE DATE,
--     SAL INT,
--     COMM INT NULL,
--     DEPTNO INT REFERENCES departments(DEPTNO)
-- );

-- ****** Insert into departements ******


-- INSERT INTO departments (DEPTNO, DNAME, LOC)
-- VALUES (10, 'ACCOUNTING', 'NEW YORK');

-- INSERT INTO departments (DEPTNO, DNAME, LOC)
-- VALUES (20, 'RESEARCH', 'DALLAS');

-- INSERT INTO departments (DEPTNO, DNAME, LOC)
-- VALUES (30, 'SALES', 'CHICAGO');

-- INSERT INTO departments (DEPTNO, DNAME, LOC)
-- VALUES (40, 'OPERATIONS', 'BOSTON');

-- ****** Insert into employees ******

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES (7839, 'KING', 'PRESIDENT', NULL, TO_DATE('17-NOV-2006', 'DD-MON-YYYY'), 5000, 1400, 10);

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES (7698, 'BLAKE', 'MANAGER', 7839, TO_DATE('01-MAY-2006', 'DD-MON-YYYY'), 2850, NULL, 30);

-- -- Inserting the second employee record
-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES (7782, 'CLARK', 'MANAGER', 7839, TO_DATE('09-JUN-2006', 'DD-MON-YYYY'), 2450, NULL, 10);

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES (7566, 'JONES', 'MANAGER', 7839, TO_DATE('02-APR-2006', 'DD-MON-YYYY'), 2975, NULL, 20);

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES
--   (7369, 'SMITH', 'CLERK', NULL, TO_DATE('17-DEC-2005', 'DD-MON-YYYY'), 800, NULL, 20),
--   (7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-FEB-2006', 'DD-MON-YYYY'), 1600, 300, 30),
--   (7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-FEB-2006', 'DD-MON-YYYY'), 1250, 500, 30);

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES (7654, 'MARTIN', 'SALESMAN', 7698, TO_DATE('28-SEP-2006', 'DD-MON-YYYY'), 2850, NULL, 30);

-- INSERT INTO employees (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
-- VALUES
--   (7844, 'TURNER', 'SALESMAN', 7698, TO_DATE('08-SEP-2006', 'DD-MON-YYYY'), 1500, 0, 30),
--   (7876, 'ADAMS', 'CLERK', 7788, TO_DATE('12-JAN-2008', 'DD-MON-YYYY'), 1100, NULL, 20),
--   (7900, 'JAMES', 'CLERK', 7698, TO_DATE('03-DEC-2006', 'DD-MON-YYYY'), 950, NULL, 30),
--   (7902, 'FORD', 'ANALYST', 7566, TO_DATE('03-DEC-2006', 'DD-MON-YYYY'), 3000, NULL, 20),
--   (7934, 'MILLER', 'CLERK', 7782, TO_DATE('23-JAN-2007', 'DD-MON-YYYY'), 1300, NULL, 10),
--   (7788, 'SCOTT', 'ANALYST', 7566, TO_DATE('09-DEC-2007', 'DD-MON-YYYY'), 3000, NULL, 20);

