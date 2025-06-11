/*---Participants/Activities/SelectSingleReinstatement---*/
Declare @ReinstatmentID as int = :ReinstatementID ;

SELECT
	participant.[SuspensionType].suspensionTypeName as 'suspension_type',
	[participant].[ReinstatementLog].duration as 'duration',
	[participant].[ReinstatementLog].timeBegin as 'time_begin',
	[participant].[ReinstatementLog].timeEnd as 'time_end',
 	[participant].[ReinstatementLog].Comment as 'comment'
FROM [participant].[ReinstatementLog]
LEFT JOIN [participant].[SuspensionType]
ON [participant].[ReinstatementLog].suspensionTypeId = [participant].[SuspensionType].id
Where [participant].[ReinstatementLog].id = @ReinstatmentID