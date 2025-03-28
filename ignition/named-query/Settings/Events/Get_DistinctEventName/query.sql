--SELECT distinct name FROM calendar.CalendarEvents

SELECT 
	distinct ce.[name] as eventName,
	ISNULL(cep.points,0) as points
FROM 
	[calendar].[CalendarEvents] ce
LEFT JOIN
    [calendar].[CalendarEventsPointCounts] cep
ON 
	ce.name = cep.name
WHERE
	{dateRange}
AND
	ce.[name] like {searchText}