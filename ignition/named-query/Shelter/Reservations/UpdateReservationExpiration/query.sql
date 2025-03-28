DELETE FROM participant.Enrollments 
WHERE id IN(
	select e.id FROM participant.Enrollments e
	where e.particpantId in (select participantId from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd < CURRENT_TIMESTAMP)
	and e.programId in (select programId from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd < CURRENT_TIMESTAMP)
	and (select id from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd > CURRENT_TIMESTAMP and participantId=e.particpantId and programId=e.programId) IS NULL
)	

DELETE FROM [participant].[ProgramsHistory]
WHERE id IN(
	select ph.id FROM [participant].[ProgramsHistory] ph
		where ph.participantId in (select participantId from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd < CURRENT_TIMESTAMP)
		and ph.programId in (select programId from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd < CURRENT_TIMESTAMP)
		and ph.ExitDate IS NULL
		and (select id from lodging.Reservation where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd > CURRENT_TIMESTAMP and participantId=ph.participantId and programId=ph.programId) IS NULL
)	

UPDATE R
SET R.Status_Id = 10 
FROM participant.referral R
JOIN lodging.Reservation res
ON res.participantId = R.participantId and res.programId = R.programId and res.providerId = R.providerId
and res.timeRetired is null and (res.reservationExpiration is null or res.reservationExpiration = '') and res.reservationEnd < CURRENT_TIMESTAMP

Update lodging.Reservation 
set reservationExpiration = reservationEnd, referralStatus = 'No-Show',timeRetired = reservationEnd
where timeRetired is null and (reservationExpiration is null or reservationExpiration = '') and reservationEnd < CURRENT_TIMESTAMP

