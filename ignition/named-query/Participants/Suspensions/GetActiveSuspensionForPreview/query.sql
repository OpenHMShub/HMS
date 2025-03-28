SELECT
	id as 'id',
	
	
	suspensionTypeNameRevised as 'suspension_type_name',
	
	dateBegin as 'suspension_time_begin',
	dateEndRevised as 'suspension_time_end'
FROM
	[participant].[SuspensionDashboard]
	
WHERE
	participantId =  :participant_id  
	AND suspensionActive = 1
	ORDER BY dateBegin desc
