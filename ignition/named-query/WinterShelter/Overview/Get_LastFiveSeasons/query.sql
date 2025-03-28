DECLARE @currentSeason_year1 as INT, @currentSeason_year2 as INT
SELECT @currentSeason_year1 = LEFT(Seasons,4) FROM shelter.Seasons WHERE id = :seasonId
SELECT @currentSeason_year2 = RIGHT(Seasons,4) FROM shelter.Seasons WHERE id = :seasonId

SELECT * 
FROM 
	shelter.Seasons
WHERE 
	Seasons in (
		CONCAT(@currentSeason_year1-5,'-',@currentSeason_year2-5)
		,CONCAT(@currentSeason_year1-4,'-',@currentSeason_year2-4)
		,CONCAT(@currentSeason_year1-3,'-',@currentSeason_year2-3)
		,CONCAT(@currentSeason_year1-2,'-',@currentSeason_year2-2)
		,CONCAT(@currentSeason_year1-1,'-',@currentSeason_year2-1)
		,CONCAT(@currentSeason_year1,'-',@currentSeason_year2)
	)
ORDER By Seasons

