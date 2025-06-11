DECLARE @currDate DATETIME;
SET @currDate = GETDATE();

INSERT INTO  participant.ReinstatementLog   
	(participantId,suspensionId,Comment,userName,timeCreated)
VALUES
	(:participant_id,:suspension_id,:comment,:user_name,@currDate);