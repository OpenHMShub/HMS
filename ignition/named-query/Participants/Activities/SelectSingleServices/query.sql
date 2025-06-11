/*---Participants/Activities/SelectSingleServices---*/
Declare @ServiceID as int = :ServiceID;

SELECT
	[participant].[services].employeeId as LeaderID
,	CONCAT_WS(' ',[humans].[Human].firstName,[humans].[Human].middleName,[humans].[Human].lastName) as Leader
,	[interaction].[program].programName AS Program
,	[interaction].[service].serviceName AS Service
, 	[participant].[services].comment as Comment
--,	CAST(CASE WHEN isnull([participant].[CaseNotesServices].id,0) = 0 THEN 0 Else 1 END as bit) as CaseNote
FROM
	[participant].[services]
	LEFT JOIN [interaction].[program]
	ON [participant].[services].programid = [interaction].[program].id
	LEFT JOIN [interaction].[service]
	ON [participant].[services].Serviceid = [interaction].[service].id
	LEFT JOIN staff.Employee
	ON [participant].[services].employeeId = [staff].[Employee].Id
	LEFT JOIN [humans].[Human] 
	ON [staff].[Employee].humanId = [humans].[Human].id
--	LEFT JOIN [participant].[CaseNotesServices]
--	ON [participant].[services].Serviceid = [participant].[CaseNotesServices].id
WHERE [participant].[services].id = @ServiceID
