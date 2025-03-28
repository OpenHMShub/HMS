---Settings/Staff/UpdateStaff---
Update 
	staff.Employee 
Set 
	isFacilitator = :isFacilitator,
	jobTitle =  :jobTitle, 
	timeRetired = :timeRetired,
	timeUpdated = GetDate(),
	assignments = :assignment
Where
	id = :staffId 