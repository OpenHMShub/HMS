---Participants/Journey/JourneyDashboardSelect SO Registry---
DECLARE @activity_range AS INT = :activity_range;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT
	MONTH(h.soRegistryDate) as monthValue, COUNT ( distinct h.ParticipantID) as countValue 
FROM
	 participant.SoRegistryHistory h 
	 JOIN participant.participant p ON h.ParticipantID = p.id 
	 JOIN humans.human d ON p.humanId = d.id
	 LEFT JOIN humans.Gender hg ON d.genderId = hg.id
	 LEFT JOIN humans.Race hr ON d.raceId = hr.id
WHERE
	
 	h.soRegistryDate between @activity_start and @activity_end AND
 	d.sexOffendRegistry = 1 AND
 	(h.soRegistryDate between DATEADD(month, -:monthCount, getDATE()) AND GETDATE()) AND
 	  {soRegistryDate} AND
 	  {firstName} AND
 	{middleName} AND
 	{lastName} AND
	{search} AND
	(:veteranStatusId IS NULL OR :veteranStatusId = -1 OR  d.veteranStatusId = :veteranStatusId ) AND
  	(:programId IS NULL OR :programId = -1 OR (:programId IN ( SELECT programId FROM Participant.Enrollments WHERE particpantId = h.ParticipantID))) AND
 	(:serviceId IS NULL OR :serviceId = -1 OR (:serviceId IN ( SELECT serviceId FROM Participant.services WHERE participantId = h.ParticipantID)))
GROUP BY MONTH(h.soRegistryDate)
ORDER BY MONTH(h.soRegistryDate)