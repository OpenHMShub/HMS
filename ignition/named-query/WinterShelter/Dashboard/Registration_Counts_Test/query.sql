---Determine the current, past and next season
DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 6 THEN @thisYear ELSE (@thisYear - 1) END
DECLARE @lastSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 6 THEN (@thisYear - 1) ELSE (@thisYear - 2) END
DECLARE @nextSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 6 THEN (@thisYear + 1) ELSE (@thisYear) END
---Determine the current, past and next season ID's
DECLARE @thisSeasonId int
SELECT @thisSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'

DECLARE @lastSeasonId int
SELECT @lastSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @lastSeasonStartYear + '%'

DECLARE @nextSeasonId int
SELECT @nextSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @nextSeasonStartYear + '%'


SELECT COUNT(loc.locationName) AS 'Registered',
	(COUNT(loc.locationName) * 100 /  (select count(locationName) from shelter.Location) /*Replace with real total later*/) AS 'Percentage'
	--cast(ISNULL(ls.seasonId,0) as bit) as 'registered'
	
FROM shelter.Location loc
left join (SELECT * FROM shelter.LocationSeasonal WHERE seasonID = @thisSeasonId) ls ON loc.id = ls.locationid
--left join shelter.LocationSeasonal ls on ls.locationId = loc.ID
where @thisSeasonId = ls.seasonId
--and ls.seasonId = 1
group by ls.seasonId
--WHERE Submission_Date IS NOT NULL