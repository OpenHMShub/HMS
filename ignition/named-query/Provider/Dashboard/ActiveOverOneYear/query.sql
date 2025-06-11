/*KPI1---Provider/Dashboard/ActiveOverOneYear*/
SELECT 
	[organization].[Provider].id,
	[participant].[Referral].timeCreated
FROM 
	[organization].[Provider]
INNER JOIN
	[participant].[Referral]
ON
	[organization].[Provider].id=[participant].[Referral].ProviderId
WHERE 
	[organization].[Provider].id IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND
	[participant].[Referral].timeCreated >= :oneYearAgo