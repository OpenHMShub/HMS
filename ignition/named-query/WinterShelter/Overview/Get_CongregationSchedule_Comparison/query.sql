SELECT
	l.id as 'locationId',
	l.locationName,
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date1 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_1',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date2 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_2',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date3 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_3',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date4 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_4',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date5 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_5',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date6 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_6',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date7 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_7',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date8 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_8',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date9 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_9',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date10 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_10',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date11 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_11',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date12 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_12',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date13 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_13',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date14 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_14',
	(select totalBeds from shelter.Schedule where seasonId = :seasonId and dayOfYear = :date15 and locationId = l.id and timeCancelled is NULL) as 'scheduleNights_15'
FROM 
	shelter.Location l
WHERE 
	l.id in (select locationId from shelter.Schedule where seasonId = :seasonId and timeCancelled is NULL and dayOfYear in (:date1,:date2,:date3,:date4,:date5,:date6,:date7,:date8,:date9,:date10,:date11,:date12,:date13,:date14,:date15))
	AND l.timeRetired is NULL 
ORDER BY
	l.locationName