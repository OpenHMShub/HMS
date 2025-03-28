---Participants/Enrollments/ParticipantSelectedEnrollments---
SELECT 
	[participant].[Enrollments].id, 
	[interaction].[Program].programName,
	[participant].[Enrollments].programId
FROM 
	[participant].[Enrollments]
INNER JOIN 
	[interaction].[Program] 
ON 
	[participant].[Enrollments].programId=[interaction].[Program].id
WHERE 
	particpantId =:participantId
ORDER BY 
	programName