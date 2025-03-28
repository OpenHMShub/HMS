SET NOCOUNT ON
DECLARE 
	@dateToday date,
	@dayOfYear int,
	@ghBeds int,
	@ghUtilization int,
	@congregationBeds int,
	@congregationBedsUtilization int,
	@totalBedsCapacityRITI int,
	@totalBedsUtilizationRITI int,
	@addedBeds int,
	@unUtilizedBeds int,
-- calculate the season for a date to query congregations beds and checkins
	@seasonId int,
	@thisMonth int,
	@thisYear varchar(4),
	@thisSeasonStartYear varchar(4)
	

SET @thisMonth = Month( GETDATE())
SET @thisYear = Year(GETDATE())
SET @thisSeasonStartYear = CASE WHEN @thisMonth > 6 THEN @thisYear ELSE (@thisYear - 1) END	

SELECT @seasonId = s.id  FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'	

SET @dateToday = :dateToday
SET @dayOfYear = :dayOfYear 

SELECT @ghBeds = COALESCE(ghBeds,0) FROM [shelter].[ColdWeatherReportData] WHERE CAST([monthDate] AS DATE) = CAST(@dateToday AS DATE)

SELECT @ghUtilization = COUNT(bl.id) FROM 
			lodging.BedLog bl,  lodging.Bed b, lodging.Room r, lodging.Facility f
 			WHERE  f.timeRetired is null
			and bl.bedId = b.id 
			and b.roomId = r.id and r.facilityId = f.id
			AND f.facilityName NOT IN ('705 Apartments','532 Apartments')
			AND
			(
				(CAST(bl.eventStart AS DATE) <= CAST(@dateToday AS DATE) AND bl.eventEnd is NULL )
				OR 
				(CAST(bl.eventStart AS DATE) <= CAST(@dateToday AS DATE) and CAST(bl.eventEnd AS DATE) >= CAST(@dateToday AS DATE))
			)

SELECT @congregationBeds = COALESCE(SUM(totalBeds),0)
FROM shelter.Schedule 
WHERE dayOfYear =  @dayOfYear AND seasonId =  @seasonId AND timeCancelled is NULL

SELECT @congregationBedsUtilization = COUNT(id)
FROM shelter.ScheduleParticipant
WHERE scheduleId in (SELECT id FROM shelter.Schedule 
WHERE dayOfYear = @dayOfYear AND seasonId = @seasonId)
AND timeRetired IS NULL

SET @totalBedsCapacityRITI = @ghBeds +  @congregationBeds
SET @totalBedsUtilizationRITI = @ghUtilization +  @congregationBedsUtilization

SET @addedBeds = CASE WHEN @totalBedsUtilizationRITI > @totalBedsCapacityRITI THEN (@totalBedsUtilizationRITI - @totalBedsCapacityRITI)  ELSE NULL END
SET @unUtilizedBeds = CASE WHEN @totalBedsUtilizationRITI < @totalBedsCapacityRITI THEN (@totalBedsCapacityRITI - @totalBedsUtilizationRITI) ELSE NULL END
-- update  table
UPDATE 
	[shelter].[ColdWeatherReportData]
SET
	[ghUtilization] = @ghUtilization,
	[congregationalBeds] = @congregationBeds,
	[congregationalBedsUtilization] = @congregationBedsUtilization,
	[totalBedsCapacityRITI] = @totalBedsCapacityRITI,
	[totalBedsUtilizedRITI] = @totalBedsUtilizationRITI,
	[addedBeds] = @addedBeds,
	[unUtilizedBeds] = @unUtilizedBeds
WHERE
	CAST([monthDate] AS DATE) = CAST(@dateToday AS DATE)