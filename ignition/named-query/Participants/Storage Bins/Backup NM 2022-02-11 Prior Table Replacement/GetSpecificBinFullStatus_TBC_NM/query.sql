WITH rankedMessages AS (
	SELECT m.*, ROW_NUMBER() OVER (PARTITION BY Bin, Column1 ORDER BY ActionDate DESC, id DESC) AS rn
	FROM participant.StorageBin_History m
)
SELECT 
r.Action,
r.ActionDate,
r.ParticipantId
FROM rankedMessages r
WHERE r.Bin     = :bin 
AND   r.Column1 = :col