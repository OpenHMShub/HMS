---Update the new chronic homeless date--
UPDATE participant.ChronicHomelssHistory
SET chronicHomelessDate =  :chronic_homelessDateNew 
WHERE ParticipantID =  :participant_id AND chronicHomelessDate =  :chronic_homelessDateOld