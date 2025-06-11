/*Participants/Referrals/ReferralsDashboardSelect*/
SELECT TOP 100
	r.id as 'id',
	r.ParticipantId as 'participant_id',
	CONCAT_WS(' ',h.firstName, h.middleName, h.lastName) as 'name',
	'***-**-'+RIGHT(h.[ssn],4) as 'ssn',
	--h.dob as 'dob',
	FORMAT(h.dob, 'd', 'us') AS 'dob',
	--r.timeCreated as 'referral_date',
	FORMAT(r.timeCreated, 'd', 'us') AS 'referral_date',
	CAST((DATEDIFF(day, h.dob, GetDate()))/365.25 as INT) as 'Age',
	r.providerId as 'provider_id',
	prov.providerName as 'provider_name',
	r.Type_ID as 'type_id',
	r_type.ReferralTypeName as 'referral_type',
	r.Status_Id as 'status_id',
	r_status.ReferralStatusName as 'referral_status'

FROM 
	[participant].[Referral] r
	INNER JOIN [participant].[Participant] p on r.[ParticipantId] = p.id
	LEFT JOIN [humans].[Human] h on p.humanId = h.id
	LEFT JOIN [organization].[Provider] prov on r.providerId = prov.id
	LEFT JOIN [participant].[ReferralType] r_type on r.Type_id = r_type.id
	LEFT JOIN [participant].[ReferralStatus] r_status on r.Status_Id = r_status.id

  ORDER BY referral_date DESC;