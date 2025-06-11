/*KPI4---Provider/Dashboard/AcceptedReferralsLastNMonths*/
SELECT MONTH(timeCreated), COUNT(id)
FROM participant.Referral
WHERE (timeCreated Between DATEADD(month, -:MonthCount, getDATE()) AND GETDATE())
AND participant.Referral.ProviderId IN (SELECT convert(int, value) FROM string_split(:IdList, ','))
AND participant.Referral.Status_Id = 5
GROUP BY MONTH(timeCreated)
ORDER BY MONTH(timeCreated)

--SELECT YEAR(timeCreated), MONTH(timeCreated), COUNT(id)
--GROUP BY YEAR(timeCreated), MONTH(timeCreated)
--ORDER BY YEAR(timeCreated), MONTH(timeCreated)