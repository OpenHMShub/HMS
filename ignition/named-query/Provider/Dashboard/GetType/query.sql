SELECT DISTINCT nationalProviderIdentifier
FROM organization.Provider 
WHERE nationalProviderIdentifier IS NOT NULL
	AND (ISNULL(nationalProviderIdentifier,'')) NOT LIKE '%Congregation%'
	AND (ISNULL(nationalProviderIdentifier,'')) NOT LIKE '%Presenter%'
	AND (ISNULL(nationalProviderIdentifier,'')) NOT LIKE ''
	AND (ISNULL(providerName,'')) NOT LIKE '%Congregation%'
	AND (ISNULL(providerName,'')) NOT LIKE '%Presenter%'
ORDER BY nationalProviderIdentifier  
