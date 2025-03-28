SELECT 	DISTINCT
		---
		---Congregation Information----
		---
		
		prov.id AS 'providerId',
		prov.providerName AS 'congregationName',

		
		sea.seasons AS 'currentSeason',
		ls.congregationStreet AS 'congregationAddressLine1',
		ISNULL(ls.congregationStreet2,'') AS 'congregationAddressLine2',
		ISNULL(ls.congregationCity,'') AS 'congregationCity',
		ISNULL(ls.congregationState,'') AS 'congregationState',
		ls.congregationZip  AS 'congregationZipCode',

		ISNULL(ls.congregationPhone,'') AS 'congregationPhone',
		---
		---location information---
		---
		ls.hostLocal AS 'hostLocal',
		ls.hostLocationTypeId AS 'hostLocationTypeId',
		lst.HostLocationType AS 'hostLocationType',
		ls.locationId AS 'locationId',
		loc.locationName AS 'locationName',
		ISNULL(ls.hostLocationStreet,'') AS 'locationAddressLine1',
		ISNULL(ls.hostLocationStreet2,'') AS 'locationAddressLine2',
		ISNULL(ls.hostLocationCity,'') AS 'locationCity',
		ISNULL(ls.hostLocationState,'') AS 'locationState',
		ISNULL(ls.hostLocationZip,'') AS 'locationZipCode',
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
		ls.primaryCoordPrefCommunication AS 'coordinatorPreferredCommunication',
		ISNULL(ls.primaryCoordNotes,'') AS 'coordinatorNotes',
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
		ls.secondaryCoordPrefCommunication AS 'secondaryCoordinatorPreferredCommunication',
		ISNULL(ls.secondaryCoordNotes,'') AS 'secondaryCoordinatorNotes',
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
		CONCAT(ISNULL(ls.primaryCoordNotes,''), 
			case when ISNULL(ls.primaryCoordNotes,'')!='' then CHAR(10) else '' end, ISNULL(ls.secondaryCoordNotes,''),
			case when ISNULL(ls.secondaryCoordNotes,'')!='' then CHAR(10) else '' end, ISNULL(ls.serviceNotes,''),
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
		ls.hostMoreIds,
		ls.scheduleDaysOfTheYear,
		cong.leader,
		ISNULL(ls.pickupTime, '') as pickupTime,
		
		(SELECT STRING_AGG( dayOfYear , ',') FROM shelter.Schedule where locationId =  :locationId  and seasonId =  :seasonId AND timeCancelled IS NULL ) as newScheduleDays
		
FROM
	shelter.LocationRegistrationDetails ls 
LEFT JOIN 
	shelter.Location loc ON loc.id = ls.locationId
LEFT JOIN
	shelter.HostLocationType lst ON ls.hostLocationTypeId = lst.id
LEFT JOIN
	shelter.TransportType t ON ls.transportTypeId =  t.id
LEFT JOIN
	shelter.FrequencyType f ON ls.frequencyTypeId = f.id
LEFT JOIN 
	shelter.Gender g ON ls.genderId = g.id
LEFT JOIN 
	shelter.Seasons sea ON ls.seasonId = sea.id

LEFT JOIN 
	organization.Provider prov ON ls.congregationProviderId = prov.id
LEFT JOIN

	humans.human hcp ON ls.primaryCoordHumanId = hcp.id
LEFT JOIN

	humans.human hcs ON ls.secondaryCoordHumanId = hcs.id
---First Season
LEFT JOIN 
	shelter.Seasons seaf ON ls.seasonId = seaf.id	

LEFT JOIN  organization.Congregation cong ON  cong.providerId =  prov.id
WHERE

	ls.seasonId = :seasonId 
	AND
	ls.locationId = :locationId 
