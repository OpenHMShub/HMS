---Participants/Suspensions/SuspensionDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT totalSuspensions, CONVERT(VARCHAR(10),datefromparts(year, monthName, 1),101)  as monthStartDate
FROM
(
SELECT COUNT(id) as totalSuspensions, month(dateBegin) as monthName, year(dateBegin) year
FROM
	 participant.SuspensionDashboard s
WHERE
	s.dateBegin between @activity_start and @activity_end
	AND {suspensionActive} 
	AND {dateBegin} 
	AND {dateEnd}
	AND {dateReinstated} 
	AND {typeId}
	AND {duration}
	AND {firstName}
	AND {middleName}
	AND {lastName}
	AND {nickName}
	AND {search}
group by month(dateBegin) , year(dateBegin)

) a
ORDER BY year, monthName