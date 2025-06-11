DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

INSERT INTO participant.SuspensionType   (suspensionTypeName  ,timeCreated) VALUES ( :name,@currDate);