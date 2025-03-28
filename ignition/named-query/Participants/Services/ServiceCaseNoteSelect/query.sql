SELECT
	[participant].[CaseNotesServices].CaseNotesId as 'note_id'
FROM
	[participant].[CaseNotesServices]
WHERE
	[participant].[CaseNotesServices].ServicesId  =  :service_id 