---Participants/Referrals/ReferralProviderListSelect---
SELECT 
	id,providerTypeName
FROM 
	organization.ProviderType
WHERE
	providerTypeName = 'Law Enforcement'
	OR
	providerTypeName = 'Staff'