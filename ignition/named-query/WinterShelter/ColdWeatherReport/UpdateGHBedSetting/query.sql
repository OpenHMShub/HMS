UPDATE shelter.ColdWeatherReportSettings 
SET settingValue =  :ghBeds 
WHERE settingName = 'GH Beds'

UPDATE  shelter.ColdWeatherReportData 
SET  ghBeds =  :ghBeds 
WHERE CAST(monthDate as DATE) >= CAST(GETDATE() as DATE) 