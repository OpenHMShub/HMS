SELECT 
    G.volunteerGroupName,
    G.volunteerGroupDescription,
    FORMAT(G.timeCreated, 'yyyy-MM-dd HH:mm:ss') AS timeCreated,
    FORMAT(G.timeRetired, 'yyyy-MM-dd HH:mm:ss') AS timeRetired
FROM [staff].[VolunteerGroup] G
JOIN [staff].[Volunteer] V 
    ON V.volunteerGroupId = G.id AND V.humanId = :volunteerID

