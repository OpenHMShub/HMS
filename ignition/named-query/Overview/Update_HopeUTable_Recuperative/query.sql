SET NOCOUNT ON
DECLARE 
	@dateToday date,
	@recuperativeOccupancy int,
	@isRecuperativeFull bit
--also retrieve the recuperative care data.
SET @dateToday = CAST(:dateToday AS DATE)
SELECT @recuperativeOccupancy = (reservedBeds + checkIns),
@isRecuperativeFull = CASE WHEN totalBeds > ( reservedBeds + checkIns) then 0 ELSE 1 END 
FROM
(
SELECT table1.beds as totalBeds,
COALESCE(TableReservations.reservations , 0) as reservedBeds, 
 COALESCE(TableCheckins.checkins , 0) as checkIns
FROM
(SELECT a.id as id, a.facilityName as ShelterName,a.beds
FROM lodging.Facility a
where a.timeRetired is null and a.facilityName = 'Respite Dorm (Men)' ) table1
LEFT  JOIN (SELECT a.id as id, count(res.id) as reservations
FROM lodging.Facility a, lodging.Room r, lodging.Bed b, lodging.Reservation res 
where a.timeRetired is null and res.timeRetired is null and a.facilityName = 'Respite Dorm (Men)' and a.id = r.facilityId and b.roomId = r.id and res.bedId = b.id 
and ( CAST(res.reservationStart AS DATE) <= @dateToday and CAST(res.reservationEnd AS DATE) >= @dateToday)
group by a.id) as TableReservations ON TableReservations.id = table1.id
LEFT OUTER JOIN (SELECT a.id as id, count(bedlogs.id) as checkins
FROM lodging.Facility a, lodging.Room r, lodging.Bed b, lodging.BedLog bedlogs 
where a.timeRetired is null and a.facilityName = 'Respite Dorm (Men)' 
and a.id = r.facilityId and b.roomId = r.id and bedlogs.bedId = b.id  
and (CAST(bedlogs.eventStart AS DATE) <= @dateToday and (bedlogs.eventEnd is null or CAST(bedlogs.eventEnd AS DATE) >= @dateToday))
group by a.id) as TableCheckins ON TableCheckins.id = table1.id ) mainTable

UPDATE 
	[participant].[HopeUDashboard]
SET
	[recuperativeCareOccupancy] = @recuperativeOccupancy,
	[isRecuperativeCareFull] = @isRecuperativeFull
	
WHERE
	CAST([date] AS DATE) = CAST(@dateToday AS DATE)
