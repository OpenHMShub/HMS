SELECT Rcount as label, Rcount as value
FROM
(
	select top 140 ROW_NUMBER() over(order by a.name)  as Rcount
	from sys.all_objects a
) x
WHERE x.Rcount not in (SELECT DISTINCT bin FROM  participant.MedicationBinsLog WHERE location ='Guest House Bin' and exitAction IS NULL)