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

SELECT
    e.ename,
    d.loc,
    eb.received
FROM
    employees e
    JOIN departments d ON (e.deptno = d.deptno)
    LEFT JOIN emp_bonus eb ON e.empno = eb.empno
ORDER BY
    3;

-- Alternative Way
SELECT
    e.ename,
    d.loc,
(
        SELECT
            eb.received
        FROM
            emp_bonus eb
        WHERE
            eb.empno = e.empno) AS received
FROM
    employees e,
    departments d
WHERE
    e.deptno = d.deptno
ORDER BY
    3;

-- Determining if two tables have same data or not
CREATE VIEW V AS
SELECT
    *
FROM
    employees
WHERE
    deptno <> 10
UNION ALL
SELECT
    *
FROM
    employees
WHERE
    ename = 'WARD';

(
    SELECT
        empno,
        ename,
        job,
        sal,
        comm,
        count(*) AS cnt
    FROM
        v
    GROUP BY
        empno,
        ename,
        job,
        sal,
        comm
    EXCEPT
    SELECT
        empno,
        ename,
        job,
        sal,
        comm,
        count(*) AS cnt
    FROM
        employees
    GROUP BY
        empno,
        ename,
        job,
        sal,
        comm)
UNION ALL (
    SELECT
        empno,
        ename,
        job,
        sal,
        comm,
        count(*) AS cnt
    FROM
        employees
    GROUP BY
        empno,
        ename,
        job,
        sal,
        comm
    EXCEPT
    SELECT
        empno,
        ename,
        job,
        sal,
        comm,
        count(*) AS cnt
    FROM
        v
    GROUP BY
        empno,
        ename,
        job,
        sal,
        comm);

-- A INTERSECTION B UNION B INTERSECTION A = NULL then same
-- Alternative but less reliable way (Check cardinality)
-- if union returns a single row then both table have same data count
SELECT
    count(*) AS cnt
FROM
    employees
UNION
SELECT
    count(*) AS cnt
FROM
    v;

SELECT
    *
FROM (
    SELECT
        e.empno,
        e.ename,
        e.job,
        count(*)
    FROM
        employees e
    GROUP BY
        empno,
        ename,
        deptno,
        job) AS e
WHERE
    NOT EXISTS (
        SELECT
            NULL
        FROM (
            SELECT
                v.empno,
                v.ename,
                v.job,
                count(*)
            FROM
                v
            GROUP BY
                empno,
                ename,
                deptno,
                job) AS v
        WHERE
            e.empno = v.empno
            AND e.ename = v.ename
            AND e.job = v.job
            AND e.count = v.count);

SELECT
    *
FROM
    employees e,
    departments d
WHERE
    e.deptno = 10
    AND d.deptno = e.deptno;

-- performing joins with aggregates
SELECT
    *
FROM
    emp_bonus;

SELECT
    deptno,
    sum(DISTINCT sal) AS total_sal,
    sum(bonus) AS total_bonus
FROM (
    SELECT
        e.empno,
        e.ename,
        e.sal,
        e.deptno,
        e.sal * CASE WHEN b.type = 1 THEN .1
        WHEN b.type = 2 THEN .2
        ELSE .3
        END AS bonus
    FROM
        employees e,
        emp_bonus b
    WHERE
        e.empno = b.empno) AS x
GROUP BY
    deptno;

-- alternative version for oracle and sql server
select e.empno, e.ename, 
       sum(distinct e.sal) over (partition by e.deptno) as total_sal,
       e.deptno,
       sum(e.sal * case when b.type = 1 then .1
                        when b.type = 2 then .2
                        else .3 end) over (partition by e.deptno) as total_bonus
        from employees e, emp_bonus b 
        where e.deptno = 10
        ;

-- Performing Outer Joins When Using Aggregates
select deptno, sum(distinct sal) as total_sal, sum(bonus) as total_bonus
from (
    select e.empno, e.ename, e.sal, e.deptno,
    e.sal * case when b.type = 1 then .1
                 when b.type = 2 then .2
                 else .3 end as bonus
    from employees e LEFT OUTER join emp_bonus b
    on (e.empno = b.empno)
    ) as x
    group by deptno;

-- Using Coalesce for comparing null values
select
	ename,
	comm
from
	employees e
where
	coalesce(comm ,
	0) < (
	select
		comm
	from
		employees e2
	where
		ename = 'WARD'
);
