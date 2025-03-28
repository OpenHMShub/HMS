DECLARE @assignedStaffId AS INT
DECLARE @AssignedBy AS INT
DECLARE @AssignedDate AS DATETIME

IF NOT EXISTS (
	SELECT 
		[participant].[Enrollments].programId, 
		[participant].[Enrollments].particpantId
	FROM 
		[participant].[Enrollments] 
	WHERE 
		[participant].[Enrollments].programId =:programId AND [participant].[Enrollments].particpantId =:participantId
		)
BEGIN
INSERT INTO [participant].[Enrollments] (particpantID, programId)
VALUES(	:participantId, :programId	);

SELECT TOP 1 @assignedStaffId = assignedStaffId, @AssignedBy = AssignedBy
FROM participant.ProgramsHistory
where AssignedDate IS not null and  AssignedDate >= DATEADD(day, -7, CURRENT_TIMESTAMP) and ParticipantID =  :participantId 
ORDER BY timeCreated desc

if @assignedStaffId IS NULL 
BEGIN
	SET @AssignedDate = NULL
END
INSERT INTO participant.ProgramsHistory(ParticipantID, ProgramID, EntryDate, assignedStaffId ,   AssignedBy , AssignedDate )
VALUES (:participantId, :programId, GETDATE(), @assignedStaffId, @AssignedBy, @AssignedDate) 
END

