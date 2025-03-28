---Participants/Journey/JourneyDashboardSelect SO Registry---
DECLARE @activity_range AS INT = :activity_range;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

DECLARE @yearAgoDate AS DATE = DATEADD(day, -365, getdate())
DECLARE @todayCount AS INT;
DECLARE @yearAgoCount AS INT;

SELECT
	@todayCount = COUNT ( distinct h.ParticipantID) 
FROM
	 participant.SoRegistryHistory h 
	 JOIN participant.participant p ON h.ParticipantID = p.id 
	 JOIN humans.human d ON p.humanId = d.id
	 LEFT JOIN humans.Gender hg ON d.genderId = hg.id
	 LEFT JOIN humans.Race hr ON d.raceId = hr.id
WHERE
	
 	h.soRegistryDate > @yearAgoDate AND
 	d.sexOffendRegistry = 1 AND
 	 
 	  {firstName} AND
 	{middleName} AND
 	{lastName} AND
 	
 	{search} AND
 	(:veteranStatusId IS NULL OR :veteranStatusId = -1 OR  d.veteranStatusId = :veteranStatusId ) AND
  	(:programId IS NULL OR :programId = -1 OR (:programId IN ( SELECT programId FROM Participant.Enrollments WHERE particpantId = h.ParticipantID))) AND
 	(:serviceId IS NULL OR :serviceId = -1 OR (:serviceId IN ( SELECT serviceId FROM Participant.services WHERE participantId = h.ParticipantID)))
 	
SELECT
	@yearAgoCount = COUNT ( distinct h.ParticipantID) 
FROM
	 participant.SoRegistryHistory h 
	 JOIN participant.participant p ON h.ParticipantID = p.id 
	 JOIN humans.human d ON p.humanId = d.id
	 LEFT JOIN humans.Gender hg ON d.genderId = hg.id
	 LEFT JOIN humans.Race hr ON d.raceId = hr.id
WHERE
 	h.soRegistryDate <= @yearAgoDate AND
 	d.sexOffendRegistry = 1 AND
 	  {firstName} AND
 	{middleName} AND
 	{lastName} AND
 	{search} AND
 	(:veteranStatusId IS NULL OR :veteranStatusId = -1 OR  d.veteranStatusId = :veteranStatusId ) AND
  	(:programId IS NULL OR :programId = -1 OR (:programId IN ( SELECT programId FROM Participant.Enrollments WHERE particpantId = h.ParticipantID))) AND
 	(:serviceId IS NULL OR :serviceId = -1 OR (:serviceId IN ( SELECT serviceId FROM Participant.services WHERE participantId = h.ParticipantID)))
 	

SELECT @todayCount as todayCount , @yearAgoCount as yearAgoCount