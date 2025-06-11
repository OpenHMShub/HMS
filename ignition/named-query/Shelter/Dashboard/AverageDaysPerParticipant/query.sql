DECLARE @totalOccupants INT
DECLARE @totalOccupiedDays INT


-- find distinct no of participants
SELECT @totalOccupants = count(distinct(participantId))
from lodging.BedLog
 
select @totalOccupiedDays = sum(DATEDIFF(day, eventStart, eventEnd))
from lodging.BedLog 

SELECT @totalOccupiedDays, @totalOccupants