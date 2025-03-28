----Participants/Activities/ActivityFeed----
Declare @participantId as int = :participantId;
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

with Activities as (
SELECT
	[participant].[IncidentLog].id as ID
,	'Incident' as CardType
,	[participant].[IncidentLog].incidentDate as Date
FROM [participant].[IncidentLog]
Where [participant].[IncidentLog].ParticipantID = @participantId
AND [participant].[IncidentLog].incidentDate between @activity_start and @activity_end
union
SELECT
	[participant].[CaseNotes].id AS ID
,	'CaseNote' as CardType
--,	[participant].[CaseNotes].noteDate as Date
,	[participant].[CaseNotes].timeCreated as Date
FROM [participant].[CaseNotes]
Where [participant].[CaseNotes].participantId = @participantId
AND [participant].[CaseNotes].timeCreated between @activity_start and @activity_end
union
SELECT
	[participant].[services].id AS ID
,	'Services' as CardType
,	[participant].[services].timeCreated as Date
FROM [participant].[services]
WHERE [participant].[services]. participantId =  @participantId
AND [participant].[services].timeCreated between @activity_start and @activity_end
union
SELECT
	[participant].[DrugScreenLog].id as ID
,	'DrugScreen' as CardType
,	[participant].[DrugScreenLog].TestDate as Date
FROM [participant].[DrugScreenLog]
WHERE [participant].[DrugScreenLog].participantId = @participantId
AND [participant].[DrugScreenLog].TestDate between @activity_start and @activity_end
union
SELECT
	[participant].[ReferralLog].id as ID
,	'Referral' as CardType
,	[participant].[ReferralLog].timeCreated as Date
FROM [participant].[Referral]
INNER JOIN [participant].[ReferralLog] ON [participant].[Referral].id = [participant].[ReferralLog].ReferralId 
WHERE [participant].[Referral].participantId = @participantId
AND [participant].[ReferralLog].timeCreated between @activity_start and @activity_end
union
SELECT
	0 as ID
,	'ParticipantAdded' as CardType
,	[participant].[Participant].timeCreated as Date
FROM [participant].[Participant]
WHERE [participant].[Participant].Id = @participantId
AND [participant].[Participant].timeCreated between @activity_start and @activity_end
union
SELECT
	0 as ID
,	'RegistrationUpdated' as CardType
,	[participant].[Participant].timeRegistered as Date
FROM [participant].[Participant]
WHERE [participant].[Participant].Id = @participantId
	AND [participant].[Participant].timeRegistered between @activity_start and @activity_end
union
SELECT
	[participant].[ReinstatementLog].id as ID
,	'Suspension' as CardType
,	[participant].[ReinstatementLog].timeCreated as Date
FROM [participant].[ReinstatementLog]
WHERE [participant].[ReinstatementLog].participantId = @participantId
AND [participant].[ReinstatementLog].timeCreated between @activity_start and @activity_end	

union
SELECT
	[participant].[TaskActivityLog].id as ID
,	'TaskAdded' as CardType
,	[participant].[TaskActivityLog].timeCreated as Date
FROM [participant].[TaskActivityLog]
WHERE [participant].[TaskActivityLog].participantId = @participantId
AND [participant].[TaskActivityLog].timeCreated between @activity_start and @activity_end
AND [participant].[TaskActivityLog].activityType = 'task_added'
union
SELECT
	[participant].[TaskActivityLog].id as ID
,	'TaskModified' as CardType
,	[participant].[TaskActivityLog].timeCreated as Date
FROM [participant].[TaskActivityLog]
WHERE [participant].[TaskActivityLog].participantId = @participantId
AND [participant].[TaskActivityLog].timeCreated between @activity_start and @activity_end
AND [participant].[TaskActivityLog].activityType = 'task_modified'
union
SELECT
	[participant].[TaskActivityLog].id as ID
,	'TaskCompleted' as CardType
,	[participant].[TaskActivityLog].timeCreated as Date
FROM [participant].[TaskActivityLog]
WHERE [participant].[TaskActivityLog].participantId = @participantId
AND [participant].[TaskActivityLog].timeCreated between @activity_start and @activity_end
AND [participant].[TaskActivityLog].status = 'completed'
),

Headers AS (
Select distinct
	0 as ID
,	'Header' as CardType
,	DATEADD(Day,-1,DATEADD(month, DATEDIFF(month, -1, Activities.Date), 0)) AS Date
from Activities
),

TotalInfo as (
Select * from Activities
Union
Select * from Headers
)

Select TOP 100 * from TotalInfo
Order by Date desc