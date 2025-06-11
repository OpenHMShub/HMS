----Participants/Activities/ActivityFeed----
Declare @participantId as int = :participantId;

with Activities as (
SELECT
	[participant].[IncidentLog].id as ID
,	'Incident' as CardType
,	[participant].[IncidentLog].incidentDate as Date
FROM [participant].[IncidentLog]
Where [participant].[IncidentLog].ParticipantID = @participantId
union
SELECT
	[participant].[CaseNotes].id AS ID
,	'CaseNote' as CardType
--,	[participant].[CaseNotes].noteDate as Date
,	[participant].[CaseNotes].timeCreated as Date
FROM [participant].[CaseNotes]
Where [participant].[CaseNotes].participantId = @participantId
union
SELECT
	[participant].[services].id AS ID
,	'Services' as CardType
,	[participant].[services].timeCreated as Date
FROM [participant].[services]
WHERE [participant].[services]. participantId =  @participantId
union
SELECT
	[participant].[DrugScreenLog].id as ID
,	'DrugScreen' as CardType
,	[participant].[DrugScreenLog].TestDate as Date
FROM [participant].[DrugScreenLog]
WHERE [participant].[DrugScreenLog].participantId = @participantId
union
SELECT
	[participant].[Referral].id as ID
,	'Referral' as CardType
,	[participant].[Referral].timeCreated as Date
FROM [participant].[Referral]
WHERE [participant].[Referral].participantId = @participantId
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

Select * from TotalInfo
Order by Date desc