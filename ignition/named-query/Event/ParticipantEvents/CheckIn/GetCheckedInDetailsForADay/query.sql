DECLARE @totalCheckIns INT;

SELECT @totalCheckIns = COUNT(id)
FROM  participant.EventAttendance 
WHERE scheduleId in (SELECT id FROM  participant.EventSchedule 
WHERE day =  :day AND month = :month and year = :year and timeRetired is NULL)
AND timeRetired IS NULL

--SELECT CASE WHEN @totalBeds = 0 THEN ' ' 
--ELSE CONCAT(@totalCheckIns, ' of ' , @totalBeds , ' Checked-In' )
--END AS result

SELECT CONCAT(@totalCheckIns, ' Checked-In' )


