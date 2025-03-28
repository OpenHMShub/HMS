DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 7 THEN @thisYear ELSE (@thisYear - 1) END
DECLARE @lastSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 7 THEN (@thisYear - 1) ELSE (@thisYear - 2) END
DECLARE @nextSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 7 THEN (@thisYear + 1) ELSE (@thisYear) END


SELECT 
	@thisMonth,
	@lastSeasonStartYear as 'lastSeason',
	@thisSeasonStartYear as 'thisSeason',
	@nextSeasonStartYear as 'nextSeason',
	c.id as 'CID',
	l.id as 'LID',
	--prov.providerName,
	l.locationName,
	l.city,
	l.zipCode,
	ISNULL(p.numberOfWeeks,'') as 'numberOfWeeks', 
	--p.nights,
	cast(p.nights & 1 as bit) as 'monday',
	cast(p.nights & 2 as bit) as 'tuesday',
	cast(p.nights & 4 as bit) as 'wednesday',
	cast(p.nights & 8 as bit) as 'thursday',
	cast(p.nights & 16 as bit) as 'friday',
	cast(p.nights & 32 as bit) as 'saturday',
	cast(p.nights & 64 as bit) as 'sunday',
	ISNULL(g.genderAccepted,'') as 'genderAccepted',
	l.capacity,
	ISNULL((SELECT stat.BedsProjected 
			FROM shelter.LocationStatus stat
			LEFT JOIN shelter.seasons sea on stat.SeasonId = sea.id
			where stat.LocationId=l.id and sea.Seasons like @thisSeasonStartYear + '%'),0)	as 'projection',
	ISNULL((Select stat.BedsActual 
			from shelter.LocationStatus stat
			LEFT JOIN shelter.seasons sea on stat.SeasonId = sea.id 
			where stat.LocationId=l.id and sea.Seasons like @lastSeasonStartYear + '%'),0)	as 'lastYear',
	cast(ISNULL((Select stat.id 
			from shelter.LocationStatus stat 
			LEFT JOIN shelter.seasons sea on stat.SeasonId = sea.id 
			where stat.LocationId=l.id and sea.Seasons like @thisSeasonStartYear + '%'),0) as bit) as 'registered',
	'' as 'options'	
FROM organization.congregation c
	--LEFT JOIN organization.Provider prov ON c.providerId = prov.id
	LEFT JOIN shelter.Location l ON c.id = l.congregationId
	LEFT JOIN shelter.LocationPreference p ON l.id = p.locationid
	--LEFT JOIN shelter.Statistics stat ON l.id = stat.LocationId
	LEFT JOIN shelter.Gender g ON g.id = p.genderId