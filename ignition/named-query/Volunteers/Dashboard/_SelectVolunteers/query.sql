---Volunteers/Dashboard/Select Volunteers---
WITH v as (SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "Name", 
H.phone as "Phone Number",
H.email as Email, 
H.dob as "dob", 
V.id,
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	inner join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.volunteerID = V.id and E.startDate > GETDATE() ORDER BY E.startDate ASC
) as "nextServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	inner join calendar.eventInstances I on I.instanceID = IV.instanceID
	inner join calendar.Tasks T on T.taskId = IV.taskID
	inner join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.volunteerID = V.id and I.startDate > GETDATE() ORDER BY I.startDate ASC
) as "nextAssignment",
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	inner join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.volunteerID = V.id and E.startDate < GETDATE() ORDER BY E.startDate DESC
) as "lastServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	inner join calendar.eventInstances I on I.instanceID = IV.instanceID
	inner join calendar.Tasks T on T.taskId = IV.taskID
	inner join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.volunteerID = V.id and I.startDate < GETDATE() ORDER BY I.startDate DESC
) as "lastAssignment",
isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	inner join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE() and I.startDate > DATEADD(month, -6, GETDATE()) and IV.validation = 1
	GROUP BY IV.volunteerID
	HAVING IV.volunteerID = V.id
),0) as "hoursPastSixMonths"
FROM staff.Volunteer V
Inner join humans.Human H on H.id = V.humanId 
WHERE V.timeRetired is null)
SELECT *
FROM v
where Name LIKE '%' + :search + '%';