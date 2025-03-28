---Settings/Congregations/UpdateCongregationSetActive---
Update 
	organization.Congregation 
Set 
	timeRetired = GetDate()
Where
	id = :congregationId 