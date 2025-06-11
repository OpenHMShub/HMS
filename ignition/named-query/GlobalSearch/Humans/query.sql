/*---GlobalSearch/Humans---*/
Declare @firstName as nvarchar(max) = :first_name ;
Declare @lastName as nvarchar(max) = :last_name ;
Declare @dob DATETIME = :dob;
Declare @race_id as INT = :race_id ;
--Declare @race_id as INT = NULL;
Declare @ssn as nvarchar(4) = :ssn;

SELECT TOP 100
	h.human_id as 'human_id',
	h.participant_id as 'participant_id',
	h.employee_id as 'employee_id',
	h.volunteer_id as 'volunteer_id',
	h.case_manager_id as 'case_manager_id',
	h.provider_id as 'provider_id',
	h.first_name as 'first_name',
	h.last_name as 'last_name',
	h.ssn as 'ssn',
	CAST(FORMAT (h.dob, 'MM/dd/yyyy') as varchar) as 'dob',
	h.gender_id as 'gender_id',
	h.gender as 'gender',
	h.race_id as 'race_id',
	h.race as 'race',
	h.disability_id as 'disability_id',
	h.disability as 'disability',
	h.veteran_id as 'veteran_id',
	h.veteran as 'veteran'

FROM
	humans.GroupMembership h

--WHERE

--	(h.first_name like IsNull(@firstName,h.first_name)+'%')
--	AND
--	(h.last_name like IsNull(@lastName,h.last_name)+'%')
--	AND	
--	(h.race_id = IsNull(@race_id,h.race_id))
--	AND	
--	(h.ssn like '%'+ IsNull(@ssn,h.ssn) + '%')


ORDER BY
	human_id
