select top 1 CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(J.id))
from staff.Assignments A
left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
where CAST(A.timeStart AS DATE) = CAST(dateadd(day, 1, GETDATE()) AS DATE)
group by J.facilitatorId
having J.facilitatorId = :facilitatorId