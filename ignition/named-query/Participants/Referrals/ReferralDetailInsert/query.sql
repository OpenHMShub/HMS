INSERT INTO [participant].[Referral]
	(
	  ParticipantId,
	  ProviderId,
	  Status_Id,
	  Type_Id,
	  ProgramId,
	  employee_id,
	  timeCreated,
	  ReasonForEntry_Id,
	  latestReferralUpdate
	 )
VALUES
	(
	 :participant_id,  
	 :provider_id,  
	 :status_id,  
	 :type_id,
	 :program_id,
	 :employee_id,
	  :time_created ,
	 :ReasonForEntry_Id,
	  :time_created 
	) 