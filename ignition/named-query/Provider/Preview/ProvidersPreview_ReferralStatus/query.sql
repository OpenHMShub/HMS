/*Type---Provider/Preview/LastReferral*/

DECLARE @ProviderId AS nvarchar(max) = :trackID

SELECT TOP(1)
	[participant].[ReferralStatus].ReferralStatusName
FROM 
	[participant].[ReferralStatus]
INNER JOIN
	[participant].[Referral]
ON
	[participant].[Referral].Status_Id = [participant].[ReferralStatus].id
WHERE 
	[participant].[Referral].ProviderId = @ProviderId
ORDER BY
	[participant].[Referral].timeCreated
DESC
