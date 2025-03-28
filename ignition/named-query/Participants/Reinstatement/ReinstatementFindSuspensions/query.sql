	SELECT DISTINCT
		[participant].[SuspensionDashboard].participantId,
		[participant].[SuspensionDashboard].name,
		[participant].[SuspensionDashboard].DateEndRevised
	FROM
		[participant].[SuspensionDashboard]
	WHERE
		[participant].[SuspensionDashboard].suspensionActive = 1
		AND
		[participant].[SuspensionDashboard].reinstateRequired = 0
		AND
		[participant].[SuspensionDashboard].DateEndRevised < GetDate()