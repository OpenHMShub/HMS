WITH v as (SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "Name", 
H.phone as "Phone Number",
H.email as Email, 
H.dob as "dob", 
V.id,
H.id as humanId,
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	left join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.volunteerID = V.id and E.startDate > GETDATE() ORDER BY E.startDate ASC
) as "nextServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	left join calendar.Tasks T on T.taskId = IV.taskID
	left join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.volunteerID = V.id and I.startDate > GETDATE() ORDER BY I.startDate ASC
) as "nextAssignment",
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	left join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.volunteerID = V.id and E.startDate < GETDATE() ORDER BY E.startDate DESC
) as "lastServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	left join calendar.Tasks T on T.taskId = IV.taskID
	left join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.volunteerID = V.id and I.startDate < GETDATE() ORDER BY I.startDate DESC
) as "lastAssignment",
isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE() and I.startDate > DATEADD(month, -6, GETDATE())
	GROUP BY IV.volunteerID
	HAVING IV.volunteerID = V.id
),0) as "hoursPastSixMonths"
FROM staff.Volunteer V
Inner join humans.Human H on V.humanId = H.id
WHERE V.timeRetired is null)
SELECT *
FROM v
where Name LIKE '%' + :search + '%' and V.id in (select DISTINCT IV.volunteerID
from calendar.eventInstanceVolunteers IV
left join calendar.eventInstances I on I.instanceID = IV.instanceID
left join calendar.eventInstanceFacilitators EIF on EIF.instanceID = I.instanceID
left join calendar.CalendarEvents C on C.eventID = I.parentEventID
left join calendar.eventFacilitators EF on EF.eventID = C.eventID 
where I.startDate > GETDATE() and (EIF.facilitatorID = :id or EF.facilitatorID = :id))
ORDER BY nextServiceDate DESC, lastServiceDate DESC;