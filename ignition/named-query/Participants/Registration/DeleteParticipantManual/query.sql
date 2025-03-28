---Participants/Registration/DeleteParticipantManual---
Delete from  participant.Enrollments WHERE  particpantId  =  :participant_id 

Delete from participant.Participant WHERE  humanId =  :human_id 

Delete from  humans.SSN WHERE humanId =  :human_id 

Delete from humans.Human WHERE  id =  :human_id 