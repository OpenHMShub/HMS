Insert into [staff].Employee (
	humanId,
	jobTitle,
	badgeNumber,
	timeCreated 
)
Values (
	:humanId,
	:jobTitle,
	:badgeNumber,
	GetDate()
)