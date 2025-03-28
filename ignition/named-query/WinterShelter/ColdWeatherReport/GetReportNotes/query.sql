SELECT CONCAT(  dayOfWeek , ' ' , CONVERT(varchar,monthDate,101)  , ' ' , notes) as note FROM 
shelter.ColdWeatherReportData 
WHERE ( :queryColdOnly IS NULL OR :queryColdOnly = 0 OR (  :queryColdOnly = 1 AND isCold = 1))
 AND {dateRange} 
 AND  notes IS NOT NULL AND notes != ''