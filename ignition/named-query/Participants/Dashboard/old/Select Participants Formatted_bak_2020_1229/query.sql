---Participants/Dashboard/Select Participants Formatted---
WITH 
	susp as (SELECT * FROM (
		SELECT participantId,timeEnd,timeCreated,row_number() OVER (PARTITION BY participantId ORDER BY timeBegin DESC) as 'rk'
		FROM participant.Suspension
		)sus
		WHERE sus.rk = 1
	),
	blt as (SELECT * FROM (
		SELECT bedId,participantId,eventStart,eventEnd,row_number() OVER (PARTITION BY participantId ORDER BY eventStart DESC) as 'rk'
		FROM lodging.BedLog
		) bl
		WHERE bl.rk = 1
	)
SELECT 
	p.[id] as 'ID',
	h.[firstName],
    ISNULL(h.[middleName],'') as 'middleName',
	h.[lastName],
    '***-**-'+RIGHT(ss.[ssn],4) as 'ssn',
	h.[dob] AS 'BirthDate',
	h.[gender] AS 'Gender',
	h.[veteran],
    h.[timeCreated] AS 'LastRegistration',
    '1/2/1900' AS 'LastAction',
    --CASE WHEN susp.timeCreated is NULL THEN CAST(0 AS BIT)
    	--WHEN susp.timeCreated is NOT NULL THEN 
    		--CASE WHEN susp.timeEnd IS NULL THEN CAST(1 AS BIT)
    			--WHEN susp.timeEnd IS NOT NULL AND susp.timeEnd > CURRENT_TIMESTAMP THEN CAST(1 AS BIT)
    		--ELSE CAST(0 AS BIT) END
    	--ELSE CAST(0 AS BIT) END AS 'Suspension',
    p.suspensionActive AS 'Suspension', 
    CASE WHEN blt.eventStart is NULL THEN ''
    	WHEN blt.eventStart is NOT NULL THEN 
    		CASE WHEN blt.eventEnd IS NULL THEN [lodging].[Facility].[facilityName]
    			WHEN blt.eventEnd IS NOT NULL AND blt.eventEnd > CURRENT_TIMESTAMP THEN [lodging].[Facility].[facilityName]
    		ELSE '' END
    	ELSE '' END AS 'Shelter',
    '' AS 'Options',
    h.[firstName] + ' ' + ISNULL(h.[middleName],'') + ' ' + h.[lastName] AS 'Name'
FROM [participant].[Participant] p
	LEFT JOIN [humans].[Human] h ON h.[id] = p.[humanId]
	LEFT JOIN [humans].[SSN] ss ON h.[id] = ss.[humanId]
	LEFT JOIN susp ON susp.participantId = p.id
	LEFT JOIN blt ON blt.participantId = p.id
	LEFT JOIN [lodging].[Bed] ON [lodging].[Bed].[id] = blt.[bedId]
	LEFT JOIN [lodging].[Room] ON [lodging].[Room].[id] = [lodging].[Bed].[roomId]
	LEFT JOIN [lodging].[Facility] ON [lodging].[Facility].[id] = [lodging].[Room].[facilityId]
WHERE p.timeRetired is null
	AND ((h.[gender] Like :genderStr+'%') OR h.[gender] IS NULL)
	AND ((h.[dob] BETWEEN :startDOB AND :endDOB) OR h.[dob] IS NULL) 
--ORDER BY h.lastName DESC
--ORDER BY LastRegistration DESC
 
