---Participants/DrugScreen/DrugScreenKPI_ScreensYTD---
SELECT 
	COUNT(*) as ytd_count
FROM
	participant.drugscreenlog
WHERE
	 year(participant.drugscreenlog.timeCreated ) = year(getdate())