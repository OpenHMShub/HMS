/*KPI3---/Providers/Detail/Summary/KPI/Graph_Flex_bar*/
SELECT MONTH(timeCreated), COUNT(ProviderID)
FROM participant.Referral
WHERE (timeCreated Between DATEADD(month, -:MonthCount, getDATE()) AND GETDATE())
AND [participant].[Referral].ProviderID = :ProviderID
GROUP BY MONTH(timeCreated)
ORDER BY MONTH(timeCreated)