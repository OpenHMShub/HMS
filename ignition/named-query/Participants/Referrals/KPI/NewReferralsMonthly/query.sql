SELECT 
	---[organization].[ApplicantStatus].id
	MONTH([participant].[Referral].timeCreated) as 'referral_month'
FROM 
	[participant].[Referral]
WHERE 
	[participant].[Referral].ParticipantId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))