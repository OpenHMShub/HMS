---Participants/DrugScreen/DrugScreenKPI_PassRate_Monthly---
SELECT 
	month(participant.drugscreenlog.timeCreated) as month,
	cast(COUNT(*) as float) as total,
	cast(COUNT(case WHEN passed = 1 THEN 1 END) as float) as passed
FROM
	participant.drugscreenlog
WHERE
	 participant.drugscreenlog.timeCreated >= DATEADD(month, -12, getdate())
GROUP BY month(participant.drugscreenlog.timeCreated)