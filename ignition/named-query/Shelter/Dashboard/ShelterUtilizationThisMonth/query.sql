
DECLARE @monthStartDate DATETIME
DECLARE @monthEndDate DATETIME
DECLARE @monthExpectedUtilizationHours INT
DECLARE @monthActualUtilizationHours INT
DECLARE @totalBeds INT

-- Query total beds across the facilities
SELECT @totalBeds = sum(beds) 
from lodging.Facility 
where timeRetired is null

-- get month start and end datetimes
SELECT @monthStartDate = DATEADD(DAY,1,EOMONTH(Getdate(),-1)) , @monthEndDate =DATEADD(DAY,1,EOMONTH(Getdate()))

-- get total hours for month
SELECT @monthExpectedUtilizationHours = DATEDIFF(hour, @monthStartDate, @monthEndDate)

-- expected utilization
SET @monthExpectedUtilizationHours = @monthExpectedUtilizationHours * @totalBeds

-- find out total no of hours for which beds are occupied in the month -- actual utilization 
select @monthActualUtilizationHours = sum(DATEDIFF(hour, eventStart, eventEnd))
FROM
(
SELECT 
CASE WHEN eventStart < @monthStartDate THEN @monthStartDate
ELSE eventStart
END as eventStart,
CASE WHEN eventEnd > @monthEndDate THEN @monthEndDate
ELSE eventEnd
END as eventEnd
from lodging.BedLog
where ( (eventStart between @monthStartDate and @monthEndDate) 
or (eventEnd between @monthStartDate and @monthEndDate) )
) as t1

SELECT  @monthExpectedUtilizationHours ,  @monthActualUtilizationHours