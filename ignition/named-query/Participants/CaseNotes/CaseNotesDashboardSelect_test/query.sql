---Participants/CaseNotes/CaseNotesDashboardSelect---
SELECT 
	h_participant.id,
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
	LEFT JOIN [participant].[CaseNoteType]
	ON [participant].[CaseNotes].CaseNoteTypeID = [participant].[CaseNoteType].Id
	
	LEFT JOIN [humans].[Human] h_employee
		INNER JOIN [staff].[Employee] staff ON staff.humanId = h_employee.id
	ON [participant].[CaseNotes].employeeId = staff.Id
	
	LEFT JOIN [humans].[Human] h_participant
		INNER JOIN [participant].[Participant] participant ON participant.humanId = h_participant.id
	ON [participant].[CaseNotes].participantId = participant.Id
	
	LEFT JOIN [humans].[SSN] ss
		INNER JOIN [participant].[Participant] participant2 ON participant2.humanId = ss.humanid
	ON [participant].[CaseNotes].participantId = participant2.Id

--ORDER BY time_created DESC