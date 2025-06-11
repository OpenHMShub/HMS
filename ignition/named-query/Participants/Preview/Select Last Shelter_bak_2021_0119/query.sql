/*---Participants/Preview/Select Last Shelter---*/
Declare @participantID as int = :participantID;

SELECT TOP 1
	[organization].[Congregation].programs
,	[shelter].[Schedule].scheduleBegin
,	[shelter].[Schedule].scheduleEnd
,	[shelter].[Location].locationName
,	[shelter].[Location].street
,	[shelter].[Location].city
,	[shelter].[Location].state
,	[shelter].[Location].zipCode
FROM [participant].[Participant]
LEFT JOIN [shelter].[ScheduleParticipant]
ON [participant].[Participant].id = [shelter].[ScheduleParticipant].participantId
LEFT JOIN [shelter].[Schedule]
ON [shelter].[ScheduleParticipant].scheduleId = [shelter].[Schedule].id
LEFT JOIN [shelter].[Location]
ON [shelter].[Schedule].locationId = [shelter].[Location].id
LEFT JOIN [organization].[Congregation]
ON [shelter].[Location].congregationId = [organization].[Congregation].id
WHERE [participant].[participant].id = @participantID
AND [participant].[Participant].timeRetired is null
AND [shelter].[ScheduleParticipant].timeRetired is null
AND [shelter].[Schedule].timeRetired is null 
AND [shelter].[Location].timeRetired is null
AND [organization].[Congregation].timeRetired is null
AND [shelter].[Schedule].scheduleBegin < GETDATE()
ORDER BY [shelter].[Schedule].scheduleBegin desc, [shelter].[Schedule].scheduleEnd desc