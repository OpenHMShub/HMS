---Participants/CaseNotes/CaseNotesDetailSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT
	[participant].[CaseNotes].id AS 'id',
	[participant].[CaseNotes].employeeId AS 'employee_id',
	CONCAT([humans].[Human].firstName,' ',[humans].[Human].middleName,' ',[humans].[Human].lastName) as 'employee_name',
	[participant].[CaseNotes].HMIS AS 'hmis',
	
	cnt.CaseNoteTypeID as 'note_type_id',
	cnt.CaseNoteTypeName as 'note_type',
	[participant].[CaseNotes].Note as 'note',
	[participant].[CaseNotes].timeCreated as 'time_created',
	[participant].[CaseNotes].startTime,
	[participant].[CaseNotes].endTime,
	[participant].[CaseNotes].notifyStaffId
	-- CASE WHEN [participant].[CaseNotes].noteDate IS NULL THEN [participant].[CaseNotes].timeCreated 
	-- ELSE DATEADD(hh,12,CAST([participant].[CaseNotes].timeCreated as DATETIME)) END AS 'time_created'
FROM
	[participant].[CaseNotes]
	JOIN (
	SELECT ct.CaseNotesId, STRING_AGG(ct.CaseNoteTypeID, ',') as CaseNoteTypeID, STRING_AGG(mct.CaseNoteTypeName, ', ') as CaseNoteTypeName
	FROM 
	[participant].[CaseNotesTypes] ct , [participant].[CaseNoteType] mct
	WHERE  ct.CaseNoteTypeID = mct.id
	AND {notetype} 
	GROUP BY ct.CaseNotesId
	)cnt
	ON [participant].[CaseNotes].id = cnt.CaseNotesId
	LEFT JOIN staff.Employee
	ON [participant].[CaseNotes].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] 
	ON [staff].[Employee].humanId = [humans].[Human].id
WHERE 	
	[participant].[CaseNotes]. participantId =  :participant_id AND
	[participant].[CaseNotes].timeCreated between @activity_start and @activity_end AND
	{notedate} AND
 
 	{hmis} AND
 	{enteredby} AND
 	{search}
ORDER BY time_created DESC