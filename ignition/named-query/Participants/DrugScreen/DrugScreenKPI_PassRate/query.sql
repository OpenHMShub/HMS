---Participants/DrugScreen/DrugScreenKPI_PassRate---
SELECT 
	cast(COUNT(*) as float) as total,
	cast(COUNT(case WHEN passed = 1 THEN 1 END) as float) as passed
FROM
	participant.drugscreenlog
WHERE
	 participant.drugscreenlog.timeCreated >= DATEADD(day, -30, getdate())