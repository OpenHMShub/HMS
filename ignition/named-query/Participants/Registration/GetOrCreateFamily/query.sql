Declare @familyId as INT = NULL

SELECT TOP 1 @familyId = id
FROM humans.family
WHERE surname = :familyName
ORDER BY timeCreated DESC

IF @familyId IS NULL
BEGIN
INSERT INTO humans.family(surname, timeCreated) VALUES (:familyName, CURRENT_TIMESTAMP)
SET @familyId = @@IDENTITY
END

SELECT @familyId as familyId
