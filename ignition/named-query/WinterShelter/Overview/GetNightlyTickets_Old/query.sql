SELECT 
	max(month) as 'month', 
	max(seasonId) as 'seasonId', 
	SUM(regularTickets) as 'total_regularTickets', 
	SUM(plusTickets) as 'total_plusTickets', 
	SUM(doublePlusTickets) as 'total_doublePlusTickets', 
	SUM(ifRoomTickets) as 'total_ifRoomTickets' 
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
WHERE
	s.seasonId = :seasonId
	AND s.month = :month