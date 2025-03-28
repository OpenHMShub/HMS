---Participants/Enrollments/ParticipantEnrollments---

SELECT 
	programName, id
FROM 
	[interaction].[Program]
WHERE 
	{SearchQuery} 
	AND programName in ('Campus Store' ,'Hope University','Guest House','Paticipant Mail Service')
	AND timeRetired IS NULL
ORDER BY 
	programName