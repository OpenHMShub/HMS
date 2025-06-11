---Participants/CaseNotes/CaseNotesDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT 
	cn.noteId 
	,cn.participantId
	,cn.name
	,cn.firstName 
	,cn.middleName
	,cn.lastName 
	,cn.nickName
	,cn.ssn
	,FORMAT(cn.[noteDate], 'd', 'us') AS 'noteDate'
	,cn.hmis
	,cn.CaseNoteTypeID 
	,cn.CaseNoteTypeName 
	,cn.Note 
	,cn.employeeId 
	,cn.employeeName
FROM
	participant.CaseNotesDashboard  cn
	
WHERE
 	cn.noteDate between @activity_start and @activity_end AND
 	{notedate} AND
 	{notetype} AND
 	{hmis} AND
 	{enteredby} AND
 	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{search}

ORDER BY cn.[noteDate] DESC