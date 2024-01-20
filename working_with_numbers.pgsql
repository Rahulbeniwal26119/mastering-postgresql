-- Computing an average (For all data)
select
	avg(sal) as avg_sal
from
	employees e ;
-- Computing per deptno average
select
	deptno,
	avg(sal)
from
	employees e
group by
	deptno ;

-- avg will ignore null values but use coalesce for accurate result
select avg(coalesce(sal)) from t2;

-- Finding Min/Max Value in a Column

select
	min(sal),
	max(sal)
from
	employees e ;

-- Finding Min/Max Value in a Column By Dept

select
	deptno,
	min(sal),
	max(sal)
from
	employees e 
group by deptno ;

-- Counting Rows in a Table
---------------------------

select count(*) from employees e ;
-- remove count(*) will count the all rows but if we do like count('comm') then it will all non null comm.

select count(*), count(mgr) from employees e ;
-- 14 12

---------------------------

-- Finding Min/Max Value in a Column By Dept

select
	deptno,
	min(sal),
	max(sal)
from
	employees e 
group by deptno ;

-- Calculating Running Total
select ename, sal, sum(sal) over (order by sal, empno) as running_total
from employees e ;

-- Calculating Running Product
select exp(sum(ln(sal)) over (order by sal, empno)), ln(sal), sal from employees e ;

-- Smoothing a series of values
select
	sal,
	sales_lag_one,
	sales_lag_two,
	(sal + sales_lag_one + sales_lag_two) / 3
from
	(
	select
		sal,
		lag(sal,
		1) over (
		order by empno) as sales_lag_one,
		lag(sal,
		2) over (
		order by empno) as sales_lag_two
	from
		employees e 
		) x;

-- calculating Mode
select sal from (
	select sal, cnt, dense_rank() over (order by cnt desc) as rank
from
	(
	select sal, count(1) as cnt from employees e 
	group by sal
) X
) Y
where rank = 1;

-- Calculating Median

select percentile_cont(0.5) within group (order by sal) from employees e;

-- Determining percentage of the total
select (
	sum(
		case 
			when deptno = 10 then sal
		end
	) * 100 / sum(sal)
) from employees e ;

-- Alternative Approach
select
	distinct deptno,
	deptsum,
	total_sum,
	deptsum * 100 / total_sum
from
	(
	select
		sal,
		deptno,
		sum(sal) over(partition by deptno) deptsum,
		sum(sal) over () total_sum
	from
		employees e) X
where
	deptno = 10;
	
-- Aggregating Null Columns
select avg(coalesce(comm, 0)) as avg_com from employees e ;