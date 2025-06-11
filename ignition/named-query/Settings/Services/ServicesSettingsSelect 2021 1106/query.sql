DECLARE @retired DATETIME;
DECLARE @type INT;
-- Set the active filter
IF :active != 1 BEGIN--Active Programs Only
	SET @retired = 1;
END
ELSE BEGIN
	SET @retired = 0;
END
-- service type
IF :type >= 0 BEGIN
	SET @type = :type;
END
ELSE BEGIN
	SET @type = NULL;	
END
SELECT
	[interaction].[service].id AS 'service_id',
	[interaction].[service].serviceName AS 'service_name',
	[interaction].[service].serviceTypeId AS 'type_id',
	[interaction].[servicetype].serviceTypeName AS 'type',
	[interaction].[service].serviceDescription AS 'service_description',
	[interaction].[service].timeRetired AS 'retired'

FROM
	[interaction].[service]
	LEFT JOIN [interaction].[servicetype]
	ON [interaction].[service].serviceTypeId = [interaction].[servicetype].id
WHERE
	(
	[interaction].[service].timeRetired is Null
	OR
	[interaction].[service].timeRetired >
		CASE 
			WHEN @retired = 1 THEN 0
		END
	)
AND
	[interaction].[service].serviceTypeId = ISNULL(@type,serviceTypeId)
ORDER BY service_name ASC