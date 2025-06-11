SELECT G.volunteerGroupName as "Name", Count(V.volunteerGroupId) as "Member Count", G.id,
(
	SELECT TOP 1 cast(A.timeStart as date) from staff.Assignments A WHERE A.volunteerGroupId = G.id and A.timeStart > GETDATE() ORDER BY A.timeStart ASC
) as "nextServiceDate",
(
	SELECT TOP 1 CONCAT(J.volunteerJobName,' - ', T.volunteerTaskName) 
	from staff.Assignments A 
	left join staff.VolunteerTask T on A.volunteerTaskId = T.id
	left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
	WHERE A.volunteerGroupId = G.id and A.timeStart > GETDATE() ORDER BY A.timeStart ASC
) as "nextAssignment",
(
	SELECT TOP 1 cast(A.timeStart as date) from staff.Assignments A WHERE A.volunteerGroupId = G.id and A.timeStart < GETDATE() ORDER BY A.timeStart DESC
) as "lastServiceDate",
(
	SELECT TOP 1 CONCAT(J.volunteerJobName,' - ', T.volunteerTaskName) 
	from staff.Assignments A 
	left join staff.VolunteerTask T on A.volunteerTaskId = T.id
	left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
	WHERE A.volunteerGroupId = G.id and A.timeStart < GETDATE() ORDER BY A.timeStart DESC
) as "lastAssignment",
(
	SELECT sum(DATEDIFF(hour, A.timeStart, A.timeEnd)) 
	from staff.Assignments A 
	WHERE A.timeStart < GETDATE() and A.timeStart > DATEADD(month, -6, GETDATE())
	GROUP BY A.volunteerGroupId
	HAVING A.volunteerGroupId = G.id
) as "hoursPastSixMonths",
(
	SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName)
	FROM staff.Volunteer V
	Inner join humans.Human H on V.humanId = H.id
	WHERE V.volunteerGroupId = G.id and V.isLeader = 1
) as "leader"
FROM staff.volunteerGroup G
Left join staff.Volunteer V on G.id = V.volunteerGroupId
Group by G.volunteerGroupName, G.id