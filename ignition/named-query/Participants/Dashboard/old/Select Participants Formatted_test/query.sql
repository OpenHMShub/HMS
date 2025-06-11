---Participants/Dashboard/Select Participants Formatted_test---
DECLARE %startDOB as date = :startDOB;
--DECLARE %endDOB as DATETIME = :endDOB;
--DECLARE %gender as nvarchar(max) = :genderStr;
/*
WITH 
	blt as (SELECT * FROM (
		SELECT bedId,participantId,eventStart,eventEnd,row_number() OVER (PARTITION BY participantId ORDER BY eventStart DESC) as 'rk'
		FROM lodging.BedLog
		) bl
		WHERE bl.rk = 1
	)
*/
SELECT 
	p.[id] as "ID",
	--"" AS "Options",
	p.suspensionActive AS 'Suspension', 
	h.[firstName],
    --ISNULL(h.[middleName],"") as "middleName",
	h.[lastName],
    --"***-**-"+RIGHT(ss.[ssn],4) as "ssn",
	h.[dob] AS "BirthDate",
	h.[gender] AS "Gender",
	h.[veteran],
    h.[timeCreated] AS "LastRegistration",
    --"1/2/1900" AS "LastAction",
    CONCAT_WS(" ",h.firstName, h.middleName, h.lastName) AS "Name" 
    /*
    CASE WHEN blt.eventStart is NULL THEN ''
    	WHEN blt.eventStart is NOT NULL THEN 
    		CASE WHEN blt.eventEnd IS NULL THEN [lodging].[Facility].[facilityName]
    			WHEN blt.eventEnd IS NOT NULL AND blt.eventEnd > CURRENT_TIMESTAMP THEN [lodging].[Facility].[facilityName]
    		ELSE '' END
    	ELSE '' END AS 'Shelter',
    */


FROM [participant].[Participant] p
	LEFT JOIN [humans].[Human] h ON  p.[humanId] = h.[id]
	LEFT JOIN [humans].[SSN] ss ON p.humanId = ss.humanid
	--LEFT JOIN blt ON blt.participantId = p.id
	--LEFT JOIN [lodging].[Bed] ON [lodging].[Bed].[id] = blt.[bedId]
	--LEFT JOIN [lodging].[Room] ON [lodging].[Room].[id] = [lodging].[Bed].[roomId]
	--LEFT JOIN [lodging].[Facility] ON [lodging].[Facility].[id] = [lodging].[Room].[facilityId]
WHERE p.timeRetired is null
	--AND ((h.[gender] Like :genderStr+'%') OR h.[gender] IS NULL)
	--AND ((h.[dob] BETWEEN :startDOB AND :endDOB) OR h.[dob] IS NULL) 
--ORDER BY h.lastName DESC
--ORDER BY LastRegistration DESC
 
