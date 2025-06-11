---Participants/Registration/Insert New Human Manual---
Insert into [humans].Human (
	firstName,
	lastName,
	timeCreated 
)
Values (
	:first_name,
	:last_name,
	GetDate()
)