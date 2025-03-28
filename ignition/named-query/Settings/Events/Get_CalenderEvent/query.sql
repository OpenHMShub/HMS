SELECT
	id, 
	name, 
	startDate, 
	EndDate,
	ISNULL(description,'') as 'description',
	duration
FROM 
	calendar.CalendarEvents
WHERE
	{dateRange}
AND
	name like {searchText}
--	startDate BETWEEN :startDate AND :endDate
--AND
--	EndDate BETWEEN :startDate AND :endDate  CONVERT(varchar,@Existingdate,100)
--	startDate >= '2022-03-01' AND EndDate <= '2022-03-31'
	--AND EndDate BETWEEN '2022-03-31' AND '2022-09-15'
	