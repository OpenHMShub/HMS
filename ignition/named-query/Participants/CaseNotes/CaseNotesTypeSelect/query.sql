---Participants/CaseNotes/CaseNotesTypeSelect---
SELECT
	[participant].[CaseNoteType].id,[participant].[CaseNoteType].CaseNoteTypeName 
FROM
	[participant].[CaseNoteType] 
WHERE [participant].[CaseNoteType].CaseNoteTypeName NOT LIKE 'Other'
	ORDER BY [participant].[CaseNoteType].CaseNoteTypeName 