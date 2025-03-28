--WinterShelter/Registration/insertLocationRegistration--
---Determine the current season
DECLARE @thisMonth int = Month(GetDate())
DECLARE @thisYear varchar(4) = Year(GetDate())
DECLARE @thisSeasonStartYear varchar(4) = CASE WHEN @thisMonth > 5 THEN @thisYear ELSE (@thisYear - 1) END

---Determine the current, past and next season ID's
DECLARE @thisSeasonId int
SELECT @thisSeasonId = s.id FROM shelter.Seasons s WHERE s.Seasons like @thisSeasonStartYear + '%'
---Get the gender ID from the last active season
DECLARE @genderId int
SELECT TOP 1 @genderId = lsp.genderId FROM  shelter.LocationSeasonal lsp ORDER BY lsp.seasonId 
---Get the number of beds from the last active season
DECLARE @beds int
SELECT TOP 1 @beds = lsp.beds FROM  shelter.LocationSeasonal lsp ORDER BY lsp.seasonId 

INSERT INTO shelter.LocationSeasonal 
	 (
	 locationId 
	 ,seasonId
	 ,genderId
	 ,beds 
	 ,bedsProjected 
	 ,bedsActual  
	 ,timeCreated 
	 )
VALUES
	 (
	 :locationId 
	 ,@thisSeasonId
	 ,@genderId
	 ,@beds
	 ,0
	 ,0
	 ,GetDate()
	)