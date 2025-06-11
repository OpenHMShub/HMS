----Participants/Activities/ActivityFeed----
Declare @participantId as int = :participantId;

with Activities as (
SELECT
	[participant].[IncidentLog].id as ID
,	'Incident' as CardType
--,[participant].[IncidentLog].incidentDate as Date
FROM [participant].[IncidentLog]
Where [participant].[IncidentLog].ParticipantID = @participantId
union
SELECT
	[participant].[CaseNotes].id AS ID
,	'CaseNote' as CardType
--,	[participant].[CaseNotes].timeCreated as Date
FROM [participant].[CaseNotes]
Where [participant].[CaseNotes].participantId = @participantId
union
SELECT
	[participant].[services].id AS ID
,	'Services' as CardType
--,	[participant].[services].timeCreated as Date
FROM [participant].[services]
WHERE [participant].[services]. participantId =  @participantId
union
SELECT
	[participant].[DrugScreenLog].id as ID
,	'DrugScreen' as CardType
--,	[participant].[DrugScreenLog].TestDate as Date
FROM [participant].[DrugScreenLog]
WHERE [participant].[DrugScreenLog].participantId = @participantId
union
SELECT
	[participant].[ReferralLog].id as ID
,	'Referral' as CardType
--,	[participant].[ReferralLog].timeCreated as Date
FROM [participant].[Referral]
INNER JOIN [participant].[ReferralLog] ON [participant].[Referral].id = [participant].[ReferralLog].ReferralId 
WHERE [participant].[Referral].participantId = @participantId
union
SELECT
	0 as ID
,	'ParticipantAdded' as CardType
--,	[participant].[Participant].timeCreated as Date
FROM [participant].[Participant]
WHERE [participant].[Participant].Id = @participantId
union
SELECT
	0 as ID
,	'RegistrationUpdated' as CardType
--,	[participant].[Participant].timeRegistered as Date
FROM [participant].[Participant]
WHERE [participant].[Participant].Id = @participantId
	AND [participant].[Participant].timeRegistered is not Null
union
SELECT
	[participant].[ReinstatementLog].id as ID
,	'Suspension' as CardType
--,	[participant].[ReinstatementLog].timeCreated as Date
FROM [participant].[ReinstatementLog]
WHERE [participant].[ReinstatementLog].participantId = @participantId
)

--Select count(ID),CardType from Activities
Select CardType from Activities
GROUP BY CardType

--Order by Date desc