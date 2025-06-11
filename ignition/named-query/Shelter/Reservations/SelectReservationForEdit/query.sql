SELECT id, bedId, participantId, reservationStart, reservationEnd
from lodging.Reservation
where id = :reservationID