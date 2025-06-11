declare @schema_name varchar(100)
	,	@table_name varchar(100)
	,	@column_name varchar(100)
	,	@distinct_query nvarchar(500)
	
	set @schema_name = concat('[', replace(:schema, ']', ''), ']')
	set @table_name  = concat('[', replace(:table,  ']', ''), ']')
	set @column_name = concat('[', replace(:column, ']', ''), ']')

	set @distinct_query = concat(
		' select distinct ', @column_name, ' as value '
	,	' from ', @schema_name, '.', @table_name
	,	' order by ', @column_name
	)

execute sp_executesql @distinct_query