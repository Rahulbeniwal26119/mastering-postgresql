-- Walking a String

select
	substring(e.ename,
	it.pos::int,
	1) as C
from
	(
	select
		ename
	from
		employees e
	where
		ename = 'KING') e,
	(
	select
		id as pos
	from
		index_table) it
where
	it.pos <= length(e.ename);

select
	substring(e.ename,
	iter.pos::int) a,
	   substring(e.ename,
	length(e.ename) - iter.pos::int) b
from
	(
	select
		ename
	from
		employees e
	where
		ename = 'KING') e,
	(
	select
		id as pos
	from
		index_table) iter
where
	iter.pos <= length(e.ename);


-- Using Quotes in SQL
-- Embedding Quotes Within String Literals

select
	'g''day mate'
union all
select
	'beavers'' teeth'
union all
select
	'''';

select
	'apples core',
	'apple''s core',
	   'case when ''is null then 0 else 1 end
from t1';

-- Counting Occurance
-- Counting Occurance

select (length('10,CLARK,MANAGER') - 
		length(replace('10,CLARK,MANAGER', ',', ''))) / 
		length(',');

-- Removing Unwanted characters from a string
select
	ename,
	replace(translate(ename,
	'AEIOU',
	'a'),
	'a',
	'') as consonants,
	   sal,
	replace(cast(sal as char(5)),
	'0',
	'') as non_zero_sal
from
	employees e;

-- Separting numeric and character data

select 
	replace(
		translate(data, '0123456789', '0'), '0', ''
		) as name,
	cast(
		replace(
			translate(
				lower(data), 'abcdefghijklmnopqrstuvwxyz', 'a'
			),
			'a', 
			'') as integer
		) as sal
from (
	select ename || sal as data from employees e 
) x;

-- Shorting Name to full form
select replace(replace(
	translate(
		replace('Rahul Beniwal', '.', ''), 
				'abcdefghijklmnopqrstuvwxyz', 
				rpad('#', 26, '#')), '#', ''), ' ', '.') || '.'; 


-- Ordering by a number in a String

create view V4 as
select
	e.ename || ' ' || cast(e.empno as char(4)) || ' ' || d.dname as data
from
	employees e,
	departments d
where
	e.deptno = d.deptno;

select data from V4 order by	
	cast(
		replace(
			translate(
				data,
				replace(translate(data, '0123456789', '##########'), '#', ''),
				'#'), '#', '') as integer
	);

-- Another way if getting error
select
	data
from
	(
	select
		case
			when num = ''
			or num is null
	then 0
			else 
	cast(num as integer)
		end as sort,
		data
	from
		(
		select
			replace(translate(
	data,
			replace(translate(data,
			'0123456789',
			'###########'),
			'#',
			''),
			repeat('#',
			length(data))),
			'#',
			'') as num,
			data
		from
			VVV
) x 
) y
order by
	sort desc;
-- Data

-- BLAKE
-- MILLER
-- CLARK, $1826.00
-- KING, $1826.00
-- JAMES, $1642.00
-- SCOTT, $1642.00
-- SMITH, $1642.00
-- FORD, $1642.00
-- ADAMS, $1642.00
-- JONES, $1642.00
-- TURNER, $1822.00
-- MARTIN, $1822.00
-- WARD, $1822.00
-- ALLEN, $1822.00
-- BLAKE, $1822.00
-- MILLER, $1001.00
-- CLARK10
-- KING10
-- JAMES20
-- Creating a delimited list from table rows

select
	deptno,
	string_agg(ename,
	','
order by
	ename) as concatanated_names
from
	employees e
group by
	deptno ;

-- treating string of numbers like list of numbers
select
	ename,
	sal,
	deptno,
	empno
from
	employees e
where
	empno in (
	select
		cast(empno as integer) as empno
	from
		(
		select
			split_part(list.vals, ',', iter.pos::int) as empno
		from
			(
			select
				id as pos
			from
				index_table) iter,
			( select '7654,7698,7782,7788' || ',' as vals) list
		where
			iter.pos <= length(list.vals) - length(replace(list.vals, ',', ''))) z
	where
		length(empno) > 0
);

select split_part('7654,7698,7782,7788', ',', 2); -- 7698

-- Alphabetizing a String
select
	ename,
	string_agg(c, '' order by c)
from
	(
	select
		a.ename,
		substring(a.ename, iter.pos::int, 1) as c
	from
		employees a,
		(
		select
			id as pos
		from
			index_table it ) iter
	where
		iter.pos <= length(a.ename)
	order by
		1,
		2
) x
group by
	ename;

-- ADAMS	AADMS
-- ALLEN	AELLN
-- BLAKE	ABEKL
-- CLARK	ACKLR
-- FORD	DFOR
-- JAMES	AEJMS
-- JONES	EJNOS
-- KING	GIKN

-- Identifying String that can be treated as Number

create view V as (
	select replace(mixed, ',', '') as data
	from (
		select substring(ename , 1, 2) ||
		cast(deptno as char(4)) ||
		substring(ename, 3, 2) as mixed
		from employees e 
		where deptno = 10
		union all 
		select cast(empno as char(4)) as mixed
		from employees e 
		where deptno = 20
		union all
		select ename as mixed
		from employees e 
		where deptno = 30
	) x	
);

-- CL10AR
-- KI10NG
-- MI10LL
-- 7900
-- 7788
-- 7369
-- 7902
-- 7876
-- 7566
-- TURNER
-- MARTIN

select cast(
	case 
		when replace(translate(data, '0123456789', '9999999999'), '9', '') is not null 
		then replace(translate(
						data, 
						replace(translate(data, '0123456789', '9999999999'), '9', ''),
						rpad('#', length(data), '#')), '#', '')
	end as integer) as mixed
from V
where strpos(translate(data, '0123456789','9999999999'), '9') > 0;

-- Extracting nth delimited SubString

create view V as
select 'mo,larry,curly' as name
union all
select 'tina,gina,jaunita,regina,leena' as name;


select name from (
	select iter.pos, split_part(src.name, ',', iter.pos::int) as name
	from (select id as pos from index_table it) iter,
		 (select cast(name as text) as name from V) src
	where iter.pos < length(src.name) - length(replace(src.name, ',', '')) + 1
) x
where pos = 2;

-- Parsing an IP Address

select 
	split_part(y.ip, '.', 1) as A,
	split_part(y.ip, '.', 2) as B,
	split_part(y.ip, '.', 3) as C,
	split_part(y.ip, '.', 4) as D 
from (select cast('192.168.43.12' as text) as ip) as y;

-- Comparing String by Sound
select * from pg_extension;
create extension fuzzystrmatch;

select
	e.ename,
	e2.ename
from
	employees e
join employees e2 on
	e.empno = e2.empno
where
	soundex(e.ename) = soundex(e2.ename)
	and e.ename not like e2.ename;

-- Finding Text not matching a Pattern

create table employee_comment (emp_id int, text varchar(300));

insert into employee_comment (emp_id, text) values (7782, '126 Varnum, Edmore MI 48829, 989 313-5351'), (7839, '1105 McConnell Court
Cedar Lake MI 48812
Home: 989-387-4321
Cell: (237) 438-3333');

select emp_id, text from employee_comment
where regexp_replace(
		text,
		'[0-9]{3}([-. ])[0-9]{3}\1[0-9]{4}',
		'***'
		) ~
		'[0-9]{3}[-. ][0-9]{3}[-. ][0-9]{4}' ;

-- Starategy is to first replace valid numbers by *** and then compare for string containing valid number but 
-- as we have removed valid ones by then remaining one are invalid but like 3 3 4 where they can be seprated by choice of seprators
