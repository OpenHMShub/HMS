select J.id, J.volunteerJobName, J.days, J.timeStart, J.timeLength,
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(A.id))
		from staff.Assignments A
		where CAST(A.timeStart AS DATE) = CAST(GETDATE() AS DATE)
		group by A.volunteerJobsId
		having A.volunteerJobsId = J.id
	) as "converageToday",
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(A.id))
		from staff.Assignments A
		where CAST(A.timeStart AS DATE) = CAST(dateadd(day, 1, GETDATE()) AS DATE)
		group by A.volunteerJobsId
		having A.volunteerJobsId = J.id
	) as "converageTomorrow",
	(
		select CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(A.id))
		from staff.Assignments A
		where CAST(A.timeStart AS DATE) >= CAST(GETDATE() AS DATE) and CAST(A.timeStart AS DATE) < CAST(dateadd(day, 7, GETDATE()) AS DATE)
		group by A.volunteerJobsId
		having A.volunteerJobsId = J.id
	) as "converageSevenDay"
from staff.VolunteerJobs J
Where j.timeRetired is NULL;