DECLARE @retired DATETIME;
-- Set the active filter
IF :active != 1 BEGIN--Active Programs Only
	SET @retired = 1;
END
ELSE BEGIN
	SET @retired = 0;
END
SELECT programId, programName, programDescription, autoEnroll, timeRetired, providerTypes, active, IsResidential
FROM
(
SELECT
	[interaction].[program].id AS 'programId',
	[interaction].[program].programName AS 'programName',
	[interaction].[program].programDescription AS 'programDescription',
	ISNULL([interaction].[program].autoEnroll,0)  AS 'autoEnroll',
	[interaction].[program].timeRetired AS 'timeRetired',
	isNull((SELECT	STRING_AGG(pt.providerTypeName ,', ')
		FROM organization.ProviderType pt
		LEFT JOIN
			interaction.ProgramProviderTypes  ppt ON pt.id = ppt.providerTypeId
		LEFT JOIN
			interaction.Program prg ON ppt.programId  = prg.id
		WHERE prg.id = [interaction].[program].id 
		
		GROUP BY prg.id),'') AS 'providerTypes',
	CASE
		WHEN timeRetired is Null THEN CAST(1 AS BIT)
		ELSE CAST(0 AS BIT)
	END as 'active',
	[interaction].[program].isResidential AS 'IsResidential'
	
FROM
	[interaction].[program]
WHERE
	[interaction].[program].timeRetired is Null
	
OR
	[interaction].[program].timeRetired >
		CASE 
			WHEN @retired = 1 THEN 0
		END
		) x
		WHERE 
		( providerTypes like {searchText} OR
		programName like {searchText} OR  programDescription like {searchText})
ORDER BY programName ASC