UPDATE
	lodging.Reservation
SET
	programId = :programId
WHERE
	id = (select reservationId from lodging.BedLog where id = :bedLogId)