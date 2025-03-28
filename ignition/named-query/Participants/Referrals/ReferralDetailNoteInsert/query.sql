INSERT INTO [participant].[ReferralLog]
	(
	 Comment,
	 ReferralId,
	 ReferralStatus_ID,
	 ReferralType_ID,
	 timeCreated, 
	 userName 
	 )
VALUES
	(
	 :comment,
	 :referral_id, 
	 :status_id,
	 :type_id, 
	 :time_created,  
	 :user_name 
	) 