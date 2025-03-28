SELECT TOP 1
	s.startOn

FROM
	participant.vwStorageBinsLogDetails
	-- participant.StorageBin_History s

WHERE
	s.bin     = :bin 
		AND
	s.col = :col

ORDER BY
	s.startOn