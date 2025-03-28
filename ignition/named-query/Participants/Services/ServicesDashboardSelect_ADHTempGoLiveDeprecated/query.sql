---Participants/Services/ServicesDashboardSelect---
DECLARE @activity_range AS INT = :activity_range;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT
	s.rowId,
	s.participantId,
	s.isActive,
	s.name,
	s.firstName,
	s.middleName,
	s.lastName,
	ISNULL(s.nickName,'') as 'nickName',
	s.ssn,
	s.employeeId,
	s.employeeName,
	s.programId,
	s.programName,
	s.ServiceTypeId,
	s.serviceId,
	s.serviceName,
	--s.serviceDate,
	(SELECT [participant].[services].timeCreated FROM [participant].[services] WHERE [participant].[services].id = s.rowId AND [participant].[services].serviceId = s.serviceId) AS 'serviceDate',
	s.HMIS,
	s.quantity,
	s.comment,
	(SELECT [participant].[CaseNotesServices].CaseNotesId
	FROM [participant].[CaseNotesServices] 
	WHERE [participant].[CaseNotesServices].ServicesId  =  s.rowId) as noteId

FROM
	participant.ServicesDashboard s

WHERE
 	s.serviceDate between @activity_start and @activity_end AND
 	{serviceDate} AND
 	{HMIS} AND
 	{employeeId} AND
 	{programId} AND
 	{serviceId} AND
 	{firstName} AND
 	{middleName} AND
 	{lastName} AND
 	{nickName} AND
 	{search} 
ORDER BY s.serviceDate DESC