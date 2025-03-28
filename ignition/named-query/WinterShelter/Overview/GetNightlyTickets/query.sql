WITH numbers
as
(
    Select 1 as value
    UNion ALL
    Select value + 1 from numbers
    where value + 1 <= Day(EOMONTH(datefromparts(:year,:month_int,1)))
)

SELECT 
	datePrinted as 'date',
	dateInfo.all_dates as 'date_all',
	month as 'month', 
	seasonId as 'seasonId', 
	regularTickets as 'regularTickets', 
	plusTickets as 'plusTickets', 
	doublePlusTickets as 'doublePlusTickets', 
	ifRoomTickets as 'ifRoomTickets' 
FROM (
	SELECT
		id
		,datePrinted
		,DATENAME(MONTH, datePrinted) as 'month'
		,(CASE when DATEPART(DAYOFYEAR, datePrinted)>304 
			then (SELECT s.id FROM shelter.Seasons s WHERE s.Seasons like CAST(year(datePrinted) as varchar(255)) + '%')
			else (SELECT s.id FROM shelter.Seasons s WHERE s.Seasons like '%' + CAST(year(datePrinted) as varchar(255)))
			end) as 'seasonId'
		,regularTickets
		,plusTickets
		,doublePlusTickets
		,ifRoomTickets
	FROM 
		shelter.ShelterTickets
	) s
FULL OUTER JOIN
(SELECT datefromparts(:year,:month_int,numbers.value) all_dates FROM numbers) dateInfo ON s.datePrinted = dateInfo.all_dates
WHERE
	(s.seasonId = :seasonId OR s.seasonId IS NULL)
	AND (s.month = :month OR s.month IS NULL)