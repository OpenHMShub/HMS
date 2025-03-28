SELECT 
	pd.id as 'participantId' 
	, concat(pd.firstName,case when pd.middleName!='' then ' ' else ''end,pd.middleName,case when pd.lastName!='' then ' ' else ''end,pd.lastName) as 'pname'
	, prog.entryDate, h.lastHmisUpdateDate, prog.staffId, prog.assignerId
	, (select concat(firstName,case when middleName!='' then ' ' else ''end,middleName,case when lastName!='' then ' ' else ''end,lastName) from humans.Human where id = (select humanId from [staff].[Employee] where id =prog.staffId)) as 'staff'
	, (select concat(firstName,case when middleName!='' then ' ' else ''end,middleName,case when lastName!='' then ' ' else ''end,lastName) from humans.Human where id = (select humanId from [staff].[Employee] where id =prog.assignerId)) as 'assigner'
	, (select email from humans.Human where id = (select humanId from [staff].[Employee] where id =prog.staffId)) as 'staffEmail'
FROM 
	participant.Dashboard pd
LEFT JOIN
	(select participantId, min(entryDate) as 'entryDate', min([assignedStaffId]) as 'staffId', min([AssignedBy]) as 'assignerId' from participant.ProgramsHistory group by participantId) prog ON prog.participantId = pd.id
LEFT JOIN 
	[participant].[Participant] p ON pd.id = p.id
LEFT JOIN
	[humans].[Human] h ON p.humanId = h.id
WHERE
	{isVeteran}
	AND pd.id in (select participantId from [lodging].[BedLog] where eventEnd IS NULL)
	AND {dateRange} 