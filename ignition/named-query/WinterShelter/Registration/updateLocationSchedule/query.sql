---Determine the current, past and next season
DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN @thisYear ELSE (@thisYear - 1) END

---Determine the current, past and next season ID's
DECLARE @thisSeasonId int
SELECT @thisSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'

UPDATE shelter.Schedule
SET
	genderId = :genderId
	,totalBeds = :totalBeds 
	,notes = :notes 
	,timeUpdated = getDate()
	,timeCancelled = Null
WHERE
	 locationId = :locationId 
	 AND
	 seasonId = @thisSeasonId
	 AND
	 dayOfYear = :dayOfYear 