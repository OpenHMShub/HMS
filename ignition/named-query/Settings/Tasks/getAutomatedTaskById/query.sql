SELECT *
FROM  participant.AutomatedTaskType 
WHERE :taskId IS NULL or :taskId = -1 or id =  :taskId 