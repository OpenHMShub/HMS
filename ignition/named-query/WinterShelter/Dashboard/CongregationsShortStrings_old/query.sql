--- WinterShelter/Dashboard/CongregationsShortStrings --- 

DECLARE
@stringLimit INT = 10 --Used to truncate strings for use in Dashboard (Change Here!!!). -Updated to 1000 as a bandaid for now so we can have the full string in the dataset

SELECT "Congregation_Name" as 'Congregation Name',
	"Night_s_of_the_Week_Hosting" as 'Night',
	"Gender_of_Guests" as 'Gender',
	"Number_of_Guests" as 'Number_of_Guests',
	:current_year as 'This Season Projection',
	:previous_year as 'Last Year Total',
	:registered as 'Registered',
	"City",
    id,
    options
    
/*  Used to trim remaining chars
    CASE 
    	WHEN LEN(Comments)>=@stringLimit
    	THEN LEFT(Comments, @stringLimit) + '...' 
    	ELSE Comments END Comments,
*/

FROM shelter.Totaltable
WHERE Submission_Date IS NOT NULL
ORDER BY Congregation_Name ASC