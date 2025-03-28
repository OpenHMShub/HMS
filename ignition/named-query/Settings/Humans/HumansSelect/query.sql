/*---Settings/Humans/HumanSelect---*/
--SELECT TOP 100
SELECT * FROM(
SELECT
	h.participant_id as 'participantId_ForPreview',
	h.participant_id as 'participantId_ForNavigation',
	h.human_id as 'human_id',
	h.breezeId as 'breezeId',
	h.first_name as 'first_name',
	ISNULL(h.middle_name,'') as 'middle_name',
	h.last_name as 'last_name',
	ISNULL(h.suffix,'') as 'suffix',
	ISNULL(h.nick_name,'') as 'nick_name',
	h.ssn as 'ssn',
	h.gender_id as 'gender_id',
	h.gender as 'gender',
	CAST(FORMAT (h.dob, 'MM/dd/yyyy') as varchar) as 'dob',
	--LEFT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),2) as 'dob',
	--RIGHT(CAST(FORMAT(h.dob,'MM/dd/yyyy') as varchar),4) as 'dob',
	h.race_id as 'race_id',
	h.race as 'race',
	h.disability_id as 'disability_id',
	h.disability as 'disability',
	h.veteran_id as 'veteran_id',
	h.veteran as 'veteran',
	h.participant_id as 'participant_id',
	CASE WHEN ISNULL(h.participant_id,-1) = -1 THEN 0 ELSE 1 end as 'isParticipant',
	CASE WHEN ISNULL(h.participant_retired,1) = 1 THEN 1 ELSE 0 end as 'isParticipantActive',
	h.employee_id as 'employee_id',
	--h.employee_retired as 'employee',
	CASE WHEN ISNULL(h.employee_id,-1) = -1 THEN 0 ELSE 1 end as 'isEmployee',
	h.volunteer_id as 'volunteer_id',
	--h.volunteer_retired as 'volunteer'
	CASE WHEN ISNULL(h.volunteer_id,-1) = -1 THEN 0 ELSE 1 end as 'isVolunteer'
	,DATEADD(hh,12,CAST((SELECT timeDeceased FROM humans.Human where id = h.human_id) as DATETIME)) as 'time_deceased'

FROM
	humans.GroupMembership h
WHERE

 	{firstname} AND
 	{middlename} AND
 	{lastname} AND
 	{nickname} AND
 	{ssn} AND
 	{dobyear} AND
 	{raceid} AND
 	{search}

)x
WHERE {isParticipantActive}
ORDER BY
	human_id
