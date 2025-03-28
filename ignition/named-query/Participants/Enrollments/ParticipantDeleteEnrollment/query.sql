DECLARE @participantID INT;
DECLARE @programID INT;
IF EXISTS(
	SELECT 
		id 
	FROM 
		[participant].[Enrollments] 
	WHERE 
		id = :enrollmentId)
BEGIN
SELECT @participantID=particpantId , @programID=programId
FROM [participant].[Enrollments] 
	WHERE 
		id = :enrollmentId

DELETE FROM 
		[participant].[Enrollments] 
	WHERE 
		id = :enrollmentId


UPDATE [participant].[ProgramsHistory]
SET ExitDate = GETDATE()
WHERE ParticipantID = @participantID AND ProgramID =  @programID AND ExitDate IS NULL
END