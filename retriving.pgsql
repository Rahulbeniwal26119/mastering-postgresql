SELECT
    *
FROM
    employees e
WHERE
    e.deptno = 10
    OR e.comm IS NOT NULL
    OR (e.deptno = 20
        AND e.sal <= 2000);

-- Inline VIEW
select * from (
    select sal as salary, comm as commision from employees
    ) x where x.salary < 5000;

-- select sal as salary from employees e where e.salary < 5000;

-- Explaination
-- WHERE clause is evaluated before SELECT clause 
    -- so in first query alias are unknown to be known in first query

-- FROM clause evaluated before WHERE clause
    -- so placing the original query in FROM clause aliases are known to be used with WHERE  

-- CONCATENATION
select 
    ename || ' WORKS AS A ' || job as msg 
from employees 
    where deptno = 10;

-- CASE WHEN

select ename, sal, 
        case when sal <= 2000 then 'UNDERPAID'
            when sal >= 4000 then 'OVERPAID'
            else 'OK'
        end as status 
from employees limit 5;

-- fetching Random rows
select ename, job from employees order by random() limit 5;


-- Transforming NULL into VALUES
select 
    ename, COALESCE(comm, 0) 
from employees 
    order by random() limit 5;

-- Searching for Pattern 
select * from employees where ename ilike '%Jim%';