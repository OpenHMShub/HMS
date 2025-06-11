---Participants/Preview/Select Last Case Note---
Declare @participantID as int = :participantID;

SELECT top 1
  [participant].[CaseNotes].id,
  [participant].[CaseNotes].userName as 'user',
  [participant].[CaseNotes].Note as 'case_note', 
  [participant].[CaseNotes].timeCreated as 'time_created'

FROM [participant].[CaseNotes]
INNER JOIN [participant].[Participant]
ON [participant].[CaseNotes].participantId = [participant].[participant].id

WHERE [participant].[participant].id = @participantID

ORDER BY [participant].[CaseNotes].timeCreated desc