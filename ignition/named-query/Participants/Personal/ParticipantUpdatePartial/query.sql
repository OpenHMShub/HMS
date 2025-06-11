Update [participant].Participant 
Set
    caseManagerId = :case_manager_id,
    timeRetired  = :time_retired
  
WHERE id = :participant_id;
