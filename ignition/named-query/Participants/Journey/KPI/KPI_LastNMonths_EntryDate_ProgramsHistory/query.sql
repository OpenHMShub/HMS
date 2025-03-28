---Participants/Journey/JourneyDashboardSelect---
--- allSelection = 0 means both Active/Inactive, 1 means Active only, 2 means Inactive only ---
DECLARE @activity_range AS INT = :activity_range;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT
	
	MONTH(h.EntryDate) as monthValue, count( h.ParticipantID) as countValue
FROM
	 participant.ProgramsHistory h 
	 JOIN participant.participant p ON h.ParticipantID = p.id 
	 JOIN humans.human d ON p.humanId = d.id
	 LEFT JOIN humans.Gender hg ON d.genderId = hg.id
	 LEFT JOIN humans.Race hr ON d.raceId = hr.id
	 LEFT JOIN interaction.Program ip ON h.ProgramID = ip.id
WHERE
	
 	( h.EntryDate between @activity_start and @activity_end 
 	OR
 	 h.ExitDate between @activity_start and @activity_end
 	) AND
 	(:allSelection = 0 OR 
 	(:allSelection = 1 and h.ExitDate IS NULL) OR
 	(:allSelection = 2 and h.ExitDate IS NOT NULL) 
 	)AND
 	  {chronicHomelessDate} AND
 	  {firstName} AND
 	{middleName} AND
 	{lastName} AND
  	{search} AND
  	(:veteranStatusId IS NULL OR :veteranStatusId = -1 OR  d.veteranStatusId = :veteranStatusId ) AND
  	(:programId IS NULL OR :programId = -1 OR h.ProgramID = :programId ) AND
 	(:serviceId IS NULL OR :serviceId = -1 OR (:serviceId IN ( SELECT serviceId FROM Participant.services WHERE participantId = h.ParticipantID)))
 	
GROUP BY MONTH(h.EntryDate)
ORDER BY MONTH(h.EntryDate)