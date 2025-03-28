---Shelter/Reservations/ReservationDetailsAllShelters---
--DECLARE @activity_range AS INT = :activity_range

--Calculate the begin and end activity dates
--DECLARE	@activity_start AS DATE = DATEADD(day, (-1 * @activity_range), getdate())
--	,@activity_end AS DATE = DATEADD(day,1,getdate());

SELECT f.id as facilityId
	,f.facilityName
	,h.name
	,h.age
	,h.race
	,h.gender
	,res.reservationStart
	,coalesce(res.reservationEnd,CURRENT_TIMESTAMP) as reservationEnd
	,res.reservationExpiration as reservationExpiration
	,res.timeRetired as timeRetired
	,b.bedName
	,res.participantId
	,res.id
	,r.id as roomId
	,r.roomName
	,b.id as bedId
	,coalesce(res.notes , '') as notes
	,COALESCE(res.waitingListName,'All Waiting Lists') as waitListName
	,COALESCE(res.programId, -1) as programId
	,COALESCE(res.providerId, -1) as providerId
	,COALESCE(res.providerTypeId, -1) as providerTypeId
	,COALESCE(res.referralStatus, '') as referralStatus
	,COALESCE(res.reservationType, '') as reservationType
from
	lodging.Reservation res, lodging.Bed b, lodging.Room r, lodging.Facility f,
	(SELECT distinct id
		,concat (firstname,' ',middlename,' ',lastname) as name
		,datediff(year, birthdate, getdate()) as age
		,race,gender from participant.Dashboard) h
	where f.timeRetired is null
	and res.bedId = b.id 
	and b.roomId = r.id and r.facilityId = f.id and res.participantId = h.id
	order by res.reservationStart desc