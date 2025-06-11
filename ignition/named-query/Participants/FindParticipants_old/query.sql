---Participants/FindParticipants---
Declare @firstName as nvarchar(max) =  :firstName;
Declare @lastName as nvarchar(max) =  :lastName ;
Declare @dob as date = :dob ;
Declare @race as int = :race;
Declare @race2 as int = Null;
Declare @ssn as nvarchar(max) = :ssn;
Declare @ssn2 as nvarchar(max) = Null;

Select
	[humans].[Human].firstName as 'first_name'
,	[humans].[Human].lastName as 'last_name'
,	[humans].[Human].dob as 'dob'
,	[humans].[Human].raceId as 'race_id'
,	[humans].[Race].raceName as 'race'
,	'xxx-xx-'+right([humans].[human].ssn,6) as 'ssn'
,	[participant].[Participant].id as 'participant_id'
From
	[participant].[Participant]
	Left join [humans].[Human] on [participant].[Participant].humanId = [humans].[Human].id
	LEFT JOIN [humans].[Race] ON [humans].[Human].raceId = [humans].[Race].id

Where 

	[participant].[Participant].timeRetired is null
	And ([humans].[Human].timeRetired is null)
	And ([humans].[Human].firstName like '%'+@firstName+'%' or @firstName = '')
	And	([humans].[Human].lastName like '%'+@lastName+'%' or @lastName = '')
	And	(CONVERT(VARCHAR(10),[humans].[Human].dob,112) like'%'+  :dob +'%' or @dob = '')
	And	([humans].[Human].raceId = IsNull(@race,[humans].[Human].raceId ))
	And	([humans].[human].ssn like '%' + IsNull(@ssn,[humans].[human].ssn) + '%')
	--	or @ssn = ''
	--	OR FORMAT(Convert(int,[humans].[human].ssn), '###-##-####') like '%'+@ssn+'%')
--ORDER BY last_name