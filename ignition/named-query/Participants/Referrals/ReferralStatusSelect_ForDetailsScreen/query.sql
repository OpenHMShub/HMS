SELECT
	  id as 'id',
	  ReferralStatusName as 'Referral Status'
FROM  
	participant.ReferralStatus 
WHERE ReferralStatusName not in ('Received') 
order by ReferralStatusName