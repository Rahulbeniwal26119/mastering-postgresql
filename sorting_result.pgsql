-- Order by for sorting the results
SELECT
    *
FROM
    employees em
ORDER BY
    ename DESC,
    sal DESC;

-- substr(string_expression, start_index, num_of_chars)
SELECT
    job,
    substr(job, length(job) - 2)
FROM
    employees;

-- Order by last two characters
SELECT
    ename,
    job
FROM
    employees
ORDER BY
    substr(job, length(job) - 1, 2);

CREATE VIEW V AS
SELECT
    ename || ' ' || deptno AS data
FROM
    employees;

-- Sorting by the dept number in data in View V
-- translate(string_expression, match_string, replace_string) -> EG : translate('12345', '123', 'abc') -> abc45
-- replace(string_expression, match_string, replace_string) -> EG : replace('12345', '12', 'abc') -> abc345
SELECT
    data
FROM
    V
ORDER BY
    replace(data, replace(translate(data, '0123456789', '##########'), '#', ''), '');

-- Dealing with nulls while sorting
SELECT
    ename,
    sal,
    comm,
    CASE WHEN comm IS NULL THEN
        0
    ELSE
        1
    END AS is_null
FROM
    employees;

SELECT
    ename,
    sal,
    comm
FROM (
    SELECT
        ename,
        sal,
        comm,
        CASE WHEN comm IS NULL THEN
            0
        ELSE
            1
        END AS is_null
    FROM
        employees) x
ORDER BY
    is_null DESC,
    comm;

-- 1	TURNER	1500	0
-- 2	ALLEN	1600	300
-- 3	WARD	1250	500
-- 4	KING	5000	1400
-- 5	SMITH	800	    null
-- 6	MARTIN	2850	null
-- 7	ADAMS	1100	null
-- 8	JAMES	950  	null
-- 9	FORD	3000	null
-- 10	MILLER	1300	null
-- 11	SCOTT	3000	null
-- 12	BLAKE	2850	null
-- 13	CLARK	2450	null
-- 14	JONES	2975	null
-- Conditional Sorting
SELECT
    ename,
    sal,
    job,
    comm
FROM
    employees
ORDER BY
    CASE WHEN job ILIKE 'Salesman' THEN
        comm
    ELSE
        sal
    END;

