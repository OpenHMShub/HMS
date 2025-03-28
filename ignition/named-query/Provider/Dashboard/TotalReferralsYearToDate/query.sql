/*KPI2---Provider/Dashboard/TotalReferralsYearToDate*/
SELECT 
	[participant].[Referral].ProviderId
FROM 
	[participant].[Referral]
WHERE 
	[participant].[Referral].ProviderId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND
	[participant].[Referral].timeCreated >= :thisYear