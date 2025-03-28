/*---Participants/Registration/FindMatches---*/

SELECT TOP 25 
p.id AS 'participantId', 
p.humanId AS 'humanId',
h.first_name as 'firstName',
h.middle_name as 'middleName',
h.last_name as 'lastName',
h.dob AS 'dob'
FROM participant.Participant p
INNER JOIN humans.GroupMembership h
ON p.humanId = h.human_id
WHERE 
(h.first_name LIKE '%'+ISNULL(:firstName,h.first_name)+'%') AND
(h.middle_name LIKE '%'+ISNULL(:middleName,h.middle_name)+'%') AND
(h.last_name LIKE '%'+ISNULL(:lastName,h.last_name)+'%')

/*
Declare @firstName as nvarchar(max) = :first_name,
 	@middleName as nvarchar(max) = :middle_name,
 	@lastName as nvarchar(max) = :last_name,
 	@nickName as nvarchar(max) = :nick_name,
 	@race_idx as INT = :race_id,
 	@race_id as INT = NULL,
	@ssn as nvarchar(4) = :ssn,
 	@dob_month nvarchar(max) = :dob_month,
 	@dob_year nvarchar(max) = :dob_year, 
 	@dob_day nvarchar(max) = :dob_day

SELECT TOP 25
	h.human_id as 'human_id',
	h.participant_id as 'participant_id',
	h.participant_retired as 'participant_retired',
	h.employee_id as 'employee_id',
	h.employee_retired as 'employee_retired',
	h.volunteer_id as 'volunteer_id',
	h.volunteer_retired as 'volunteer_retired',
	h.first_name as 'first_name',
	h.middle_name as 'middle_name',
	h.last_name as 'last_name',
	h.nick_name as 'nick_name',
	h.ssn as 'ssn',
	CAST(FORMAT (h.dob, 'MM/dd/yyyy') as varchar) as 'dob',
	LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2) as 'dob_day',
	h.race_id as 'race_id',
	h.race as 'race'


FROM
	humans.GroupMembership h

WHERE

	(h.first_name like IsNull(@firstName,h.first_name)+'%' OR (@firstName is null AND h.first_name is null))
	AND
	(h.middle_name like IsNull(@middleName,h.middle_name)+'%' OR (@middleName is null AND h.middle_name is null))
	AND
	(h.last_name like IsNull(@lastName,h.last_name)+'%' OR (@lastName is null AND h.last_name is null))
	AND
	(h.nick_name like IsNull(@nickName,h.nick_name)+'%' OR (@nickName is null AND h.nick_name is null))
	AND	
	(h.race_id = IsNull(@race_id,h.race_id))
	AND	
	(h.ssn like '%'+ IsNull(@ssn,h.ssn) + '%')
	AND
	(LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2) like IsNull(@dob_day,LEFT(CAST(FORMAT(h.dob,'dd/MM/yyyy') as varchar),2)) + '%')
	AND
	(LEFT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),2) like IsNull(@dob_month,LEFT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),2)) + '%')
	AND 
	(RIGHT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),4) like IsNull(@dob_year,RIGHT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),4)) + '%')
	AND
	(h.participant_id is NOT Null)
*/