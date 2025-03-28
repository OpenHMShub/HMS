DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN @thisYear ELSE (@thisYear - 1) END
DECLARE @yesterdayDayOfYear int
DECLARE @currentSeasonId int
---Determine the current, past and next season ID's
SELECT @currentSeasonId = s.id  FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'

SELECT @yesterdayDayOfYear=DATENAME(dayofyear , DATEADD(day, -1, GetDate()))

INSERT INTO shelter.ActivityLog(locationId, activityType,activityDescription,timeCreated)
SELECT distinct locationId , 'winter_shelter_night', 'No-Show', DATEADD(Day,-1, GetDATE())
FROM shelter.Schedule 
WHERE dayOfYear =   @yesterdayDayOfYear AND seasonId =   @currentSeasonId AND timeRetired IS NULL
and id not in ( SELECT scheduleId FROM shelter.ScheduleParticipant WHERE dayOfYear =   @yesterdayDayOfYear AND seasonId =   @currentSeasonId)