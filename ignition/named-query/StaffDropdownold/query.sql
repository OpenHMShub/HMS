SELECT 
  humans.human.id,
  (humans.Human.firstName + ' ' + humans.Human.lastName) AS name
FROM humans.Human
  INNER JOIN staff.Employee ON humans.Human.id = staff.Employee.humanId
 WHERE humans.human.id >1