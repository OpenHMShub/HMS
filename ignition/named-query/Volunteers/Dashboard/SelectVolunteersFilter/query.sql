---Volunteers/Dashboard/Select Volunteers Filter---
DECLARE @nextServiceDateStart AS DATE = :nextServiceDateStart
 	,@nextServiceDateEnd AS DATE =  :nextServiceDateEnd 
	,@lastServiceDateStart AS Date = :lastServiceDateStart
	,@lastServiceDateEnd AS DATE = :lastServiceDateEnd 
	,@hoursEnd AS INT = :hoursEnd
	,@hoursStart AS INT = :hoursStart;
WITH v as (SELECT CONCAT(H.firstName,' ',H.middleName,' ',H.lastName) as "Name", 
H.phone as "Phone Number",
H.email as Email, 
H.dob as "dob", 
H.id, H.gender as "gender",
(
	SELECT TOP 1 cast(A.timeStart as date) from staff.Assignments A WHERE A.volunteerId = V.id and A.timeStart > GETDATE() ORDER BY A.timeStart ASC
) as "nextServiceDate",
(
	SELECT TOP 1 CONCAT(J.volunteerJobName,' - ', T.volunteerTaskName) 
	from staff.Assignments A 
	left join staff.VolunteerTask T on A.volunteerTaskId = T.id
	left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
	WHERE A.volunteerId = V.id and A.timeStart > GETDATE() ORDER BY A.timeStart ASC
) as "nextAssignment",
(
	SELECT TOP 1 cast(A.timeStart as date) from staff.Assignments A WHERE A.volunteerId = V.id and A.timeStart < GETDATE() ORDER BY A.timeStart DESC
) as "lastServiceDate",
(
	SELECT TOP 1 CONCAT(J.volunteerJobName,' - ', T.volunteerTaskName) 
	from staff.Assignments A 
	left join staff.VolunteerTask T on A.volunteerTaskId = T.id
	left join staff.VolunteerJobs J on A.volunteerJobsId = J.id
	WHERE A.volunteerId = V.id and A.timeStart < GETDATE() ORDER BY A.timeStart DESC
) as "lastAssignment",
isNull((
	SELECT isnull(sum(DATEDIFF(hour, A.timeStart, A.timeEnd)),0)
	from staff.Assignments A 
	WHERE A.timeStart < GETDATE() and A.timeStart > DATEADD(month, -6, GETDATE())
	GROUP BY A.volunteerId
	HAVING A.volunteerId = V.id
),0) as "hoursPastSixMonths"
FROM staff.Volunteer V
Inner join humans.Human H on V.humanId = H.id
WHERE V.timeRetired is null)

SELECT *
FROM v
WHERE 
nextServiceDate >= isNull(@nextServiceDateStart,[nextServiceDate]) and nextServiceDate <= isNull(@nextServiceDateEnd,[nextServiceDate]) and
lastServiceDate >= isNull(@lastServiceDateStart,[lastServiceDate]) and nextServiceDate <= isNull(@lastServiceDateEnd,[lastServiceDate]) and
hoursPastSixMonths >= isNull(@hoursStart,[hoursPastSixMonths]) and hoursPastSixMonths <= isNull(@hoursStart,[hoursPastSixMonths])
ORDER BY nextServiceDate DESC, lastServiceDate DESC;