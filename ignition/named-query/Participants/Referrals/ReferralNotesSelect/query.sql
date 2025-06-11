/*Participants/Dashboard/ReferralNotesSelect*/
SELECT 
	r.id as 'note_id',
	r.ReferralStatus_ID as 'status_id',
	rs.ReferralStatusName as 'status_name',
	r.ReferralType_ID as 'type_id',
	rt.ReferralTypeName as 'type_name',
	r.timeCreated as 'time_created',
	r.comment as 'comment'
FROM 
	[participant].[ReferralLog] r
	LEFT JOIN  [participant].[ReferralStatus] rs on r.ReferralStatus_ID  = rs.id
	LEFT JOIN  [participant].[ReferralType] rt on r.ReferralType_ID  = rt.id
WHERE
	r.ReferralId = :referral_id 
ORDER BY time_created ASC;