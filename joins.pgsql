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
