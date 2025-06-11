DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

INSERT INTO  participant.CaseNoteType   ( CaseNoteTypeName,timeCreated) VALUES (:name,@currDate);
