---Participants/Registration/Update Human---
Update 
	[humans].[Human]  
Set 
	timeDeceased = Null
Where
	id = (SELECT humanId FROM [participant].[Participant] WHERE id = :participant_id)
	