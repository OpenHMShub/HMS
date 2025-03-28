---Shelter/CurrentResidents/CurrentResidentsPerShelter---
SELECT participantId
from
lodging.BedLog
WHERE participantId =  :participantId AND
eventStart <= CURRENT_TIMESTAMP and eventEnd IS NULL