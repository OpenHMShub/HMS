/*---Settings/Volunteers/VolunteersSelect---*/

SELECT 
	h.congregationId as 'congregationId',
	prov.providerName   as 'providerName'
	

FROM
	staff.Volunteer v
	LEFT JOIN  humans.human h ON v.humanId = h.id
	LEFT JOIN  organization.Congregation cong ON h.congregationID = cong.id
	LEFT JOIN  organization.Provider prov ON cong.providerId = prov.id
	--LEFT JOIN  organization.ProviderType provType ON prov.providerTypeId = provType.id


WHERE

	v.humanId =  :humanId 

