/*Provider/Dashboard/ReferralDashboardSelect*/
DECLARE 
	@dob_start AS DATE = :dob_start
 	,@dob_end AS DATE =  :dob_end 
	,@first_name AS nvarchar(max) = :first_name 
	,@last_name AS nvarchar(max) = :last_name
	,@activity_start AS DATE = :activity_start
	,@activity_end AS DATE = :activity_end
	,@provider_id AS INT = :provider_id
SELECT TOP 100
	r.id as 'id',
	r.ParticipantId as 'participant_id',
	CONCAT_WS(' ',h.firstName, h.middleName, h.lastName) as 'name',
	'***-**-'+RIGHT(h.[ssn],4) as 'ssn',
	h.dob as 'dob',
	r.timeCreated as 'referral_date',
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
WHERE
  	h.firstName like IsNull(@first_name,[FirstName]) + '%'
  	AND h.lastName like IsNull(@last_name,[LastName]) + '%'
  	AND h.dob between @dob_start and @dob_end 
  	AND r.timeCreated between @activity_start and @activity_end
  	AND r.providerId = @provider_id
  ORDER BY referral_date DESC;