----Participants/Activities/ActivityFeed----
Declare @providerId as int = :providerId ;

with Activities as (
SELECT
	0 AS ID
,	'ProviderAdded' as CardType
,	[organization].[Provider].timeCreated as Date
FROM [organization].[Provider]
Where [organization].[Provider].id = @providerId
union
SELECT
	[organization].[ProviderNotes].id AS ID
,	'Note' as CardType
,	[organization].[ProviderNotes].timeCreated as Date
FROM [organization].[ProviderNotes]
Where [organization].[ProviderNotes].providerId = @providerId
union
SELECT
	[organization].[ProviderContacts].id AS ID
,	'Contact' as CardType
,	[organization].[ProviderContacts].timeCreated as Date
FROM [organization].[ProviderContacts]
Where [organization].[ProviderContacts].providerId = @providerId
union
SELECT
	[participant].[Referral].id AS ID
,	'Referral' as CardType
,	[participant].[Referral].timeCreated as Date
FROM [participant].[Referral]
Where [participant].[Referral].ProviderId = @providerId
union
SELECT
	rl.id AS ID
,	'ReferralStatus' as CardType
,	rl.timeCreated as Date
FROM [participant].[ReferralLog] rl INNER JOIN [participant].[Referral] r on r.id = rl.ReferralId
Where r.ProviderId = @providerId
/*union
SELECT
	[organization].[ApplicantStatus].id AS ID
,	'Referral' as CardType
,	[organization].[ApplicantStatus].appliedDate as Date
FROM [organization].[ApplicantStatus]
Where [organization].[ApplicantStatus].employerId = @providerId AND [organization].[ApplicantStatus].appliedDate IS NOT NULL
*/
),

Headers AS (
Select distinct
	0 as ID
,	'Header' as CardType
,	DATEADD(millisecond, 997, DATEADD(second,59, DATEADD(minute, 59, DATEADD(hour, 23, DATEADD(Day,-1,DATEADD(month, DATEDIFF(month, -1, Activities.Date), 0)))))) AS Date
from Activities
),

TotalInfo as (
Select * from Headers
Union
Select * from Activities
)

Select Top 50 * from TotalInfo
Order by Date desc