SELECT 
	G.id,
	G.volunteerGroupName as "Name", 
	Count(staff.Volunteer.volunteerGroupId) as "MemberCount",
	G.timeCreated,
	G.volunteerGroupDescription as "description",
	isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE()
	GROUP BY IV.groupID
	HAVING IV.groupID= G.id
	),0) as "TotalHours",
	isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE() and I.startDate > DATEADD(month, -12, GETDATE())
	GROUP BY IV.groupID
	HAVING IV.groupID= G.id
	),0) as "YTDHours",
	isNull((
	SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
	from calendar.eventInstanceVolunteers IV
	left join calendar.eventInstances I on I.instanceID = IV.instanceID
	WHERE I.startDate < GETDATE() and I.startDate > DATEADD(month, -1, GETDATE())
	GROUP BY IV.groupID
	HAVING IV.groupID= G.id
	),0) as "MTDHours"
FROM staff.volunteerGroup G
Left join staff.Volunteer on G.id = staff.Volunteer.volunteerGroupId
Group by G.volunteerGroupName, G.id, G.timeCreated, G.volunteerGroupDescription
Having G.id = :groupId