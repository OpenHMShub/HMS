SELECT G.volunteerGroupName as "Name", Count(V.volunteerGroupId) as "Member Count", G.id,
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	left join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.groupID = G.id and E.startDate > GETDATE() ORDER BY E.startDate ASC
) as "nextServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	left join calendar.Tasks T on T.taskId = IV.taskID
	left join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.groupID = G.id and I.startDate > GETDATE() ORDER BY I.startDate ASC
) as "nextAssignment",
(
	SELECT TOP 1 
	cast(E.startDate as date)
	from calendar.eventInstanceVolunteers I 
	left join calendar.eventInstances E on E.instanceID = I.instanceID
	WHERE I.groupID = G.id and E.startDate < GETDATE() ORDER BY E.startDate DESC
) as "lastServiceDate",
(
	SELECT TOP 1 CONCAT(C.title,' - ', T.title) 
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	left join calendar.Tasks T on T.taskId = IV.taskID
	left join calendar.CalendarEvents C on C.eventID = I.parentEventID
	WHERE IV.groupID = G.id and I.startDate < GETDATE() ORDER BY I.startDate DESC
) as "lastAssignment",
(
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE() and I.startDate > DATEADD(month, -6, GETDATE())
	GROUP BY IV.groupID
	HAVING IV.groupID= G.id
) as "hoursPastSixMonths",
(
	SELECT TOP 1 CONCAT(H.firstName,' ',H.middleName,' ',H.lastName)
	FROM staff.Volunteer V
	Inner join humans.Human H on V.humanId = H.id
	WHERE V.volunteerGroupId = G.id and V.isLeader = 1
) as "leader"
FROM staff.volunteerGroup G
Left join staff.Volunteer V on G.id = V.volunteerGroupId
where G.volunteerGroupName LIKE '%' + :search + '%'
Group by G.volunteerGroupName, G.id