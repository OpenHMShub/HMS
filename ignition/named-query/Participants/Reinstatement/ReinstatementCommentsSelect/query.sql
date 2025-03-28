SELECT
	[participant].[ReinstatementLog].id as 'id',
	[participant].[ReinstatementLog].timeCreated as 'time_created',
	[participant].[ReinstatementLog].suspensionTypeId as 'suspension_type_id',
	[participant].[SuspensionType].suspensionTypeName as 'suspension_type_name',
	[participant].[ReinstatementLog].duration as 'duration',
	CASE
	    WHEN duration = 1 THEN '1 Day'
    	WHEN duration = 7  THEN '1 Week'
    	WHEN duration = 14 THEN '2 Weeks'
    	WHEN duration = 30 THEN '30 Days'
    	WHEN duration = 60 THEN '60 Days'
    	WHEN duration = 90 THEN '90 Days'
    	WHEN duration = 365  THEN '1 Year'
    	WHEN duration = 3650  THEN 'Indefinite'
    	ELSE 'Other'
	END AS durationText,
	[participant].[ReinstatementLog].timeBegin as 'dateBegin',
	[participant].[ReinstatementLog].timeEnd as 'dateEnd',
	[participant].[ReinstatementLog].Comment as 'comment'
	

FROM
	[participant].[ReinstatementLog]
	LEFT JOIN [participant].[SuspensionType] ON [participant].[SuspensionType].id = [participant].[ReinstatementLog].suspensionTypeId
WHERE
	[participant].[ReinstatementLog].suspensionId =  :suspension_id
ORDER BY time_created ASC