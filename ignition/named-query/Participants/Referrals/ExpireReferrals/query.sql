UPDATE [participant].[Referral] 
SET Status_Id = 10
WHERE Status_Id = 5  AND DATEDIFF(day, timeCreated, CURRENT_TIMESTAMP) > 90