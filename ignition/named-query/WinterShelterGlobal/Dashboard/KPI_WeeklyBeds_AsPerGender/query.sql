SELECT Sum(TotalBeds)/Count(*) as WeeklyBeds FROM(
SELECT Sum(totalBeds) as TotalBeds, 'Week ' + cast(datepart(wk, DateFromDayOfYear) as varchar(2)) Week FROM
(SELECT seasonId,genderId,totalBeds,dayOfYear,DateAdd(DAY,dayOfYear,DateFromParts(Year(GetDate())-1,12,31)) as DateFromDayOfYear 
FROM shelter.Schedule
Where seasonId = :seasonId And genderId = :genderId) as x
group by datepart(wk, DateFromDayOfYear)
) s
