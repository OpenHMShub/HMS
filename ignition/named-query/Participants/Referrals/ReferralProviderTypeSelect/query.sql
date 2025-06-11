---Participants/Referrals/ReferralProviderListSelect---
SELECT 
	id,providerTypeName
FROM 
	organization.ProviderType
WHERE
	providerTypeName != 'Insurance'
	AND
	providerTypeName != 'Presenter-Volunteer'