Insert INTO  participant.ReferralStatus 
	 (
	 ReferralStatusName,
	 timeCreated
	 ) 
VALUES
 	(
 	:name,
 	GetDate()
 	)