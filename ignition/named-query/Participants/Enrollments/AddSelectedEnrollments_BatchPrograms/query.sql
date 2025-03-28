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

INSERT INTO participant.ProgramsHistory(ParticipantID, ProgramID, EntryDate, EnteredBy)
VALUES (:participantId, :programId, :timeCreated, :employeeId) 

INSERT INTO participant.ProgramLog (participantId, programId, action, actionDate, userName)
     VALUES( :participantId,  :programId,  'Batch Entry', CURRENT_TIMESTAMP,  :userName )
END

