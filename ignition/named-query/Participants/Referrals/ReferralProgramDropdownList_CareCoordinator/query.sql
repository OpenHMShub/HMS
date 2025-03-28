---Participants/Referrals/ReferralProgramDropdownList---
SELECT
	p.id
	,p.programName
FROM
	[interaction].[Program] p
	LEFT JOIN interaction.ProgramProviderTypes pt ON p.id=pt.programId 
WHERE
 	{provider} AND p.timeRetired IS NULL
 	AND p.programName = 'Guest House'
GROUP BY p.id
		,p.programName
ORDER BY programName