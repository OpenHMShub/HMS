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
FROM humans.GroupMembership h