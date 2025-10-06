SELECT 
	[Human].[id], 
	[Human].[firstName],
	[Human].[middleName],
	[Human].[lastName], 
	[Gender].[genderName],
	[Human].[dob], 
	DATEDIFF(year,[Human].[dob],GETDATE()) AS [age],
	[Human].[phone],
	[Human].[email], 
	[Human].[employer],
	[Human].[school],
	[Human].[street],
	[Human].[city],
	[Human].[state],
	[Human].[zipCode],
	(
        SELECT L.locationName
        FROM shelter.location L
        WHERE L.id = [Human].[congregationId]
    ) AS congregation, --[Human].[congregation],
	[Human].[employer],
	[Human].[school],
	
	isNull((
		SELECT isnull(sum(DATEDIFF(hour, I.startDate, I.endDate)),0)
		from calendar.eventInstanceVolunteers IV
		left join calendar.eventInstances I on I.instanceID = IV.instanceID
		WHERE I.startDate < GETDATE()
		GROUP BY IV.volunteerID
		HAVING IV.volunteerID = :volunteerId --[Volunteer].[id]
	),0) as "hours",
	[VolunteerGroup].[volunteerGroupName]
FROM [staff].[Volunteer]
	INNER JOIN [humans].[Human]  on [Volunteer].[humanId] = [Human].[id]
	LEFT JOIN [staff].[VolunteerGroup] on [VolunteerGroup].[id] = [Volunteer].[volunteerGroupId]
	LEFT JOIN [humans].[Gender] ON [Gender].[id] = [Human].[genderId]
WHERE [Volunteer].[humanId] = :volunteerId --WHERE [Volunteer].[id] = : volunteerId