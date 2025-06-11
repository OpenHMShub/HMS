/*Type---Provider/Preview/LastReferral*/

DECLARE @ProviderId AS nvarchar(max) = :trackID

SELECT TOP(1)
	[participant].[Dashboard].FirstName, 
	[participant].[Dashboard].MiddleName, 
	[participant].[Dashboard].LastName
FROM 
	[participant].[Dashboard]
INNER JOIN
	[participant].[Referral]
ON
	[participant].[Referral].ParticipantId=[participant].[Dashboard].id
WHERE 
	[participant].[Referral].ProviderId= @ProviderId
ORDER BY
	[participant].[Referral].timeCreated
DESC
