---Participants/Registration/Update Human---
Update 
	[participant].[Participant]  
Set 
	timeRetired = Null,
	timeRegistered = GetDate()
Where
	id = :participant_id
	