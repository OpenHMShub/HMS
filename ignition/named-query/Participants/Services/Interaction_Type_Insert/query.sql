DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

INSERT INTO  interaction.ServiceType 
	(serviceTypeName,
	 timeCreated)
VALUES
	 (:desc
	 ,@currDate);
	