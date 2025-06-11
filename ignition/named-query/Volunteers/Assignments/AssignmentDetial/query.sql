select J.volunteerJobName as 'name', P.placeName, CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "facilitatorName", J.volunteerJobDescription as 'description'
from staff.VolunteerJobs J
left join staff.Places P on J.placeId = P.id
left join staff.Facilitator F on J.facilitatorId = F.id
left join staff.Employee E on F.employeeId = E.id
left join humans.Human H on E.humanId = H.id
where J.id = :id