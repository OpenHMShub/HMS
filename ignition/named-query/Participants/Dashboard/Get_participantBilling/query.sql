	(SELECT 1 as id, 'Everyone' as label, 'Everyone' as value)
Union
	(SELECT 2 as id,
		case when programName = 'Veterans Hospital to Housing' then 'GPD H2H'
			when programName = 'Veterans Low Demand' then 'GPD LD'
			when programName = 'Veterans Service Intensive' then 'GPD SI'
			else  programName end as 'label'
		,programName as value
	FROM
		[interaction].[Program]
	WHERE
	 	timeRetired IS NULL
	 	AND programName in ('ARP','Veterans Hospital to Housing','Veterans Low Demand','Veterans Service Intensive')	 	
	GROUP BY id,programName
	)
UNION
	(select 3 as id, 'Any GPD' as label,'Any GPD' as value)