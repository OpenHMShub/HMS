SELECT COUNT(service_month) as noOfParticipants, service_month
FROM
(
SELECT 
	---[organization].[ApplicantStatus].id
	MONTH([participant].[services].timeCreated) as 'service_month'
FROM 
	[participant].[services]
WHERE 
	[participant].[services].participantId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))