---Participants/ParticipantDropdownList---
SELECT
	[participant].[Participant].id as 'participantID',
	CONCAT_WS(' ',[humans].[Human].firstName, [humans].[Human].middleName, [humans].[Human].lastName) as 'name'
FROM
	[participant].[Participant]
	INNER JOIN [humans].[Human] on [participant].[Participant].humanId = [humans].[Human].id
ORDER BY [humans].[Human].lastName