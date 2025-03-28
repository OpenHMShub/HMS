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
	s.nickName,
	s.ssn,
	s.employeeId,
	s.employeeName,
	s.programId,
	s.programName,
	s.ServiceTypeId,
	s.serviceId,
	s.serviceName,
	s.serviceDate,
	s.HMIS,
	s.quantity,
	s.comment,
	s.noteId,
	s.GenderId,
	s.genderName,
	p.veteranId,
	p.veteran,
	s.ServiceLocationId,
	COALESCE(s.serviceLocation,'') as serviceLocation

FROM
	participant.ServicesDashboard s
	LEFT JOIN
		(select id, veteranId, veteran from participant.Dashboard) p ON s.participantId = p.id

WHERE
 	{datefilter} AND
 	{serviceDate} AND
 	{HMIS} AND
 	{employeeId} AND
 	{programId} AND
 	{serviceId} AND
 	{firstName} AND
 	{middleName} AND
 	{lastName} AND
 	{nickName} AND
 	{search} AND
 	{serviceLocation} AND
 	{veteran} AND
 	 {genderId} 
ORDER BY s.serviceDate DESC