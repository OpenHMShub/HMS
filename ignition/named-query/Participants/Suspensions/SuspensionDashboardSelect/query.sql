---Participants/Suspensions/SuspensionDashboardSelect---
DECLARE @activity_range AS INT = :activity_range
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
SELECT id, participantId, isActive, suspensionActive, name, firstName, middleName, lastName, nickName, ssn, incidentLogID,
suspensionTypeId, suspensionTypeName, suspensionNotes, Duration, durationText, suspensionDuration, dateBegin, dateEnd, reinstateRequired, dateReinstated
FROM(
SELECT
	s.id,
	s.participantId, 
	s.isActive,
	s.suspensionActive,
	s.name,
	s.firstName,
	s.middleName,
	s.lastName,
	isnull(s.nickName,'') as 'nickName',
	s.ssn,
	s.incidentLogID,
	s.suspensionTypeId,
	s.suspensionTypeName,
	s.suspensionNotes,
	s.DurationRevised as Duration,
	CASE
	    WHEN DurationRevised = 1 THEN '1 Day'
    	WHEN DurationRevised = 7  THEN '1 Week'
    	WHEN DurationRevised = 14 THEN '2 Weeks'
    	WHEN DurationRevised = 30 THEN '30 Days'
    	WHEN DurationRevised = 60 THEN '60 Days'
    	WHEN DurationRevised = 90 THEN '90 Days'
    	WHEN DurationRevised = 365  THEN '1 Year'
    	WHEN DurationRevised = 3650  THEN 'Indefinite'
    	ELSE 'Other'
	END AS durationText,
	CASE
	    WHEN DurationRevised = 1 THEN 1
    	WHEN DurationRevised = 7  THEN 7
    	WHEN DurationRevised = 14 THEN 14
    	WHEN DurationRevised = 30 THEN 30
    	WHEN DurationRevised = 60 THEN 60
    	WHEN DurationRevised = 90 THEN 90
    	WHEN DurationRevised = 365  THEN 365
    	WHEN DurationRevised = 3650  THEN 3650
    	ELSE 0
	END AS suspensionDuration,
	s.dateBegin,
	--FORMAT(s.dateEndRevised, 'MM/dd/yyyy') AS 'dateEnd',
	s.dateEndRevised AS 'dateEnd',
	s.reinstateRequired,
	s.dateReinstated AS 'dateReinstated'
FROM
	 participant.SuspensionDashboard s
) s
WHERE
	dateBegin between @activity_start and @activity_end
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
	
ORDER BY dateBegin DESC