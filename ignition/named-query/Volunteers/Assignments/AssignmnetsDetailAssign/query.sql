select A.id, T.volunteerTaskName, T.volunteerTaskDescription, A.timeStart, A.timeEnd, T.ageLow, T.ageHigh, T.gender,
CASE 
	WHEN A.volunteerId IS NOT NULL THEN
	 	CONCAT(H.firstName,' ',H.middleName,' ',H.lastName)
	WHEN A.volunteerGroupId IS NOT NULL THEN
		G.volunteerGroupName
	ELSE
		'None'
END as 'volunteer'
from staff.Assignments A
left join staff.Volunteer V on A.volunteerId = V.id
left join humans.Human H on V.humanId = H.id
left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
left join staff.VolunteerTask T on A.volunteerTaskId = T.id
left join staff.VolunteerGroup G on A.volunteerGroupId = G.id
where A.timeEnd >= GETDATE() and A.timeRetired is NULL and J.id = :jobId
order by A.timeStart;