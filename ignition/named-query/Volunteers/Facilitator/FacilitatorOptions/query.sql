SELECT F.id as "value", CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "label" 
FROM staff.Facilitator F
Inner join staff.Employee E on F.employeeId = E.id
Inner join humans.Human H on E.humanId = H.id
WHERE F.timeRetired is null;