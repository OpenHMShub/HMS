---Participants/LawEnforcementDropdownList---
SELECT
	[organization].[Provider].id,
	[organization].[Provider].providerName as 'provider_name'
FROM
	[organization].[Provider]
	INNER JOIN [organization].[LawEnforcement] on [organization].[LawEnforcement].providerId = [organization].[Provider].Id