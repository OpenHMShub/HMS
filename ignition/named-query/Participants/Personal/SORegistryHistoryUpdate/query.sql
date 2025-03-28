---Update the new chronic homeless date--
UPDATE participant.SORegistryHistory
SET soRegistryDate =  :so_registryDateNew 
WHERE ParticipantID =  :participant_id AND soRegistryDate =  :so_registryDateOld