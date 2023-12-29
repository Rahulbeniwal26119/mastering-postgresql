--list tables in a schema

select
	table_name
from
	information_schema.tables
where
	table_schema = 'public'
	and table_type = 'BASE TABLE';

--listing table columns

select
	column_name,
	ordinal_position,
	data_type
from
	information_schema.columns
where
	table_schema = 'public'
	and table_name = 'employees';

-- listing indexed columns for a table

select
	pgi.tablename,
	pgi.indexname
from
	pg_catalog.pg_indexes pgi
where
	pgi.tablename = 'employees'
	and pgi.schemaname = 'public';


--listing constraints on a table

select
	a.table_name,
	a.constraint_name,
	b.column_name,
	a.constraint_type
from
	information_schema.table_constraints a, 
	information_schema.key_column_usage b
where
	a.table_name = 'employees'
	and a.table_schema = 'public'
	and a.table_name = b.table_name
	and a.table_schema = b.table_schema
	and a.constraint_name = b.constraint_name ;


-- Listing foreign key without indexes in a table

select
	fkeys.table_name,
	   fkeys.constraint_name,
	   fkeys.column_name,
	   ind_cols.indexname
from
	(
	select
		a.constraint_schema,
		a.table_name,
		a.constraint_name,
		a.column_name
	from
		information_schema.key_column_usage a,
		information_schema.referential_constraints b
	where
		a.constraint_name = b.constraint_name
		and a.constraint_schema = b.constraint_schema
		and a.constraint_schema = 'public'
		and a.table_name = 'employees'
) fkeys
left join
	(
	select
		a.schemaname,
		a.tablename,
		a.indexname,
		b.column_name
	from
		pg_catalog.pg_indexes a,
		information_schema.columns b
	where
		a.tablename = b.table_name
		and a.schemaname = b.table_schema
	) ind_cols
	on
	(
		fkeys.constraint_schema = ind_cols.schemaname
		and fkeys.table_name = ind_cols.tablename
		and fkeys.column_name = ind_cols.column_name
	)
where
	ind_cols.indexname is null;

