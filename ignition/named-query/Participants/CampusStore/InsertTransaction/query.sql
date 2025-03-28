INSERT INTO participant.CampusStore(
  Category,
  ParticipantId,
  timeCreated,
  TotalPoints,
  TransactionPoints,
  Notes
  )
  VALUES(
    :categoryId,
    :participantId,
    GETDATE(),
    /* Retrieve the point total from last transaction and add the point difference */
    (SELECT COALESCE(
      (SELECT TOP 1 store.TotalPoints
        FROM participant.CampusStore AS store
        WHERE store.ParticipantId = :participantId
        ORDER BY timeCreated DESC),
      0) AS points
    ) + :transactionPoints,
    
    :transactionPoints,
     :notes )