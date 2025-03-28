Update [participant].Participant 
Set
    caseManagerId = :case_manager_id,
    timeRetired  = :time_retired,
    timeRegistered = GetDate() 
WHERE id = :participant_id;
