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