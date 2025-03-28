MERGE
	humans.Medications AS [Target]

USING
	(SELECT name = :name) AS [Source] 
    ON [Target].name = [Source].name --- specifies the condition

WHEN MATCHED THEN
	UPDATE SET [Target].timeRetired = NULL, [Target].actor = :actor --UPDATE STATEMENT
	
WHEN NOT MATCHED THEN
	INSERT (name, actor, timeCreated, timeRetired)
	VALUES (:name,:actor, GETDATE(), NULL); --INSERT STATEMENT