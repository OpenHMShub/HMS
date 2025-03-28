SELECT CASE 
	WHEN EXISTS(SELECT 1 FROM lodging.Reservation WHERE bedId = :bedId and timeRetired is NULL and reservationExpiration IS NULL) THEN 1
    ELSE 0 END AS 'bedReserved'
    