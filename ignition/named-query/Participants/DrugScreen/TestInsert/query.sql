--DECLARE @currDate DATETIME;
--SET @currDate = GETDATE();

--INSERT INTO  participant.DrugScreenReason   ( DrugScreenReasonDescription, DrugScreenReasonName,timeCreated) VALUES (:desc,:name,@currDate);
Delete from  participant.DrugScreenReason where id =4