---Participants/Enrollments/ParticipantEnrollments---

SELECT 
	programName, id
FROM 
	[interaction].[Program]
WHERE 
	{SearchQuery} 
	AND timeRetired IS NULL
ORDER BY 
	programName