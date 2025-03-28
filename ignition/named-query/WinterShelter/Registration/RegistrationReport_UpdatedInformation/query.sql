SELECT 	DISTINCT
		---
		---Congregation Information----
		---
		
		prov.id AS 'providerId',
		prov.providerName AS 'congregationName',

		
		sea.seasons AS 'currentSeason',
		prov.street AS 'congregationAddressLine1',
		ISNULL(prov.street2,'') AS 'congregationAddressLine2',
		ISNULL(prov.city,'') AS 'congregationCity',
		ISNULL(prov.state,'') AS 'congregationState',
		prov.zipCode AS 'congregationZipCode',

		ISNULL(prov.phone,'') AS 'congregationPhone',
		---
		---location information---
		---
		loc.hostLocal AS 'hostLocal',
		ls.hostLocationTypeId AS 'hostLocationTypeId',
		lst.HostLocationType AS 'hostLocationType',
		ls.locationId AS 'locationId',
		loc.locationName AS 'locationName',
		ISNULL(loc.addressLine1,'') AS 'locationAddressLine1',
		ISNULL(loc.addressLine2,'') AS 'locationAddressLine2',
		ISNULL(loc.city,'') AS 'locationCity',
		ISNULL(loc.state,'') AS 'locationState',
		ISNULL(loc.zipCode,'') AS 'locationZipCode',
		loc.timeCreated AS 'locationDateCreated',

		---
		---Primary Coordinator Information---

		hcp.id AS 'coordinatorHumanId',
		hcp.firstName AS 'coordinatorFirstName',
		hcp.lastName AS 'coordinatorLastName',
		CONCAT_WS(' ',hcp.firstName,hcp.lastName) AS 'coordinatorName',
		hcp.nickname as 'coordinatorNickname', 
		ISNULL(hcp.street,'') AS 'coordinatorAddress',
		ISNULL(hcp.city,'') AS 'coordinatorCity',
		ISNULL(hcp.state,'') AS 'coordinatorState',
		ISNULL(hcp.zipCode,'') AS 'coordinatorZipCode',
		ISNULL(hcp.phone,'') AS 'coordinatorPhone', 
		ISNULL(hcp.altPhone,'') AS 'coordinatorAltPhone', 
		ISNULL(hcp.email,'') AS 'coordinatorEmail', 
		hcp.preferredCommunication AS 'coordinatorPreferredCommunication',
		ISNULL(scp.notes,'') AS 'coordinatorNotes',
		---
		---Secondary Coordinator Information---
		CAST (ISNULL(hcs.id,0) AS BIT) AS 'hasBackupCoordinator',
		
		hcs.id AS 'secondaryCoordinatorHumanId',
		hcs.firstName AS 'secondaryCoordinatorFirstName',
		hcs.lastName AS 'secondaryCoordinatorLastName',
		CONCAT_WS(' ',hcs.firstName,hcs.lastName) AS 'secondaryCoordinatorName',
		hcs.nickname as 'secondaryCoordinatorNickname', 
		ISNULL(hcs.street,'') AS 'secondaryCoordinatorAddress',
		ISNULL(hcs.city,'') AS 'secondaryCoordinatorCity',
		ISNULL(hcs.state,'') AS 'secondaryCoordinatorState',
		ISNULL(hcs.zipCode,'') AS 'secondaryCoordinatorZipCode',
		ISNULL(hcs.phone,'') AS 'secondaryCoordinatorPhone', 
		ISNULL(hcs.altPhone,'') AS 'secondarycoordinatorAltPhone', 
		ISNULL(hcs.email,'') AS 'secondaryCoordinatorEmail', 
		hcs.preferredCommunication AS 'secondaryCoordinatorPreferredCommunication',
		ISNULL(scs.notes,'') AS 'secondaryCoordinatorNotes',
		---
		----Location Features----
		----
		
		ls.seasonId, 
		ls.beds as 'capacity',
		
		ls.nights as 'nightsInt',
		cast(ls.nights & 1 as bit) as 'sunday',
		cast(ls.nights & 2 as bit) as 'monday',
		cast(ls.nights & 4 as bit) as 'tuesday',
		cast(ls.nights & 8 as bit) as 'wednesday',
		cast(ls.nights & 16 as bit) as 'thursday',
		cast(ls.nights & 32 as bit) as 'friday',
		cast(ls.nights & 64 as bit) as 'saturday',
		
		ls.genderId as 'genderId',
		ISNULL(g.genderAccepted,'') as 'genderAccepted',
		ISNULL(ls.families,0) as 'families',  
		ISNULL(ls.extraShortNotice,0) as 'extraShortNotice', 
		ISNULL(ls.showers,0) as 'showers',
		ISNULL(ls.clothing,0) as 'clothing',
		ISNULL(ls.laundry,0) as 'laundry',
		ISNULL(ls.sackLunches,0) as 'sackLunches',
		ISNULL(ls.breakfast,0) as 'breakfast',
		ISNULL(ls.dinner,0) as 'dinner',
		ISNULL(ls.haircuts,0) as 'haircuts',
		ISNULL(ls.hygieneItems,0) as 'hygieneItems',
		ISNULL(ls.otherService,0) as 'otherService',
		ls.otherServiceList as 'otherServiceList',
		ISNULL(ls.accessible,0) as 'accessible',
		ISNULL(ls.stairs,0) as 'stairs', 
		ISNULL(ls.smoking,0) as 'smoking',
		ISNULL(ls.partners ,'') as 'partners',
		ISNULL(ls.serviceNotes,'') as 'serviceNotes',
		ls.timeCreated as 'timeCreated',
		ISNULL(ls.bedsProjected,'') as 'bedsProjected',
		ls.bedsActual as 'bedsActual',
		--ISNULL(ls.notes,'') as 'registrationNotes',
		CONCAT(ISNULL(scp.notes,''), 
			case when ISNULL(scp.notes,'')!='' then CHAR(10) else '' end, ISNULL(scs.notes,''),
			case when ISNULL(scs.notes,'')!='' then CHAR(10) else '' end, ISNULL(ls.serviceNotes,''),
			case when ISNULL(ls.serviceNotes,'')!='' then CHAR(10) else '' end, ISNULL(ls.scheduleComments,'')) as 'registrationNotes',	
		
		---
		---Schedule Info---
		---Actual schedule is via a seperate query---
		---
		ISNULL(ls.scheduleComments,'') as 'scheduleComments',
		ISNULL(ls.reminderCall,0) as 'reminderCall',
		ISNULL(ls.otherHostMore,'') as 'otherHostmore',
		'' as 'options',
		
		--- Transportation Info ---
	
		ISNULL(t.transportType,'None') as 'Transport',
		
		--- Frequency Info ---
		ISNULL(f.frequencyType,'') as 'Frequency',
--		ls.frequencyId,
	
		ls.dateSelectionPattern,
		ISNULL(ls.dateSelectionDays,'[]') as 'dateSelectionDays',
		-- ls.hostMoreIds,
		(SELECT STRING_AGG( hostMoreId , ',') FROM shelter.HostMoreLocation where locationId =  :locationId  and seasonId =  :seasonId  ) as hostMoreIds,
		(SELECT scheduleDaysOfTheYear FROM shelter.LocationRegistrationDetails where locationId =  :locationId  and seasonId =  :seasonId  ) as scheduleDaysOfTheYear,
		cong.leader,
		ISNULL(ls.pickupTime, '') as pickupTime,
		
		(SELECT STRING_AGG( dayOfYear , ',') FROM shelter.Schedule where locationId =  :locationId  and seasonId =  :seasonId AND timeCancelled IS NULL ) as newScheduleDays
		
FROM
	shelter.LocationSeasonal ls 
LEFT JOIN 
	shelter.Location loc ON loc.id = ls.locationId
LEFT JOIN
	shelter.HostLocationType lst ON ls.hostLocationTypeId = lst.id
LEFT JOIN
	shelter.Transport st ON ls.transportId = st.id
LEFT JOIN
	shelter.TransportType t ON st.transportTypeId =  t.id
LEFT JOIN
	shelter.Frequency sf ON ls.frequencyId = sf.id
LEFT JOIN
	shelter.FrequencyType f ON sf.frequencyTypeId = f.id
LEFT JOIN 
	shelter.Gender g ON ls.genderId = g.id
LEFT JOIN 
	shelter.Seasons sea ON ls.seasonId = sea.id

LEFT JOIN 
	( SELECT * FROM shelter.Coordinator WHERE isPrimary = 1 ) scp ON loc.id = scp.locationId 
LEFT JOIN
	humans.human hcp ON scp.humanId= hcp.id
LEFT JOIN 
	( SELECT * FROM shelter.Coordinator WHERE isPrimary = 0 )  scs ON loc.id = scs.locationId 

LEFT JOIN

	humans.human hcs ON scs.humanId = hcs.id
---First Season
LEFT JOIN 
	shelter.Seasons seaf ON ls.seasonId = seaf.id	
LEFT JOIN  organization.Congregation cong ON  loc.congregationId = cong.id

LEFT JOIN 
	organization.Provider prov ON cong.providerId =  prov.id 

WHERE

	ls.seasonId = :seasonId 
	AND
	ls.locationId = :locationId 
