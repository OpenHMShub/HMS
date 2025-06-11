/*Type---Provider/Preview/LastReferral*/

DECLARE @ProviderId AS nvarchar(max) = :trackID

SELECT TOP(1)
	[participant].[ReferralType].ReferralTypeName
FROM 
	[participant].[ReferralType]
INNER JOIN
	[participant].[Referral]
ON
	[participant].[Referral].Type_Id=[participant].[ReferralType].id
WHERE 
	[participant].[Referral].ProviderId= @ProviderId
ORDER BY
	[participant].[Referral].timeCreated
DESC
