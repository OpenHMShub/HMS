---Participants/DrugScreen/DrugScreenKPI_Participants---
SELECT
	COUNT(DISTINCT(participant.drugscreenlog.participantid)) as participant_count
FROM
	participant.drugscreenlog
