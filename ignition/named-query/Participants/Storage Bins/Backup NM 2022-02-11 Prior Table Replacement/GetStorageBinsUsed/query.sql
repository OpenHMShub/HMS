SELECT Column1, Bin
FROM
(
	SELECT CONCAT(Column1, Bin) as StorageBin, ROW_NUMBER() OVER (PARTITION BY Bin, Column1 ORDER BY ActionDate DESC, id DESC) AS rn, m.*
	FROM participant.StorageBin_History m
) sb
WHERE rn=1 AND Column1 = :Column1