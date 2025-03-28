/*Participants/Dashboard/ReferralsDetailSelect*/
SELECT distinct
	r.id as 'id',
	r.timeCreated as 'referral_date',
	r.providerId as 'provider_id',
	prov.providerName as 'provider_name',
	p_type.id as 'provider_type_id',
	r.Type_ID as 'type_id',
	r_type.ReferralTypeName as 'referral_type',
	r.Status_Id as 'status_id',
	r_status.ReferralStatusName as 'referral_status',
	r.ProgramId as 'program_id',
	p.programName as 'program_name',
	COALESCE(res.exitDestination, '') as exitDestination,
	r.employee_id as employee_id,
	CASE WHEN r.employee_id IS NULL THEN ''
	ELSE (
	SELECT
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) 
	FROM
	[staff].[Employee]
	INNER JOIN [humans].[Human] on [staff].[Employee].humanId = [humans].[Human].id 
	WHERE [staff].[Employee].timeRetired is NULL AND  [staff].[Employee].id = r.employee_id
	) END AS  'employee_name'
	,r.ReasonForEntry_Id as 'ReasonForEntryId'
	,ISNULL(r_reason.reason,'') as 'ReasonForEntry'
	,ISNULL(r.latestReferralUpdate, r.timeCreated) as 'latestReferralUpdate'
	 
FROM 
	[participant].[Referral] r
	LEFT JOIN [organization].[Provider] prov on r.providerId = prov.id
	LEFT JOIN [organization].[ProviderType] p_type on prov.providerTypeId = p_type.id
	LEFT JOIN [participant].[ReferralType] r_type on r.Type_id = r_type.id
	LEFT JOIN [participant].[ReferralStatus] r_status on r.Status_Id = r_status.id
	LEFT JOIN [interaction].[Program] p on p.id = r.programId 
	LEFT JOIN 
	(
		SELECT distinct res.participantId, res.programId, res.providerId,
		CASE WHEN bl.exitDestinationId IS NOT NULL THEN (SELECT destinationName from lodging.ExitDestination WHERE id = bl.exitDestinationId) ELSE '' 
		END AS exitDestination, res.timeCreated, res.referralId 
		FROM
		lodging.reservation res RIGHT JOIN lodging.bedLog bl ON res.bedId = bl.bedId and res.participantId = bl.participantId and bl.eventStart > res.timeCreated and bl.reservationId = res.id
		WHERE res.reserVationEnd IS NOT NULL 
	) res ON res.participantId = r.ParticipantId AND res.programId = r.ProgramId and res.providerId = r.ProviderId AND (res.referralId is NULL OR  res.referralId = r.id )
	LEFT JOIN [participant].[ReferralReasonForEntry] r_reason on r.ReasonForEntry_Id = r_reason.id
WHERE
	r.ParticipantId =  :participant_id 
ORDER BY referral_date DESC;