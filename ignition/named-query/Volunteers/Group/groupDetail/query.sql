SELECT 
    G.volunteerGroupName AS "Name",
    G.volunteerGroupDescription AS "description",
    (
        SELECT COUNT(*) 
        FROM [staff].[Volunteer] MV
        WHERE MV.volunteerGroupId = V.volunteerGroupId
    ) AS "MemberCount",
    
    ISNULL((
        SELECT ISNULL(SUM(DATEDIFF(hour, I.startDate, I.endDate)), 0)
        FROM calendar.eventInstanceVolunteers IV
        LEFT JOIN calendar.eventInstances I 
            ON I.instanceID = IV.instanceID
        JOIN [staff].[Volunteer] TV 
            ON IV.volunteerID = TV.humanId
        WHERE I.startDate < GETDATE()
        GROUP BY TV.volunteerGroupId
        HAVING TV.volunteerGroupId = V.volunteerGroupId
    ), 0) AS "TotalHours",

    ISNULL((
        SELECT ISNULL(SUM(DATEDIFF(hour, I.startDate, I.endDate)), 0)
        FROM calendar.eventInstanceVolunteers IV
        LEFT JOIN calendar.eventInstances I 
            ON I.instanceID = IV.instanceID
        JOIN [staff].[Volunteer] TV 
            ON IV.volunteerID = TV.humanId
        WHERE I.startDate >= DATEFROMPARTS(YEAR(GETDATE()), 1, 1)
          AND I.startDate < GETDATE()
        GROUP BY TV.volunteerGroupId
        HAVING TV.volunteerGroupId = V.volunteerGroupId
    ), 0) AS "YTDHours",

    ISNULL((
        SELECT ISNULL(SUM(DATEDIFF(hour, I.startDate, I.endDate)), 0)
        FROM calendar.eventInstanceVolunteers IV
        LEFT JOIN calendar.eventInstances I 
            ON I.instanceID = IV.instanceID
        JOIN [staff].[Volunteer] TV 
            ON IV.volunteerID = TV.humanId
        WHERE I.startDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
          AND I.startDate < GETDATE()
        GROUP BY TV.volunteerGroupId
        HAVING TV.volunteerGroupId = V.volunteerGroupId
    ), 0) AS "MTDHours"

FROM [staff].[VolunteerGroup] G
JOIN [staff].[Volunteer] V 
    ON V.volunteerGroupId = G.id
   AND V.humanId = :volunteerID;
   

/*SELECT 
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
Having G.id = : groupId*/