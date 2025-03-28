SELECT DISTINCT
	[participant].[SuspensionDashboard].participantId
FROM
	[participant].[SuspensionDashboard]
WHERE
	[participant].[SuspensionDashboard].suspensionActive = 1
	AND [participant].[SuspensionDashboard].reinstateRequired = 0
	AND [participant].[SuspensionDashboard].DateEndRevised < GetDate()
	AND [participant].[SuspensionDashboard].dateReinstated IS NULL