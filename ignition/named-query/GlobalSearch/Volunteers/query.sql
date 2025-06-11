---GlobalSearch/Volunteers---
SELECT CONCAT(humans.Human.firstName,' ',humans.Human.middleName,' ',humans.Human.lastName) as "Name", humans.Human.phone as "PhoneNumber",
humans.Human.email as Email, humans.Human.dob as "dob", humans.Human.id, humans.Human.gender as "gender"
FROM staff.Volunteer
Inner join humans.Human on staff.Volunteer.humanId = Humans.Human.id
WHERE staff.Volunteer.timeRetired is null