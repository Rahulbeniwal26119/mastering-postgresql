-- union all will keep the duplicates
SELECT
    ename AS ename_and_dname,
    deptno
FROM
    employees
WHERE
    deptno = 10
UNION ALL
SELECT
    '----------' AS ename_and_dname,
    NULL AS deptno
UNION ALL
SELECT
    dname,
    deptno
FROM
    departments;

-- union will remove the duplicates
SELECT
    deptno
FROM
    employees
UNION
SELECT
    deptno
FROM
    departments;

-- Equivalent Query
SELECT DISTINCT
    deptno
FROM (
    SELECT
        deptno
    FROM
        employees
    UNION
    SELECT
        deptno
    FROM
        departments) x;

-- Joining table on known common value
SELECT
    e.ename,
    d.loc
FROM
    employees e
    JOIN departments d ON e.deptno = d.deptno
WHERE
    e.deptno = 10;

-- Another Way of achieve above results
-- It will make cartesion product of both table and then filter on the basis of deptno condition
-- Equi Join Example
SELECT
    e.ename,
    d.loc
FROM
    employees e,
    departments d
WHERE
    d.deptno = e.deptno
    AND e.deptno = 10;

DROP VIEW V;

CREATE VIEW V AS
SELECT
    ename,
    job,
    sal
FROM
    employees
WHERE
    job = 'CLERK';

-- Filtering row on the basis of equality For MYSQL and SQL SERVER
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    e.deptno
FROM
    employees e,
    V
WHERE
    e.ename = V.ename
    AND e.job = v.job
    AND e.sal = v.sal;

-- Filtering row on the basis of equality Using INTERSECT
SELECT
    empno,
    ename,
    job,
    sal,
    deptno
FROM
    employees
WHERE (ename, job, sal) IN (
    SELECT
        ename,
        job,
        sal
    FROM
        employees
    INTERSECT
    SELECT
        ename,
        job,
        sal
    FROM
        V);

-- Reterving deptno which donot have any employees
SELECT
    deptno
FROM
    departments
EXCEPT
SELECT
    deptno
FROM
    employees;

-- Truth TABLES
--  OR | T | F | N |
-- +----+---+---+----+
-- | T | T | T | T |
-- | F | T | F | N |
-- | N | T | N | N |
-- +----+---+---+----+
-- NOT |
-- +-----+---+
-- | T | F |
-- | F | T |
-- | N | N |
-- +-----+---+
--  AND | T | F | N |
-- +-----+---+---+---+
-- | T | T | F | N |
-- | F | F | F | F |
-- | N | N | F | N |
-- +-----+---+---+---+
-- When using in or not in always be cautions with NULL
-- Below query will return no results.
SELECT
    deptno
FROM
    departments
WHERE
    deptno NOT IN (10, 50, NULL);

-- Lets for undestand it for Dept no 20
-- DEPTNO=20
-- NOT (deptno=10 or deptno=50 or deptno=null)
-- = NOT (20=10 or 20=50 or 20=null)
-- = NOT (F or F or N)
-- = NOT (F or N)
-- = NOT (N)
-- = (N)
-- Not exists check if a row return by subquery or not
SELECT
    deptno
FROM
    departments d
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            employees e
        WHERE
            d.deptno = e.deptno);

-- Finding which departments has no employees
-- Left outer join makes cartesion mapping with all matching deptno and ALSO
-- make a entry for dept which has no mapping with employees will all employees values NULL
-- It is also call anti JOIN
SELECT
    d.*
FROM
    departments d
    LEFT OUTER JOIN employees e ON (d.deptno = e.deptno)
WHERE
    e.deptno IS NULL;

