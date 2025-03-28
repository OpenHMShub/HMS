 
 SELECT BinNumber as Label , BinNumber as Value
 FROM participant.MedicationBinsMaster 
 WHERE BinLocation = :location AND
 BinNumber not in (SELECT DISTINCT bin FROM  participant.MedicationBinsLog WHERE location =  :location  and exitAction IS NULL)