SELECT name as 'eventName' , startsOn, endsOn, repeatDateUntil,
	CASE WHEN repeatDateUntil IS NOT NULL THEN repeatDateUntil ELSE endsOn END AS 'EventEndsDate',
	CASE WHEN repeatDateUntil IS NOT NULL THEN CAST(DATEADD(week, -:alertBeforeWeek, repeatDateUntil) AS DATE) ELSE CAST(DATEADD(week, 2, endsOn) AS DATE) END AS 'DateBeforeWeek',	
	CAST(CURRENT_TIMESTAMP AS DATE) as currentDate
FROM 
	participant.Events
WHERE
	CASE WHEN repeatDateUntil IS NOT NULL THEN CAST(DATEADD(week, -:alertBeforeWeek, repeatDateUntil) AS DATE) 
		ELSE CAST(DATEADD(week, 2, endsOn) AS DATE) END
	= CAST(CURRENT_TIMESTAMP AS DATE)