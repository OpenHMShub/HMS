DECLARE @feb_days int, @startYear int, @endYear int
SET @feb_days = CASE WHEN CAST(SUBSTRING(:fiscalYear, 6, 9) AS INT) % 4 = 0 THEN 29 ELSE 28 END
SET @startYear = CAST(SUBSTRING(:fiscalYear, 1, 4) AS INT)
SET @endYear = CAST(SUBSTRING(:fiscalYear, 6, 9) AS INT)

-- Set Bed Count to variable
DECLARE @july_value_BedCount int, @aug_value_BedCount int, @sept_value_BedCount int, @oct_value_BedCount int, @nov_value_BedCount int, @dec_value_BedCount int, @jan_value_BedCount int, @feb_value_BedCount int, @march_value_BedCount int, @april_value_BedCount int, @may_value_BedCount int, @june_value_BedCount int

SET @july_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 7, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 7, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 7, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 7, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 7, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 7, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 7, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 7, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 7, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 7, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 7, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 7, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 7, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 7, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 7, 1,00,00,00,000), DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 7, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 7, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 7, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 7, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 7, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 7, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 7, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 7, 31)))
							AND DATETIMEFROMPARTS(@startYear, 7, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
							AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @aug_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 8, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 8, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 8, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 8, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 8, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 8, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 8, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 8, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 8, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 8, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 8, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 8, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 8, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000), DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 8, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 8, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 8, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 8, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 8, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 8, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 8, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 8, 31)))
							AND DATETIMEFROMPARTS(@startYear, 8, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
							AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @sept_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 9, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 9, 30)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 9, 30)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 9, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 9, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 9, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 9, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 9, 30)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 9, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 9, 30)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 9, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 9, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 9, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000), DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 9, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 9, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 9, 30)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 9, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 9, 30))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 9, 30))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 9, 30) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 9, 30)))
						AND DATETIMEFROMPARTS(@startYear, 9, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @oct_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 10, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 10, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 10, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 10, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 10, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 10, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 10, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 10, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 10, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 10, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 10, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 10, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 10, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000), DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 10, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 10, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 10, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 10, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 10, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 10, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 10, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 10, 31)))
						AND DATETIMEFROMPARTS(@startYear, 10, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @nov_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 11, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 11, 30)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 11, 30)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 11, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 11, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 11, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 11, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 11, 30)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 11, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 11, 30)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 11, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 11, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 11, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000), DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 11, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 11, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 11, 30)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 11, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 11, 30))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 11, 30))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 11, 30) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 11, 30)))
						AND DATETIMEFROMPARTS(@startYear, 11, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @dec_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 12, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 12, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@startYear, 12, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@startYear, 12, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 12, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 12, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 12, 1) and CAST(eventStart AS DATE)<=datefromparts(@startYear, 12, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@startYear, 12, 1) and CAST(eventEnd AS DATE)<=datefromparts(@startYear, 12, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@startYear, 12, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@startYear, 12, 1) and CAST(eventEnd AS DATE)>datefromparts(@startYear, 12, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@startYear, 12, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@startYear, 12, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 12, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 12, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@startYear, 12, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 12, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@startYear, 12, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@startYear, 12, 31)))
						AND DATETIMEFROMPARTS(@startYear, 12, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @jan_value_BedCount = (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 1, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 1, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 1, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 1, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 1, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 1, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 1, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 1, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 1, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 1, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 1, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 1, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 1, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 1, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 1, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 1, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 1, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 1, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 1, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 1, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 1, 31)))
						AND DATETIMEFROMPARTS(@endYear, 1, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @feb_value_BedCount = (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 2, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 2, @feb_days)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 2, @feb_days)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 2, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 2, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 2, @feb_days)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 2, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 2, @feb_days)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 2, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 2, @feb_days)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 2, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 2, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 2, @feb_days)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 2, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 2, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 2, @feb_days)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 2, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 2, @feb_days))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 2, @feb_days))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 2, @feb_days) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 2, @feb_days)))
							AND DATETIMEFROMPARTS(@endYear, 2, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
							AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @march_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 3, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 3, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 3, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 3, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 3, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 3, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 3, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 3, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 3, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 3, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 3, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 3, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 3, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 3, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 3, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 3, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 3, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 3, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 3, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 3, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 3, 31)))
						AND DATETIMEFROMPARTS(@endYear, 3, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @april_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 4, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 4, 30)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 4, 30)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 4, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 4, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 4, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 4, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 4, 30)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 4, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 4, 30)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 4, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 4, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 4, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 4, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 4, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 4, 30)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 4, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 4, 30))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 4, 30))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 4, 30) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 4, 30)))
						AND DATETIMEFROMPARTS(@endYear, 4, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @may_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 5, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 5, 31)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 5, 31)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 5, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 5, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 5, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 5, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 5, 31)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 5, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 5, 31)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 5, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 5, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 5, 31)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 5, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 5, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 5, 31)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 5, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 5, 31))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 5, 31))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 5, 31) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 5, 31)))
						AND DATETIMEFROMPARTS(@endYear, 5, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
SET @june_value_BedCount =  (SELECT ISNULL(SUM(ceiling(case when dateDiff = 0 then 1 else dateDiff end)),0) FROM (
						SELECT Distinct bl.participantId, concat (p.firstName , ' ', p.middleName , ' ' , p.lastName) as name, bl.eventStart, bl.eventEnd
							,case when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 6, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 6, 30)) and (CAST(eventEnd AS DATE)>datefromparts(@endYear, 6, 30)) then DATEDIFF(hour,eventStart, DATETIMEFROMPARTS(@endYear, 7, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)<datefromparts(@endYear, 6, 1)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 6, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 6, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000), eventEnd)/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 6, 1) and CAST(eventStart AS DATE)<=datefromparts(@endYear, 6, 30)) and (CAST(eventEnd AS DATE)>=datefromparts(@endYear, 6, 1) and CAST(eventEnd AS DATE)<=datefromparts(@endYear, 6, 30)) then DATEDIFF(hour, eventStart, eventEnd)/24.0
							when ((CAST(eventStart AS DATE)<datefromparts(@endYear, 6, 1)) and (eventEnd IS NULL))or(CAST(eventStart AS DATE)<datefromparts(@endYear, 6, 1) and CAST(eventEnd AS DATE)>datefromparts(@endYear, 6, 30)) then DATEDIFF(hour, DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000), DATETIMEFROMPARTS(@endYear, 7, 1,00,00,00,000))/24.0
							when (CAST(eventStart AS DATE)>=datefromparts(@endYear, 6, 1)) and (eventEnd IS NULL) then DATEDIFF(hour, eventStart, DATETIMEFROMPARTS(@endYear, 7, 1,00,00,00,000))/24.0
							else NULL End as 'dateDiff'
						from lodging.BedLog bl, lodging.Bed b, lodging.Room r, lodging.Facility f, participant.HistoryDashboard p
						where f.timeRetired is null
							and bl.bedId = b.id 
							and b.roomId = r.id and r.facilityId = f.id and bl.participantId = p.id
							and (((CAST(bl.eventStart AS DATE) >= datefromparts(@endYear, 6, 1) and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 6, 30)) or 
							(CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 6, 1) and CAST(bl.eventEnd AS DATE) <= datefromparts(@endYear, 6, 30))) or 
							((CAST(bl.eventEnd AS DATE) is null or CAST(bl.eventEnd AS DATE) = '') and CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 6, 30))
							OR (CAST(bl.eventStart AS DATE) <= datefromparts(@endYear, 6, 30) and CAST(bl.eventEnd AS DATE) >= datefromparts(@endYear, 6, 30)))
						AND DATETIMEFROMPARTS(@endYear, 6, 1,00,00,00,000) <= DATETIMEFROMPARTS(year(CURRENT_TIMESTAMP), month(CURRENT_TIMESTAMP), 1,00,00,00,000)
						AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
						)b)
			
--Bed Count
UPDATE participant.ResidentialDashboard 
	SET july_value = @july_value_BedCount,	
		aug_value = @aug_value_BedCount,
		sept_value = @sept_value_BedCount,
		oct_value = @oct_value_BedCount,
		nov_value = @nov_value_BedCount,
		dec_value = @dec_value_BedCount,
		jan_value = @jan_value_BedCount,
		feb_value = @feb_value_BedCount,
		march_value = @march_value_BedCount,
		april_value = @april_value_BedCount,
		may_value = @may_value_BedCount,
		june_value = @june_value_BedCount
WHERE parameter = 'Bed Count' and fiscal_year = :fiscalYear

--Average per night
UPDATE participant.ResidentialDashboard 
	SET july_value = @july_value_BedCount/31,	
		aug_value = @aug_value_BedCount/31,
		sept_value = @sept_value_BedCount/30,
		oct_value = @oct_value_BedCount/31,
		nov_value = @nov_value_BedCount/30,
		dec_value = @dec_value_BedCount/31,
		jan_value = @jan_value_BedCount/31,
		feb_value = @feb_value_BedCount/@feb_days,
		march_value = @march_value_BedCount/31,
		april_value = @april_value_BedCount/30,
		may_value = @may_value_BedCount/31,
		june_value = @june_value_BedCount/30
WHERE parameter = 'Average per night' and fiscal_year = :fiscalYear

-- Total Bed Count minus GPD - Actual
UPDATE participant.ResidentialDashboard 
	SET july_value = @july_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),
		aug_value = @aug_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = @sept_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = @oct_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = @nov_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = @dec_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)),
		jan_value = @jan_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = @feb_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = @march_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = @april_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = @may_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = @june_value_BedCount
					- (SELECT count(id) FROM participant.ReferralDashboard WHERE programName IN ('Veterans Service Intensive','Veterans Low Demand','Veterans Hospital to Housing') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Total Bed Count minus GPD - Actual' and fiscal_year = :fiscalYear

-- Total Bed Count minus GPD (34x #days in month) - (if beds are full)
UPDATE participant.ResidentialDashboard 
	SET july_value = case when @july_value_BedCount != 0 then @july_value_BedCount - (34*31) else 0 end,	
		aug_value = case when @aug_value_BedCount != 0 then @aug_value_BedCount - (34*31) else 0 end,
		sept_value = case when @sept_value_BedCount != 0 then @sept_value_BedCount - (34*30) else 0 end,
		oct_value = case when @oct_value_BedCount != 0 then @oct_value_BedCount - (34*31) else 0 end,
		nov_value = case when @nov_value_BedCount != 0 then @nov_value_BedCount - (34*30) else 0 end,
		dec_value = case when @dec_value_BedCount != 0 then @dec_value_BedCount - (34*31) else 0 end,
		jan_value = case when @jan_value_BedCount != 0 then @jan_value_BedCount - (34*31) else 0 end,
		feb_value = case when @feb_value_BedCount != 0 then @feb_value_BedCount - (34*@feb_days) else 0 end,
		march_value = case when @march_value_BedCount != 0 then @march_value_BedCount - (34*31) else 0 end,
		april_value = case when @april_value_BedCount != 0 then @april_value_BedCount - (34*30) else 0 end,
		may_value = case when @may_value_BedCount != 0 then @may_value_BedCount - (34*31) else 0 end,
		june_value = case when @june_value_BedCount != 0 then @june_value_BedCount - (34*30) else 0 end
WHERE parameter = 'Total Bed Count minus GPD' and fiscal_year = :fiscalYear

-- Total number of meals served (Bed count x 3)
UPDATE participant.ResidentialDashboard 
	SET july_value = @july_value_BedCount * 3,	
		aug_value = @aug_value_BedCount * 3,
		sept_value = @sept_value_BedCount * 3,
		oct_value = @oct_value_BedCount * 3,
		nov_value = @nov_value_BedCount * 3,
		dec_value = @dec_value_BedCount * 3,
		jan_value = @jan_value_BedCount * 3,
		feb_value = @feb_value_BedCount * 3,
		march_value = @march_value_BedCount * 3,
		april_value = @april_value_BedCount * 3,
		may_value = @may_value_BedCount * 3,
		june_value = @june_value_BedCount * 3
WHERE parameter = 'Total number of meals served' and fiscal_year = :fiscalYear

-- Social Detox  Metro
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Social Detox  Metro' and fiscal_year = :fiscalYear

-- Social Detox - non Metro
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Social Detox - non Metro' and fiscal_year = :fiscalYear

-- Provided Clothing: Underwear/socks (detox x 1)
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31))
				+ (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31))
				+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30))
					+ (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31))
					+ (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30))
					+ (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) 
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Law Enforcement' AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
					+(SELECT count(id) FROM participant.ReferralDashboard WHERE providerType = 'Staff' AND ReasonForEntry NOT IN ('Winter Shelter','Winter Shelter No Ticket') AND  checkInDate IS NOT NULL AND CAST(checkInDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Provided Clothing' and fiscal_year = :fiscalYear

-- Laundry Services Given (assumed 4 week month)
UPDATE participant.ResidentialDashboard 
	SET july_value = (@july_value_BedCount/31)*4,	
		aug_value = (@aug_value_BedCount/31)*4,
		sept_value = (@sept_value_BedCount/30)*4,
		oct_value = (@oct_value_BedCount/31)*4,
		nov_value = (@nov_value_BedCount/30)*4,
		dec_value = (@dec_value_BedCount/31)*4,
		jan_value = (@jan_value_BedCount/31)*4,
		feb_value = (@feb_value_BedCount/@feb_days)*4,
		march_value = (@march_value_BedCount/31)*4,
		april_value = (@april_value_BedCount/30)*4,
		may_value = (@may_value_BedCount/31)*4,
		june_value = (@june_value_BedCount/30)*4
WHERE parameter = 'Laundry Services Given' and fiscal_year = :fiscalYear

-- Entered Pending/Seeking 
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Seeking/Pending Treatment' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Entered Pending/Seeking' and fiscal_year = :fiscalYear

-- Went to treatment
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM lodging.BedLog WHERE exitDestinationId = 7 AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Went to treatment' and fiscal_year = :fiscalYear

-- Connected to Mental Health Services
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE (serviceName like '%Connected to Mobile Crisis%' or serviceName like '%Connected to Psychiatric Services at DTC%' or serviceName like '%Connected with Centerstone Outreach%' or serviceName like '%Connected with MHC Outreach%') AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Connected to Mental Health Services' and fiscal_year = :fiscalYear

-- Connected to SOAR
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%Connected to Park Ctr/SOAR%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Connected to SOAR' and fiscal_year = :fiscalYear

-- SSI or SSDI check started
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like '%SSI or SSDI Check Started%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'SSI or SSDI check started' and fiscal_year = :fiscalYear

-- Employment
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Hired For Employment%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Employment' and fiscal_year = :fiscalYear

-- Moved into housing
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like 'Rental by Client with HUD VASH housing subsidy (VA)%'
					or destinationName like 'Rental by Client with other housing subsidy%'
					or destinationName like 'Rental by Client in a public housing unit%'
					or destinationName like 'Rental by Client, no ongoing housing subsidy%'
					or destinationName like '%Owned by client')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Moved into housing' and fiscal_year = :fiscalYear

-- Moved into institutional living
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id 
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(b.id) FROM lodging.BedLog b INNER JOIN lodging.ExitDestination e on b.exitDestinationId = e.id
					where (destinationName like '%Safe Haven%' 
					or destinationName like 'Foster Care Home or Group Home (HUD)%'
					--or destinationName like 'Jail, prison or other detention facility%'
					or destinationName like 'Long-term care facility or nursing home (i.e. SNF/ALF)%'
					or destinationName like 'Residential project or halfway house%')
					AND eventEnd IS NOT NULL AND CAST(eventEnd AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Moved into institutional living' and fiscal_year = :fiscalYear

-- Attended Apartment Lunch Outing
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Lunch Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Attended Apartment Lunch Outing' and fiscal_year = :fiscalYear

-- Attended Apartment Grocery Outing
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Grocery Outing%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Attended Apartment Grocery Outing' and fiscal_year = :fiscalYear

-- Attended Apartment Pantry
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Apartment Pantry%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Attended Apartment Pantry' and fiscal_year = :fiscalYear

-- Attended Monday Night Dinner
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		aug_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		sept_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		oct_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		nov_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		dec_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		jan_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		feb_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days))
						and timeCancelled is NULL and timeRetired is NULL)),
		march_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		april_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		may_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		june_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'Community Dinner%' and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
						and timeCancelled is NULL and timeRetired is NULL))
WHERE parameter = 'Attended Monday Night Dinner' and fiscal_year = :fiscalYear

-- Attended Monday Outside Meeting
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		aug_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		sept_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		oct_value = (SELECT count(participantId) FROM participant.EventAttendance where id in   
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		nov_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		dec_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		jan_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		feb_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days))
						and timeCancelled is NULL and timeRetired is NULL)),
		march_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		april_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30))
						and timeCancelled is NULL and timeRetired is NULL)),
		may_value = (SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31))
						and timeCancelled is NULL and timeRetired is NULL)),
		june_value =(SELECT count(participantId) FROM participant.EventAttendance where id in 
						(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where (name like 'Celebrate Recovery%' or name like 'Narcotics Anonymous%') and timeretired is null)
						and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
						and timeCancelled is NULL and timeRetired is NULL) )
WHERE parameter = 'Attended Monday Outside Meeting' and fiscal_year = :fiscalYear

-- Attended Monthly VA Dinner
UPDATE participant.ResidentialDashboard 
	SET july_value = (select Case when CAST(datefromparts(@startYear, 7, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31))
					end),
		
		aug_value = (select Case when CAST(datefromparts(@startYear, 8, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31))
					end),
		
		sept_value = (select Case when CAST(datefromparts(@startYear, 9, 30) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30))
					end),
		
		oct_value = (select Case when CAST(datefromparts(@startYear, 10, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31))
					end),
		
		nov_value = (select Case when CAST(datefromparts(@startYear, 11, 30) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30))
					end),
		
		dec_value = (select Case when CAST(datefromparts(@startYear, 12, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31))
					end),
		
		jan_value = (select Case when CAST(datefromparts(@endYear, 1, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31))
					end),
		
		feb_value = (select Case when CAST(datefromparts(@endYear, 2, @feb_days) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days))
					end),
		
		march_value = (select Case when CAST(datefromparts(@endYear, 3, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31))
					end),
		
		april_value = (select Case when CAST(datefromparts(@endYear, 4, 30) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30))
					end),
		
		may_value = (select Case when CAST(datefromparts(@endYear, 5, 31) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31))
					end),
		
		june_value = (select Case when CAST(datefromparts(@endYear, 6, 30) AS Date)>'2024-06-30' then 
						(SELECT count(participantId) FROM participant.EventAttendance where scheduleId in 
							(SELECT id FROM participant.EventSchedule where eventId in (SELECT id FROM participant.Events where name like 'VA Monthly Dinner%' and timeretired is null)
							and (CAST(startsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30)) and (CAST(endsOn AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
							and timeCancelled is NULL and timeRetired is NULL))
					else
						(SELECT count(participantId) FROM participant.ServicesDashboard WHERE serviceName like 'Attended Veteran''s Dinner%' AND serviceDate IS NOT NULL AND CAST(serviceDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
					end)	
WHERE parameter = 'Attended Monthly VA Dinner' and fiscal_year = :fiscalYear

-- Recuperative Care Referrals Received
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Recuperative Care Referrals Received' and fiscal_year = :fiscalYear

--Recuperative Care Referrals Accepted
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus in ('Approved','Checked In','Approved / Already Discharged','Approved / Other Arrangements Made','No Show') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Recuperative Care Referrals Accepted' and fiscal_year = :fiscalYear

--Recuperative Care Referrals Arrived
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE programName = 'Recuperative Care' and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'Recuperative Care Referrals Arrived' and fiscal_year = :fiscalYear

--VA Referrals Received
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'VA Referrals Received' and fiscal_year = :fiscalYear

--VA Referrals Accepted
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and (referralStatus = 'Approved' or referralStatus = 'Approved / Already Discharged' or referralStatus = 'Approved / Other Arrangements Made' or referralStatus = 'No Show' or referralStatus = 'Checked In') AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'VA Referrals Accepted' and fiscal_year = :fiscalYear

--VA Referrals Arrived
UPDATE participant.ResidentialDashboard 
	SET july_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 7, 1) AND datefromparts(@startYear, 7, 31)),	
		aug_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 8, 1) AND datefromparts(@startYear, 8, 31)),
		sept_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 9, 1) AND datefromparts(@startYear, 9, 30)),
		oct_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 10, 1) AND datefromparts(@startYear, 10, 31)),
		nov_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 11, 1) AND datefromparts(@startYear, 11, 30)),
		dec_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@startYear, 12, 1) AND datefromparts(@startYear, 12, 31)) ,
		jan_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 1, 1) AND datefromparts(@endYear, 1, 31)),
		feb_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 2, 1) AND datefromparts(@endYear, 2, @feb_days)),
		march_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 3, 1) AND datefromparts(@endYear, 3, 31)),
		april_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 4, 1) AND datefromparts(@endYear, 4, 30)),
		may_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 5, 1) AND datefromparts(@endYear, 5, 31)),
		june_value = (SELECT count(id) FROM participant.ReferralDashboard WHERE (providerName like '%VA Medical Center Nashville%' or providerName like '%VA Medical Center - Murfreesboro%' or providerName like '%VA Homeless Division%') and referralStatus = 'Checked In' AND  referralDate IS NOT NULL AND CAST(referralDate AS DATE) BETWEEN datefromparts(@endYear, 6, 1) AND datefromparts(@endYear, 6, 30))
WHERE parameter = 'VA Referrals Arrived' and fiscal_year = :fiscalYear