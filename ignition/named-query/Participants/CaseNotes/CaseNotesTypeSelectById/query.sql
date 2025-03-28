SELECT
	[participant].[CaseNoteType].CaseNoteTypeName 
FROM
	[participant].[CaseNoteType] 
WHERE
	[participant].[CaseNoteType].id = :caseNoteTypeId