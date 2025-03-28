Insert into staff.Employee  (
	humanId,
	isFacilitator,
	jobTitle,
	timeCreated,
	timeUpdated,
	assignments
) 
VALUES (
	:humanId,
	:isFacilitator,
	:jobTitle,
	GetDate(),
	GetDate(),
	:assignment
)
