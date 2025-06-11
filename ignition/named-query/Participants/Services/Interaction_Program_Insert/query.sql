DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

INSERT INTO  interaction.Program 
	(programName,
	 timeCreated)
VALUES
	 (:desc
	 ,@currDate);
	