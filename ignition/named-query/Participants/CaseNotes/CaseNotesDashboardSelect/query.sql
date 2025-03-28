---Participants/CaseNotes/CaseNotesDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT 
	cn.noteId as note_id
	,cn.participantId as participant_id
	,cn.name as participant_name
	,cn.firstName 
	,cn.middleName
	,cn.lastName 
	,COALESCE(cn.nickName, '') as nick_name
	,cn.ssn
	--,cn.[noteDate]
	,(SELECT timeCreated FROM [participant].[CaseNotes] pcn WHERE pcn.participantId = cn.participantId AND pcn.id = cn.noteId) AS 'time_created'
	,cn.hmis
	,cnt.CaseNoteTypeID as note_type_id
	,cnt.CaseNoteTypeName  as note_type
	,cn.Note as note
	, LEFT(cn.Note , 70) as 'note_trunc'
	,cn.employeeId as employee_id
	,cn.employeeName as employee_name
	, COALESCE(s.serviceName,'') as service_desc
	,cn.startTime
	,cn.endTime
	,p.veteranId , p.veteran,
	cn.notifyStaffId
FROM
	participant.CaseNotesDashboard  cn 
LEFT JOIN
	(select id, veteranId, veteran from participant.Dashboard) p ON cn.participantId = p.id
LEFT JOIN
	(
	SELECT
	
	[participant].[services]. participantId,
	[participant].[CaseNotesServices].CaseNotesId,
	
	STRING_AGG( [interaction].[service].serviceName, ', ') AS 'serviceName'
	
	FROM
		[participant].[services]
		LEFT JOIN [interaction].[program]
		ON [participant].[services].programid = [interaction].[program].id
		LEFT JOIN [interaction].[service]
		ON [participant].[services].Serviceid = [interaction].[service].id
		LEFT JOIN staff.Employee
		ON [participant].[services].employeeId = [staff].[Employee].Id
		LEFT JOIN [humans].[Human] 
		ON [staff].[Employee].humanId = [humans].[Human].id
		LEFT JOIN  [participant].[CaseNotesServices]
		ON [participant].[CaseNotesServices].ServicesId = [participant].[services].id
		WHERE {service}
		GROUP BY [participant].[services]. participantId, [participant].[CaseNotesServices].CaseNotesId	
	) s
	ON s.participantId = cn.participantId and s.CaseNotesId = cn.noteId 
JOIN (
	SELECT ct.CaseNotesId, STRING_AGG(ct.CaseNoteTypeID, ',') as CaseNoteTypeID, STRING_AGG(mct.CaseNoteTypeName, ', ') as CaseNoteTypeName
	FROM 
	[participant].[CaseNotesTypes] ct , [participant].[CaseNoteType] mct
	WHERE  ct.CaseNoteTypeID = mct.id
	AND {notetype} 
	GROUP BY ct.CaseNotesId
	)cnt
	ON cn.noteId = cnt.CaseNotesId
	
WHERE
 	{datefilter} AND
 	{notedate} AND
 	{shelter} AND
 	{hmis} AND
 	{enteredby} AND
 	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{program} AND
 	{veteran} AND
 	{search}

ORDER BY cn.[noteDate] DESC