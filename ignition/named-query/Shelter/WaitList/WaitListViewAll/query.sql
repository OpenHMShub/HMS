SELECT
	concat (w.[FirstName], ' ', ISNULL(w.[MiddleName],'') , ' ' , w.[LastName]) as 'PARTICIPANT',
	w.[date_added] as 'CHECK-IN',
	w.[Gender] AS 'GENDER',
	w.[Race] AS 'RACE',
	w.[program_name] as 'PROGRAM',
	datediff(year, w.[BirthDate], getdate())  as AGE,
	w.[program_name] as 'PROGRAM'
FROM  [shelter].[WaitListView] w

	