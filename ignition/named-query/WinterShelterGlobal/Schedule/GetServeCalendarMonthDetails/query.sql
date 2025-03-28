;WITH GenerateNumbers AS (
SELECT  :rangeStartDayOfYear  AS Number
UNION ALL
SELECT Number +1 FROM GenerateNumbers
WHERE Number +1<=  :rangeEndDayOfYear 
)
SELECT g.Number, COALESCE(x.noOfCongregations, 0) as noOfCongregations, COALESCE(x.totalBeds, 0) as totalBeds FROM GenerateNumbers g LEFT JOIN
(
select dayOfYear , count(locationId) as noOfCongregations , sum(totalBeds) as totalBeds
from shelter.Schedule 
where seasonId = :seasonId AND dayOfYear >=  :rangeStartDayOfYear AND dayOfYear <= :rangeEndDayOfYear AND timeCancelled is NULL
group by dayOfYear
) x
ON g.Number = x.dayOfYear
ORDER BY g.Number
option (MAXRECURSION 0)
 
