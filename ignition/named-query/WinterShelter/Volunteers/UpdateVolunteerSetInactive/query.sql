---Settings/Volunteers/UpdateVolunteerSetInactive---
Update 
	staff.Volunteer 
Set 
	timeRetired = GetDate()
Where
	id = :volunteerId 