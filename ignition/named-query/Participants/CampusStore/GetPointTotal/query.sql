/**
 * Selects the total number of points recorded on the last transaction. If no transaction
 * exists for the participant then 0 is returned.
**/
SELECT COALESCE(
  (SELECT TOP 1 store.TotalPoints
    FROM participant.CampusStore AS store
    WHERE store.ParticipantId = :participantId
    ORDER BY timeCreated DESC),
  0) AS points
  