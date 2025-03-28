UPDATE
	participant.StorageBinsLog

SET
	startOn = :startOn,
	expireOn = :expireOn
	
WHERE
	Id = :id