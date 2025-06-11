SELECT F.id, CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "name"
FROM staff.Facilitator F
Inner join staff.Employee E on F.employeeId = E.id
Inner join humans.Human H on E.humanId = H.id
Where F.timeRetired is null;