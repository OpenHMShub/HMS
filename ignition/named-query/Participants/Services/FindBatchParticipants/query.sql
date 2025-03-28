/*---Participants/Registration/FindMatches---*/
Declare @firstName as nvarchar(max) = :first_name,
 	@lastName as nvarchar(max) = :last_name,
 	@race_id as INT = :race_id,
 	--@race_id as INT = NULL,
	@ssn as nvarchar(4) = :ssn,
 	@dob_month nvarchar(max) = :dob_month,
 	@dob_year nvarchar(max) = :dob_year, 
 	@dob_day nvarchar(max) = :dob_day

SELECT TOP 25
	p.ID as 'participant_id',
	h.firstName  as 'first_name',
	h.lastName  as 'last_name',
	--h.ssn as 'ssn',
	'***-**-' + Right(h.SSN,4) as 'ssn',
	CAST(FORMAT (h.dob, 'MM/dd/yyyy') as varchar) as 'dob',
	LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2) as 'dob_day',
	h.raceId  as 'race_id',
	r.raceName as 'race'


FROM
	participant.participant p
	INNER JOIN  humans.Human h on p.humanId = h.id
	LEFT JOIN  humans.Race r on h.raceId = r.id

WHERE
	p.timeRetired is null
	AND
	(h.firstName like IsNull(@firstName,h.firstName)+'%')
	AND
	(h.lastName like IsNull(@lastName,h.lastName)+'%')
	AND	
	(h.raceId = IsNull(@race_id,h.raceId))
	AND	
	(h.ssn like '%'+ IsNull(@ssn,h.ssn) + '%')
	AND
	(LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2) like IsNull(@dob_day,LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2)) + '%')
	AND
	(LEFT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),2) like IsNull(@dob_month,LEFT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),2)) + '%')
	AND 
	(RIGHT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),4) like IsNull(@dob_year,RIGHT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),4)) + '%')
