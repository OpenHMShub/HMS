select A.id, A.timeStart, A.timeEnd, T.volunteerTaskName, J.volunteerJobName, P.placeName, A.volunteerId, A.volunteerGroupId
from staff.Assignments A
left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
left join staff.Places P on J.placeId = P.id
left join staff.VolunteerTask T on A.volunteerTaskId = T.id
where A.id = :id