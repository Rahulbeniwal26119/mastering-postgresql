-- inserting one row 
insert
	into
	departments (deptno,
	dname,
	loc)
values (50,
'PROGRAMMING',
'BALTIMORE');

-- inserting one row (Method 2)
insert
	into
	departments
values (60,
'SALES',
'FLORIDA');

-- Inserting multiple rows at once
insert
	into
	departments
values (70,
'OPS',
'MIAMI'),
(80,
'HIRING',
'HAWAII');select * from employees;

-- Create a new table D with default values in columns
create table D (id integer default 0, name varchar default 'Rahul');

-- Storing all default values
insert into D values (default);

-- Using default values;
insert into D (name) values ('Rahul Beniwal');

-- overriding default with null values
insert into D (id, name) values (null, 'Brighten');


-- ********************************************************** 
-- Inserting multiple rows into one table from existing table
-- **********************************************************

create table departments_east(deptno integer, dname varchar(30));

insert into departments_east (deptno, dname)
select deptno, dname from departments
where loc in ('NEW YORK', 'BOSTON');

select * from public.departments_east;

-- **************************
-- Coping a table definations
-- **************************

create table departments_2
as
select * from departments d 
where 1 = 0;

create table departments_3
as
select * from departments d ;


-- Blocking inserts on certain columns
-- Use or Expose views with those column only

create view new_emp as
select
	empno,
	ename,
	job
from
	employees e ;

insert
	into
	new_emp
(empno,
	ename,
	job)
values (1000,
'JOhn',
'Editor');

select
	*
from
	employees e
where
	empno = 1000;

-- Modifying Records into table
-- increase sal by 10 %
update
	employees
set
	sal = sal * 1.10
where
	deptno = 20;

-- Only update salary if bonus given to people
update
	employees
set
	sal = sal * 1.10
where
	empno in (
	select
		empno
	from
		emp_bonus
	where
		employees.empno = emp_bonus.empno);

-- OR --

update
	employees
set
	sal = sal * 1.10
where
	exists (
	select
		null
	from
		emp_bonus
	where
		employees.empno = emp_bonus.empno
);

-- Updating with value from another table
update employees 
set sal = ns.sal, comm = ns.sal / 2
from new_sal ns
where ns.deptno = employees.deptno ;


-- Merge multiple column or perform insert and update with delete in one query 

merge into emp_commision ec
using (select * from employees) emp
on (ec.empno = emp.empno)
when matched then
	update set ec.comm = 1000
	delete where (sal < 2000)
when not matched then 
	insert (ec.empno, ec.ename, ec.deptno, ec.comm)
	value (emp.empno, emp.ename, emp.deptno, emp.comm);merge into  ec
using (select * from employees) emp
   on (ec.)


-- deleting all data from a table

truncate departments_2 ; -- faster but cannot be rollback and take only write lock while deleting

delete from departments_2 ; -- slower but can be rollback and take access lock while deleting

-- delete specific records

delete from emp_bonus where type = 30;

-- Deleting referential integrity Violations
-- Delete those employees which donot belongs to any departments

delete from employees 
where not exists (
	select null from departments
	where departments.deptno = employees.deptno
);

-- Deleting duplicate records from the table

create table dupes (id integer, name varchar(10));

insert into dupes values (1, 'NAPOLEON');
insert into dupes values (2, 'DYNAMITE');
insert into dupes values (3, 'DYNAMITE');
insert into dupes values (4, 'SHE SELLS');
insert into dupes values (5, 'SEA SHELLS');
insert into dupes values (6, 'SEA SHELLS');
insert into dupes values (7, 'SEA SHELLS');

delete from dupes where id not in (
	select min(id) from ( select id, name from dupes) tmp
	group by name
); 
-- OR --

delete from dupes where id not in (
	select min(id) from dupes
	group by name
);
