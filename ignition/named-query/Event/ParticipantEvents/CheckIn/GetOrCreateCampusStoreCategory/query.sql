Declare @campusStorecategory as INT = NULL

SELECT @campusStorecategory = Id
FROM  participant.CampusStoreCategory 
WHERE Name = :eventName

IF @campusStorecategory IS NULL
BEGIN
INSERT INTO  participant.CampusStoreCategory (Name, CanAdd, CanDeduct) VALUES (:eventName,0,1)
SET @campusStorecategory = @@IDENTITY
END

SELECT @campusStorecategory as campusStorecategory
