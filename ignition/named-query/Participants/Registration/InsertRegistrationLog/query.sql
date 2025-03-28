Insert into participant.RegistrationLog 
(participantId, actionDate, actionBy, action, actionFields, userName) 
VALUES 
(:participantId, GetDate(),:staffEmployeeId,:action, :actionFields, :userName)
