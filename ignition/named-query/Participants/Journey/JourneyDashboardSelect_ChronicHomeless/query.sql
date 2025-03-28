---Participants/Journey/JourneyDashboardSelect---
--- allSelection = 0 means both Active/Inactive, 1 means Active only, 2 means Inactive only ---
DECLARE @activity_range AS INT = :activity_range;
--Calculate the begin and end activity dates
DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
	,@activity_end AS DATE = DATEADD(day,1,getdate());
DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :season
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :season
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 

SELECT
	h.chronicHomeless ,
	h.chronicHomelessDate,
	h.ParticipantID,
	h.id,
	CONCAT_WS(' ', d.firstName, d.middleName,d.lastName ) as participantName,
	hr.raceName as 'Race',
	hg.genderName as 'Gender',
	CAST((DATEDIFF(day, d.[dob], GetDate()))/365.25 as INT) as 'Age',
	d.dob as 'BirthDate',
	CONCAT('***-**-' , RIGHT(d.SSN, 4)) as SSN,
	CASE WHEN p.timeRetired is NULL then 1 ELSE 0 END as 'isActive',
	d.chronicHomeless as 'CurrentHomelessStatus',
	CASE WHEN d.chronicHomeless = 1 THEN 'Yes' ELSE 'No' end as  'CurrentHomelessStatusStr',
	COALESCE(vs.veteranStatusName , '') as 'veteranStatusName'
FROM
	 participant.ChronicHomelssHistory h 
	 JOIN participant.participant p ON h.ParticipantID = p.id 
	 JOIN humans.human d ON p.humanId = d.id
	 LEFT JOIN humans.Gender hg ON d.genderId = hg.id
	 LEFT JOIN humans.Race hr ON d.raceId = hr.id
	 LEFT JOIN humans.VeteranStatus vs on vs.id = d.veteranStatusId 
WHERE
	
 	h.chronicHomelessDate between @activity_start and @activity_end AND
 	((:activeTimePeriodStart is NULL or :activeTimePeriodEnd is NULL)
 	OR 
 	(h.ParticipantID in (SELECT participantId FROM participant.services where (timeCreated between :activeTimePeriodStart and :activeTimePeriodEnd)) or
 	h.ParticipantID in (SELECT participantId FROM lodging.BedLog where eventEnd IS NULL and (eventStart between :activeTimePeriodStart and :activeTimePeriodEnd)) or
 	h.ParticipantID in (SELECT participantId FROM shelter.ScheduleParticipant
 		where seasonId = :season and (DateAdd(DAY, dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end) between :activeTimePeriodStart and :activeTimePeriodEnd))
 	)
 	)
 	AND
 	(:allSelection = 0 OR 
 	(:allSelection = 1 and d.chronicHomeless = 1) OR
 	(:allSelection = 2 and d.chronicHomeless = 0) 
 	)AND
 	((:startDate is NULL or :endDate is NULL) or (h.chronicHomelessDate between :startDate and :endDate) or (h.chronicHomelessDate<:startDate and d.chronicHomeless=1)) AND
 	  {chronicHomelessDate} AND
 	  {firstName} AND
 	{middleName} AND
 	{lastName} AND
  	{search} AND
  	(:veteranStatusId IS NULL OR :veteranStatusId = -1 OR  d.veteranStatusId = :veteranStatusId ) AND
  	(:programId IS NULL OR :programId = -1 OR (:programId IN ( SELECT programId FROM Participant.Enrollments WHERE particpantId = h.ParticipantID))) AND
 	(:serviceId IS NULL OR :serviceId = -1 OR (:serviceId IN ( SELECT serviceId FROM Participant.services WHERE participantId = h.ParticipantID)))
 	
ORDER BY h.ParticipantID , h.chronicHomelessDate DESC