/*---Settings/Volunteers/VolunteersSelect---*/

SELECT 
	v.ID as 'volunteerId',
	h.ID as 'humanId',
	h.breezeId as 'breezeId',
	h.firstName  as 'firstName',
	h.lastName  as 'lastName',
	h.dob as 'dob'

FROM
	staff.Volunteer v
	INNER JOIN  humans.Human h on v.humanId = h.id
