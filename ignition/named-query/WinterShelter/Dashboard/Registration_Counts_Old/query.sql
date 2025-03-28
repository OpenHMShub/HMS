SELECT COUNT(Congregation_Name) AS 'Registered',
	(COUNT(Congregation_Name) *100 / 200 /*Replace with real total later*/) AS 'Percentage'
FROM shelter.Totaltable
WHERE Submission_Date IS NOT NULL