select top 1 CONCAT(count(A.volunteerId) + count(A.volunteerGroupId), '/', count(A.id))
from staff.Assignments A
where CAST(A.timeStart AS DATE) = CAST(dateadd(day, 1, GETDATE()) AS DATE)
group by A.volunteerJobsId
having A.volunteerJobsId = :jobId