/*KPI1 Participants/Dashboard/TotalServicesYearToDate*/
SELECT 
	[participant].[services].id
FROM 
	[participant].[services]
WHERE 
	[participant].[services].participantId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND
	[participant].[services].timeCreated >= :thisYear