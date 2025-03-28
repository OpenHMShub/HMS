--Get Day, month and year from date
DECLARE @day_fromDate int, @month_fromDate int, @year_fromDate int
SET @day_fromDate = DAY(:startsOn)
SET @month_fromDate = MONTH(:startsOn)
SET @year_fromDate = YEAR(:startsOn)

--Insert data in Event schedule table
INSERT INTO [participant].[EventSchedule]
	([eventId],[day],[year],[month],[notes],[timeCreated],[timeUpdated],[timeCancelled],[timeRetired],startsOn,endsOn,duration,locationId,points,description)
VALUES
	(:eventId,@day_fromDate,@year_fromDate,@month_fromDate,:notes,:timeCreated,NULL,NULL,NULL,:startsOn,:endsOn,:duration,:locationId,:points,:description)
