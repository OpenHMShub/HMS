SELECT
	
	l.id AS 'locationId'
	
	
FROM organization.Congregation cong
LEFT JOIN 
	organization.Provider prov ON cong.providerId = prov.id
LEFT JOIN
	shelter.Location l ON cong.id = l.congregationId --prov.providerName =  l.locationName
WHERE	
	 prov.providerName =  :name 
