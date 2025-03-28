UPDATE
	participant.StorageBinsLog

SET
	cancelledOn = GETDATE(),
	cancelledByStaffEmployeeId = :employeeId

WHERE
	col = :col
		AND
	bin = :bin
		AND
	participantId = :participantId
		AND
	

VALUES
(
	:col,
	:bin,
	:participantId,
	GETDATE(),
	:employeeId,
	:startOn,
	:expireOn
)