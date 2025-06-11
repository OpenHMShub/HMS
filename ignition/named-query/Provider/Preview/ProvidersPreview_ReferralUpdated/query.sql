/*Updated---Provider/Preview/LastReferral*/

DECLARE @ProviderId AS nvarchar(max) = :trackID

SELECT 
	max([participant].[Referral].timeCreated)
FROM 
	[participant].[Referral]
WHERE 
	[participant].[Referral].ProviderId= @ProviderId
