/*KPI4----Participants/Dashboard/CurrentSuspensions*/
SELECT 
	[participant].[Suspension].id
FROM 
	[participant].[Participant]
INNER JOIN
	[participant].[Suspension]
ON
	[participant].[Participant].id=[participant].[Suspension].participantId
WHERE 
	[participant].[Participant].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND
	--getDATE() BETWEEN [participant].[Suspension].dateBegin AND ISNULL([participant].[Suspension].dateEnd,DATEADD(d,365,[participant].[Suspension].dateBegin));
	[participant].[Suspension].dateBegin > DATEADD(d,-1*:days,GetDate())
