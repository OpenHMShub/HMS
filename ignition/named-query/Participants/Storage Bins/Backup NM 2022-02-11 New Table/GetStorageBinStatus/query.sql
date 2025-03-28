SELECT
	*

FROM
	(
		SELECT
			*,
			ROW_NUMBER() OVER (PARTITION BY bin, col ORDER BY createdOn DESC, id DESC) AS rn
		FROM participant.vwStorageBinsLogDetails
	) t

WHERE
	rn = 1
		AND
	(
		(:activityStatus = 0 AND expireOn > GETDATE()) -- 0 = Active Bins only
			OR
		(:activityStatus = 1 AND expireOn < GETDATE()) -- 1 = Inactive / Expired Bins only
			OR
		(:activityStatus = 2) -- 2 = Active and Inactive Bins
	)

ORDER BY
	col ASC,
	bin ASC,
	id DESC
