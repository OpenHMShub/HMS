SELECT * FROM participant.EventLocations 
WHERE name like '%' +  :Location_Name  + '%' or :Location_Name is NULL
