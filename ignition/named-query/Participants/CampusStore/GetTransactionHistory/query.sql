SELECT 
	store.TransactionPoints,
	store.TotalPoints,
	store.timeCreated,
	cat.name AS Category,
	COALESCE(store.Notes, '') as Notes,
	store.eventDate
FROM participant.CampusStore AS store
	LEFT JOIN participant.CampusStoreCategory AS cat 
		ON store.Category = cat.id
WHERE store.ParticipantId = :participantId
ORDER BY timeCreated DESC