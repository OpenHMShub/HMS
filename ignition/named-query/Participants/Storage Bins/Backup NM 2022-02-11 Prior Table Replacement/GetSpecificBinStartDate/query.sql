SELECT TOP 1 s.ActionDate
FROM participant.StorageBin_History s
WHERE s.Bin     = :bin 
AND   s.Column1 = :col
AND   s.Action  = '2000-01-01'
ORDER BY s.ActionDate