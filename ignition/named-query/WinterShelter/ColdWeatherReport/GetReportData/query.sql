SELECT * FROM 
shelter.ColdWeatherReportData 
WHERE ( :queryColdOnly IS NULL OR :queryColdOnly = 0 OR (  :queryColdOnly = 1 AND isCold = 1))
 AND {dateRange} 