DELETE FROM [participant].[Enrollments] 
WHERE particpantId = :participantId and programId = :programId 


UPDATE [participant].[ProgramsHistory]
SET ExitDate = GETDATE()
WHERE ParticipantID = :participantId AND ProgramID = :programId AND ExitDate IS NULL
