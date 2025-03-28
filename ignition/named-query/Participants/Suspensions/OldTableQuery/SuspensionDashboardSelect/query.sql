---Participants/Suspensions/SuspensionDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT
	s.id,
	s.participantId, 
	s.suspensionActive,
	s.name,
	s.firstName,
	s.middleName,
	s.lastName,
	s.nickName,
	s.ssn,
	s.incidentLogID,
	s.suspensionTypeId,
	s.suspensionTypeName,
	s.suspensionNotes,
	s.Duration,
	CASE
	    WHEN Duration = 1 THEN '1 Day'
    	WHEN Duration = 7  THEN '1 Week'
    	WHEN Duration = 14 THEN '2 Weeks'
    	WHEN Duration = 30 THEN '30 Days'
    	WHEN Duration = 60 THEN '60 Days'
    	WHEN Duration = 90 THEN '90 Days'
    	WHEN Duration = 365  THEN '1 Year'
    	WHEN Duration = 3650  THEN 'Indefinite'
    	ELSE 'Other'
	END AS durationText,
	FORMAT(s.dateBegin, 'd', 'us') AS 'dateBegin',
	FORMAT(s.dateEndRevised, 'd', 'us') AS 'dateEnd',
	s.reinstateRequired,
	FORMAT(s.dateReinstated, 'd', 'us') AS 'dateReinstated'
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
	
ORDER BY s.dateEndRevised ASC