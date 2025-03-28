/*---Settings/Volunteers/VolunteersSelect---*/

SELECT 
	'' as 'options',
	e.ID as 'staffId',
	h.ID as 'humanId',
	h.breezeId as 'breezeId',
	e.jobTitle as 'jobTitle',
	e.assignments as 'assignments',
	h.firstName  as 'firstName',
	ISNULL(h.middleName,'')  as 'middleName',
	h.lastName  as 'lastName',
	ISNULL(h.suffix,'') as 'suffix',
	FORMAT(h.dob, 'd', 'us') AS 'dob',
	h.genderId as 'genderId',
	hg.genderName as 'genderName',
	ISNULL(h.email ,'')  as 'email',
	ISNULL('(' + LEFT(h.phone,3) +') ' + SUBSTRING(h.phone,4,3) + '-' + SUBSTRING(h.phone,7,4),'') as 'phone',
	--ISNULL(h.phone,'') as 'xphone',
	ISNULL('(' + LEFT(h.altPhone,3) +') ' + SUBSTRING(h.altPhone,4,3) + '-' + SUBSTRING(h.altPhone,7,4),'') as 'altPhone',
	--ISNULL(h.altPhone,'') as 'altPhone',
	CAST((CASE WHEN e.timeRetired is null THEN 1 ELSE 0 END)AS BIT) as 'active',
	e.isFacilitator as 'isFacilitator'
	


FROM
	staff.Employee e
	INNER JOIN  humans.Human h on e.humanId = h.id
	LEFT JOIN  humans.Gender hg ON h.genderId  = hg.id


WHERE

	{firstName} 
	AND
	{middleName}
	AND
	{lastName}
	AND
	{search} 
	AND
	{active} 

ORDER BY h.lastName