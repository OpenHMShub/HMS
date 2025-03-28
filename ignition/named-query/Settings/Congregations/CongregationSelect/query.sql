DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 6 THEN @thisYear ELSE (@thisYear - 1) END

DECLARE @thisSeasonId int

SELECT @thisSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'

SELECT * FROM
(
SELECT 
	---
	---Congregation Information----
	---
	'' AS 'options',
	CAST((CASE WHEN cong.timeRetired is null THEN 1 ELSE 0 END)AS BIT) as 'active',
	l.id AS 'locationId',
	cong.Id AS 'congregationId',
	prov.id AS 'providerId',
	cong.breezeId AS 'breezeId',
	prov.providerName AS 'congregationName',
	prov.street AS 'congregationAddressLine1',
	ISNULL(prov.street2,'') AS 'congregationAddressLine2',
	prov.city AS 'congregationCity',
	prov.state AS 'congregationState',
	prov.zipCode  AS 'congregationZipCode',
	prov.phone AS 'congregationPhone',
	ISNULL(cong.leader,'') AS 'leader',
	cong.notes AS 'notes',
	cong.hostingSince AS 'hostingSince',
	CAST((CASE WHEN lastActionDate IS NULL THEN 0
	ELSE 1 END) AS BIT) as updatedThisSeason,
	
	( 
	SELECT TOP 1 CONCAT_WS(' ',hcp.firstName,hcp.lastName)
	FROM shelter.Coordinator pcoord, humans.human hcp 
	WHERE isPrimary = 1 AND l.id = pcoord.locationId
	AND pcoord.humanId = hcp.id
	ORDER BY pcoord.timeCreated desc
	)  AS 'coordinatorName',
	CAST(CASE WHEN sch.bedsProjected IS NOT NULL AND sch.bedsProjected > 0 then 1 else 0 END  as bit) as 'registered'
	
FROM organization.Congregation cong
LEFT JOIN 
	organization.Provider prov ON cong.providerId = prov.id
LEFT JOIN
	shelter.Location l ON cong.id = l.congregationId --prov.providerName =  l.locationName
LEFT JOIN (SELECT locationId, max(actionDate) as lastActionDate
 FROM shelter.CongregationLog
 WHERE action = 'Edit Congregation' and actionFields = 'Password' and actionDate >= DATEFROMPARTS(@thisSeasonStartYear, 6, 1)
 group by locationId) editData ON cong.id = editData.locationId

LEFT JOIN ( SELECT locationId, seasonId , sum(totalBeds) as bedsProjected
FROM shelter.Schedule 
WHERE timeCancelled is NULL and seasonId = @thisSeasonId
GROUP BY locationId, seasonId ) sch ON l.id = sch.locationId
WHERE	
	 {active}
	 AND
	 {name}
	 AND
	 {city}
	 AND
	 {zip}
	 AND
	 {leader}
	 AND
	 {search} 
	 AND
	  {registered} 
	 AND 
	  {reset} 
) x
WHERE {coordinator}
ORDER BY x.congregationName
