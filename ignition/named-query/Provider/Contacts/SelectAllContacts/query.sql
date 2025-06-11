----Participants/Activities/ActivityFeed----
Declare @participantId as int = :participantId;

SELECT
	[participant].[CaseNotes].id AS ID
,	'CaseNote' as CardType
--,	[participant].[CaseNotes].noteDate as Date
,	[participant].[CaseNotes].timeCreated as Date
FROM [participant].[CaseNotes]
Where [participant].[CaseNotes].participantId = @participantId