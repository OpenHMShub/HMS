---Settings/Volunteers/UpdateVolunteerSetActive---
Update 
	staff.Volunteer 
Set 
	timeRetired = Null,
	timeUpdated = GetDate()
Where
	id = :volunteerId 