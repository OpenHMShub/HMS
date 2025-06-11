---Participants/CaseNotes/CaseNotesDashboardSelect---
SELECT
	[participant].[CaseNotes].participantId AS 'participant_id',
	CONCAT_WS(' ',h_participant.firstName, h_participant.middleName, h_participant.lastName) as 'participant_name',
	[participant].[CaseNotes].id AS 'note_id',
	[participant].[CaseNotes].HMIS AS 'hmis',
	[participant].[CaseNotes].CaseNoteTypeID as 'note_type_id',
	[participant].[CaseNoteType].CaseNoteTypeName as 'note_type',
	[participant].[CaseNotes].Note as 'note',
	[participant].[CaseNotes].timeCreated AS 'time_created',
	'***-**-'+RIGHT(ss.[ssn],4) as 'ssn',
	[participant].[CaseNotes].employeeId AS 'employee_id',
	CONCAT(h_employee.firstName,' ',h_employee.middleName,' ',h_employee.lastName) as 'employee_name'
FROM
	[participant].[CaseNotes]
	INNER JOIN [participant].[Participant] p
	ON [participant].[CaseNotes].[participantId] = p.id
	LEFT JOIN [participant].[CaseNoteType]
	ON [participant].[CaseNotes].CaseNoteTypeID = [participant].[CaseNoteType].Id
	LEFT JOIN [humans].[Human] h_participant
	ON p.humanId = h_participant.id
	LEFT JOIN [humans].[SSN] ss 
	ON h_participant.[id] = ss.[humanId]
	LEFT JOIN staff.Employee
	ON [participant].[CaseNotes].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] h_employee
	ON [staff].[Employee].humanId = h_employee.id
ORDER BY time_created DESC