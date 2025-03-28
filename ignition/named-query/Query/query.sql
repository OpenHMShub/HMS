SELECT	STRING_AGG(p.programName,', ')
		FROM interaction.Program  p
		LEFT JOIN
			interaction.ProgramService ps ON p.id = ps.programId 
		--LEFT JOIN
		--	interaction.Program prg ON ppt.programId  = prg.id
		WHERE ps.serviceId  = :serviceId 
		GROUP BY ps.serviceId
		--AS 'programNames'