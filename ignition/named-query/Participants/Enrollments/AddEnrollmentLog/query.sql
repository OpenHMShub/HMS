INSERT INTO participant.ProgramLog (participantId, programId, action, actionDate, userName)
     VALUES( :participantId,  :programId,  :action, CURRENT_TIMESTAMP,  :userName )