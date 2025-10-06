/*---Settings/Volunteers/VolunteersSelect---*/

SELECT 
	--'' as 'options',
	h.ID as 'options',
	v.ID as 'volunteerId',
	h.ID as 'humanId',
	h.breezeId as 'humanBreezeId',
	--v.volunteerIdentifier as 'volunteerBreezeId',
	h.congregationId as 'congregationId',
	h.firstName  as 'firstName',
	ISNULL(h.middleName,'')  as 'middleName',
	h.lastName  as 'lastName',
	ISNULL(h.suffix,'') as 'suffix',
	ISNULL(h.nickname,'')  as 'nickName',
	ISNULL(h.phone,'')  as 'phone',
	FORMAT(h.dob, 'd', 'us') AS 'dob',
	h.genderId as 'genderId',
	hg.genderName as 'genderName',
	ISNULL(h.email ,'')  as 'email',
	prov.id  as 'providerId',
	prov.providerName   as 'providerName',
	cong.id as 'congregationId',
	--prov.providerTypeId  as 'providerTypeId',
	--provType.providerTypeName as 'providerTypeName',
	CAST((CASE WHEN v.timeRetired is null THEN 1 ELSE 0 END)AS BIT) as 'active'


FROM
	staff.Volunteer v
	INNER JOIN  humans.Human h on v.humanId = h.id
	LEFT JOIN  humans.Gender hg ON h.genderId  = hg.id
	LEFT JOIN  organization.Congregation cong ON h.congregationID = cong.id
	LEFT JOIN  organization.Provider prov ON cong.providerId = prov.id
	--LEFT JOIN  organization.ProviderType provType ON prov.providerTypeId = provType.id


WHERE

	{firstName} 
	AND
	{middleName}
	AND
	{lastName}
	AND
	{phone} 
	AND
	{search} 
	AND
	{organization} 
	AND
	{active} 

