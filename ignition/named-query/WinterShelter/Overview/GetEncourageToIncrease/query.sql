DECLARE @firstDayOfTheCurrentSeason as INT
DECLARE @YearStart as INT
DECLARE @YeareEnd as INT
SELECT @YearStart =  CAST(SUBSTRING(seasons, 1, 4)as INT) FROM shelter.Seasons where id = :currentSeasonId
SELECT @YeareEnd =   CAST(SUBSTRING(seasons, 6, 9)as INT) FROM shelter.Seasons where id = :currentSeasonId
SELECT @firstDayOfTheCurrentSeason = DATENAME(dayofyear , datefromparts(@YearStart, 11,1)) 
DECLARE	@StartDateNov DateTime = CONCAT(@YearStart,'-11-01'),@EndDateNov DateTime = CONCAT(@YearStart,'-11-30');
DECLARE @thanksGiving_date as DATETIME

;WITH CTE(date_list) AS (
      SELECT @StartDateNov
      UNION ALL 
      SELECT DATEADD(day,1,date_list) FROM CTE
      WHERE date_list<=@EndDateNov
)

SELECT @thanksGiving_date = ListOfThursday FROM (SELECT date_list as 'ListOfThursday',ROW_NUMBER() OVER (ORDER BY date_list) as 'rowNo' FROM CTE WHERE DATENAME(weekday ,date_list) IN ('Thursday'))d where rowNo=4 
DECLARE @thanksGiving_holiday as INT = DATENAME(dayofyear , @thanksGiving_date)  --327
DECLARE @Christmas1_holiday as INT = DATENAME(dayofyear , CONCAT(@YearStart,'-12-24'))  --358
DECLARE @Christmas2_holiday as INT = DATENAME(dayofyear , CONCAT(@YearStart,'-12-25')) --359
DECLARE @YearEnd_holiday as INT = DATENAME(dayofyear , CONCAT(@YearStart,'-12-31'))  --365
DECLARE @NewYear_holiday as INT = DATENAME(dayofyear , CONCAT(@YeareEnd,'-01-01'))  --1

SELECT * 
FROM
(
SELECT 
	locationId,locationName,lastSeason,thisSeason,guests,dayOfWeek,frequency,fifthWeek,holidays,transportation,needsToIncrease
	,CONCAT(CASE WHEN guests < 8 THEN 'Increase to 8, ' WHEN guests >= 8 AND guests <= 11 THEN 'Increase to 12, ' ELSE '' END
			,CASE WHEN frequency = 'Monthly' THEN 'Bi-Monthly, ' WHEN frequency = 'Bi-Monthly' THEN 'Weekly, ' ELSE '' END
			,CASE WHEN holidays = 'No' THEN 'Holidays, ' ELSE '' END
			,CASE WHEN fifthWeek = 'No' THEN '5th Week' ELSE '' END
		) as 'increaseSuggestion',
		ISNULL(ROUND(PercentBedGrowth,0),-1000) as 'PercentBedGrowth'
FROM(
	SELECT 
		ls.locationId
		,l.locationName
		,schprev.PrevSeasonActual as 'lastSeason'
		,sch.bedsProjected as 'thisSeason'
		,ls.beds as 'guests'
		,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ls.dateSelectionDays,'[',''),']',''),1,'Sun'),2,'Mon'),3,'Tue'),4,'Wed'),5,'Thu'),6,'Fri'),7,'Sat') as 'dayOfWeek'
		,(SELECT fp.frequencyType FROM shelter.Frequency f LEFT JOIN shelter.FrequencyType fp ON fp.id = f.frequencyTypeId where f.id = ls.frequencyId) as 'frequency'
		,CASE WHEN ls.dateSelectionPattern = 7 OR
			'Yes' in
				(SELECT (CASE WHEN (datediff(ww,datediff(d,0,dateadd(m,datediff(m,7,DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)),0)
					 )/7*7,dateadd(d,-1,DateAdd(DAY,dayOfYear, case when dayOfYear<@firstDayOfTheCurrentSeason then DateFromParts(@YeareEnd-1,12,31) Else DateFromParts(@YearStart-1,12,31) end)))+1) = 5 THEN 'Yes' ELSE 'No' END) as 'fiftweek'
				FROM shelter.Schedule 
				where locationId = ls.locationId and seasonId = :currentSeasonId and timeCancelled IS NULL)
			THEN 'Yes' ELSE 'No' END as 'fifthWeek'
		,(SELECT CASE WHEN COUNT(id) > 0 THEN 'Yes' ELSE 'No' END AS 'isHoliday' FROM shelter.Schedule where locationId = ls.locationId and dayOfYear in (@thanksGiving_holiday,@Christmas1_holiday,@Christmas2_holiday,@YearEnd_holiday,@NewYear_holiday)) as 'holidays'
		,(SELECT tt.transportType FROM shelter.Transport t LEFT JOIN shelter.TransportType tt ON tt.id = t.transportTypeId where t.id = ls.transportId) as 'transportation'
		,(SELECT STRING_AGG(h.hostMoreOption,', ') FROM shelter.HostMoreLocation hl LEFT JOIN shelter.HostMore h ON h.id = hl.hostMoreId where locationId = ls.locationId) as 'needsToIncrease'
		,CASE WHEN (schprev.PrevSeasonActual IS NULL OR schprev.PrevSeasonActual = 0) THEN ls.bedsProjected 
		ELSE (CAST((sch.bedsProjected-schprev.PrevSeasonActual) AS FLOAT)/schprev.PrevSeasonActual)*100 END AS 'PercentBedGrowth'
		
	FROM 
		shelter.LocationSeasonal ls
		LEFT JOIN
			shelter.Location l ON ls.locationId = l.id
		LEFT JOIN (SELECT * FROM shelter.LocationSeasonal WHERE ID IN (Select min(id) FROM shelter.LocationSeasonal 
					WHERE seasonID = :lastSeasonId GROUP BY locationId)) lsp ON l.id = lsp.locationid
		LEFT JOIN ( SELECT locationId, seasonId , sum(totalBeds) as bedsProjected
			FROM shelter.Schedule 
			WHERE timeCancelled is NULL 
			GROUP BY locationId, seasonId ) sch ON ls.seasonId = sch.seasonId AND ls.locationId = sch.locationId
		LEFT JOIN ( SELECT locationId, seasonId , count(id) as PrevSeasonActual
			FROM shelter.ScheduleParticipant 
			WHERE timeRetired is NULL
			GROUP BY locationId, seasonId )schprev ON lsp.seasonId = schprev.seasonId AND lsp.locationId = schprev.locationId
	WHERE 
		ls.seasonId = :currentSeasonId
		AND sch.bedsProjected IS NOT NULL AND sch.bedsProjected > 0
) locationInfo
) x 
WHERE (:frequency IS NULL or :frequency = '-1' or :frequency = '' or x.frequency = :frequency )
AND (:fifthWeek IS NULL OR :fifthWeek = '-1' OR :fifthWeek = '' or x.fifthWeek = :fifthWeek)
AND (:holidays IS NULL OR :holidays = '-1' OR :holidays = '' or x.holidays = :holidays)
AND (:transportation IS NULL OR :transportation = '-1' OR :transportation = '' or x.transportation = :transportation)
AND (:needsToIncrease IS NULL OR :needsToIncrease = '-1' OR :needsToIncrease = '' or x.needsToIncrease like CONCAT('%',:needsToIncrease,'%'))
AND (:suggestions IS NULL OR :suggestions = '-1' OR :suggestions = '' or x.increaseSuggestion like CONCAT('%',:suggestions,'%'))
AND  {percentGrowth} 
ORDER BY
	locationName