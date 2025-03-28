/*---Participants/Activities/SelectSingleCaseNote---*/
Declare @CaseNoteID int = :CaseNoteID;

SELECT
	CASE WHEN isnull([participant].[CaseNotes].HMIS,0) = 0 THEN 'No' ELSE 'Yes' END as HMIS
,	[participant].[CaseNotes].Note
,	STRING_AGG([interaction].[service].serviceName, ', ') as Services
FROM [participant].[CaseNotes]
Left join [participant].[services]
ON [participant].[CaseNotes].participantId = [participant].[services].participantId
LEFT JOIN [interaction].[program]
ON [participant].[services].programid = [interaction].[program].id
LEFT JOIN [interaction].[service]
ON [participant].[services].Serviceid = [interaction].[service].id
Where [participant].[CaseNotes].id = @CaseNoteID
GROUP BY [participant].[CaseNotes].HMIS, [participant].[CaseNotes].Note