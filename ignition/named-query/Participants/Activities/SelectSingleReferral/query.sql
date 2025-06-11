/*---Participants/Activities/SelectSingleCaseNote---*/
Declare @ReferralID int = :referral_id ;

SELECT
	prov.providerName as 'provider'
,	r_type.ReferralTypeName as 'type'
, 	r_status.ReferralStatusName as 'status'
,	r_log.Comment as 'comment'

FROM 
	[participant].[Referral] r
	
	LEFT JOIN [participant].[ReferralLog] r_log on r.id = r_log.ReferralId
	LEFT JOIN [organization].[Provider] prov on r.providerId = prov.id
	LEFT JOIN [participant].[ReferralType] r_type on r.Type_id = r_type.id

	
	LEFT JOIN [participant].[ReferralStatus] r_status on r_log.ReferralStatus_ID  = r_status.id

Where r_log.id = @ReferralID
