Insert INTO  participant.ReferralType 
	 (
	 ReferralTypeName,
	 timeCreated
	 ) 
VALUES
 	(
 	:name,
 	GetDate()
 	)