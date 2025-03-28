---Participants/ParticipantHumanIDSelect---
SELECT
	[participant].[Participant].id as 'participantID',
	[participant].[Participant].humanID as 'participant_human_id'
FROM
	[participant].[Participant]
WHERE
	[participant].[Participant].id  = :participant_id 