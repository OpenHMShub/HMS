/*KPI2---Participants/Dashboard/ActiveOverOneYear*/
SELECT 
	[participant].[Participant].id,
	[participant].[services].timeCreated
FROM 
	[participant].[Participant]
INNER JOIN
	[participant].[services]
ON
	[participant].[Participant].id=[participant].[services].participantId
WHERE 
	[participant].[Participant].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND
	[participant].[services].timeCreated >= :oneYearAgo

