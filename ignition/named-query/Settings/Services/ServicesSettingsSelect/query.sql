DECLARE @retired DATETIME;
DECLARE @type INT;
-- Set the active filter
IF :active != 1 BEGIN--Active Programs Only
	SET @retired = 1;
END
ELSE BEGIN
	SET @retired = 0;
END

SELECT serviceId, serviceName, serviceDescription,timeRetired, programNames, active, allowUnder18
FROM
(
SELECT
	[interaction].[service].id AS 'serviceId',
	[interaction].[service].serviceName AS 'serviceName',
	
	isNull([interaction].[service].serviceDescription,'') AS 'serviceDescription',
	[interaction].[service].timeRetired AS 'timeRetired',
	isNull((SELECT	STRING_AGG(p.programName,', ')
		FROM interaction.Program  p
		LEFT JOIN
			interaction.ProgramService  ps ON p.id = ps.programId 
		--LEFT JOIN
		--	interaction.Program prg ON ppt.programId  = prg.id
		WHERE ps.serviceId  = [interaction].[service].id
		GROUP BY ps.serviceId),'') AS 'programNames',
	CASE
		WHEN [interaction].[service].timeRetired is Null THEN CAST(1 AS BIT)
		ELSE CAST(0 AS BIT)
	END as 'active',
	isNull([interaction].[service].allowUnder18,0) AS 'allowUnder18'

FROM
	[interaction].[service]
	
WHERE
	(
	[interaction].[service].timeRetired is Null
	OR
	[interaction].[service].timeRetired >
		CASE 
			WHEN @retired = 1 THEN 0
		END
	)

	) x
	WHERE 
	( serviceName LIKE 	 {searchText}  OR 
		
		serviceDescription  LIKE 	 {searchText}  OR
		programNames  LIKE 	 {searchText}  )
ORDER BY serviceName ASC