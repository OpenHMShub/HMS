---Participants/Preview/Select Last Service---
Declare @participantID as int = :participantID;

SELECT top 1
  [participant].[Services].id,
  [participant].[Services].userName as 'user',
  [interaction].[service].serviceName AS 'service_name',
  [participant].[Services].timeCreated as 'time_created'

FROM [participant].[services]

INNER JOIN [participant].[Participant]
ON [participant].[Services].participantId = [participant].[participant].id

INNER JOIN [interaction].[service]
ON [participant].[services].Serviceid = [interaction].[service].id


WHERE [participant].[participant].id = @participantID

ORDER BY [participant].[Services].timeCreated desc