--- WinterShelter/Dashboard/CongregationsFull --- 

SELECT "Congregation_Name" as 'Congregation Name',
	"Night_s_of_the_Week_Hosting" as 'Night',
	"Gender_of_Guests" as 'Gender',
	"Number_of_Guests" as 'Number_of_Guests',
	:current_year as 'This Season Projection',
	:previous_year as 'Last Year Total',
	:registered as 'Registered',
    id,
    options
FROM shelter.TotalTable
ORDER BY Congregation_Name ASC	