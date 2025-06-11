---Participants/DrugScreen/ParticipantIDSelect---
Declare @participantID as int = :participantID;

Select 
	[participant].[Participant].id
FROM [participant].[Participant]
Where [participant].[Participant].id = @participantID
AND [participant].[Participant].timeRetired is null